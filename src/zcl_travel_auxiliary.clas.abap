CLASS zcl_travel_auxiliary DEFINITION
  INHERITING FROM cl_abap_behv
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES tt_travel_failed              TYPE TABLE FOR FAILED   zi_travel_u.
    TYPES tt_travel_mapped              TYPE TABLE FOR MAPPED   zi_travel_u.
    TYPES tt_travel_reported            TYPE TABLE FOR REPORTED zi_travel_u.


    TYPES tt_booking_failed     TYPE TABLE FOR FAILED    zi_booking_u.
    TYPES tt_booking_mapped     TYPE TABLE FOR MAPPED    zi_booking_u.
    TYPES tt_booking_reported   TYPE TABLE FOR REPORTED  zi_booking_u.

    TYPES tt_bookingsupplement_failed   TYPE TABLE FOR FAILED    zi_bookingsupplement_u.
    TYPES tt_bookingsupplement_mapped   TYPE TABLE FOR MAPPED    zi_bookingsupplement_u.
    TYPES tt_bookingsupplement_reported TYPE TABLE FOR REPORTED  zi_bookingsupplement_u.


    CLASS-METHODS handle_travel_messages
      IMPORTING
        iv_cid       TYPE string   OPTIONAL
        iv_travel_id TYPE /dmo/travel_id OPTIONAL
        it_messages  TYPE /dmo/if_flight_legacy=>tt_message
      CHANGING
        failed       TYPE tt_travel_failed
        reported     TYPE tt_travel_reported.


    CLASS-METHODS handle_booking_messages
      IMPORTING
        iv_cid        TYPE string OPTIONAL
        iv_travel_id  TYPE /dmo/travel_id OPTIONAL
        iv_booking_id TYPE /dmo/booking_id OPTIONAL
        it_messages   TYPE /dmo/if_flight_legacy=>tt_message
      CHANGING
        failed        TYPE tt_booking_failed
        reported      TYPE tt_booking_reported.

    CLASS-METHODS handle_booksupplement_messages
      IMPORTING
        iv_cid                  TYPE string OPTIONAL
        iv_travel_id            TYPE /dmo/travel_id OPTIONAL
        iv_booking_id           TYPE /dmo/booking_id OPTIONAL
        iv_bookingsupplement_id TYPE /dmo/booking_supplement_id OPTIONAL
        it_messages             TYPE /dmo/if_flight_legacy=>tt_message
      CHANGING
        failed                  TYPE tt_bookingsupplement_failed
        reported                TYPE tt_bookingsupplement_reported.


  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA obj TYPE REF TO zcl_travel_auxiliary.

    CLASS-METHODS get_message_object
      RETURNING VALUE(r_result) TYPE REF TO zcl_travel_auxiliary.
ENDCLASS.



CLASS zcl_travel_auxiliary IMPLEMENTATION.
  METHOD handle_travel_messages.

    LOOP AT it_messages INTO DATA(ls_message) WHERE msgty = 'E' OR msgty = 'A'.
      APPEND VALUE #( %cid = iv_cid  travelid = iv_travel_id )
             TO failed.

      APPEND VALUE #( %msg      = get_message_object( )->new_message( id       = ls_message-msgid
                                               number   = ls_message-msgno
                                               severity = if_abap_behv_message=>severity-error
                                               v1       = ls_message-msgv1
                                               v2       = ls_message-msgv2
                                               v3       = ls_message-msgv3
                                               v4       = ls_message-msgv4 )
                      %key-TravelID = iv_travel_id
                      %cid          = iv_cid
                      TravelID      = iv_travel_id )
             TO reported.
    ENDLOOP.

  ENDMETHOD.

  METHOD handle_booking_messages.

    LOOP AT it_messages INTO DATA(ls_message) WHERE msgty = 'E' OR msgty = 'A'.
      APPEND VALUE #( %cid      = iv_cid
                      travelid  = iv_travel_id
                      bookingid = iv_booking_id ) TO failed.

      APPEND VALUE #( %msg = get_message_object( )->new_message(
                                          id       = ls_message-msgid
                                          number   = ls_message-msgno
                                          severity = if_abap_behv_message=>severity-error
                                          v1       = ls_message-msgv1
                                          v2       = ls_message-msgv2
                                          v3       = ls_message-msgv3
                                          v4       = ls_message-msgv4 )
                      %key-TravelID = iv_travel_id
                      %cid          = iv_cid
                      TravelID      = iv_travel_id
                      BookingID     = iv_booking_id ) TO reported.

    ENDLOOP.

  ENDMETHOD.

  METHOD handle_booksupplement_messages.

    LOOP AT it_messages INTO DATA(ls_message) WHERE msgty = 'E' OR msgty = 'A'.
      APPEND VALUE #( %cid      = iv_cid
                      travelid  = iv_travel_id
                      bookingid = iv_booking_id
                      bookingsupplementid  = iv_bookingsupplement_id
                    ) TO failed.

      APPEND VALUE #( %key-TravelID = iv_travel_id
                      %cid      = iv_cid
                      TravelID  = iv_travel_id
                      BookingID = iv_booking_id
                      %msg      = get_message_object( )->new_message(
                                               id       = ls_message-msgid
                                               number   = ls_message-msgno
                                               severity = if_abap_behv_message=>severity-error
                                               v1       = ls_message-msgv1
                                               v2       = ls_message-msgv2
                                               v3       = ls_message-msgv3
                                               v4       = ls_message-msgv4 )
                    ) TO reported.
    ENDLOOP.

  ENDMETHOD.



  METHOD get_message_object.

    IF obj IS INITIAL.
      CREATE OBJECT obj.
    ENDIF.
    r_result = obj.

  ENDMETHOD.
ENDCLASS.
