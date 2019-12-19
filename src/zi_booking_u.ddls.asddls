@AbapCatalog.sqlViewName: 'ZIBOOKING_U'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking view'


define view ZI_Booking_U
  as select from /dmo/booking as Booking

  association        to parent ZI_Travel_U     as _Travel     on  $projection.TravelID = _Travel.TravelID
  composition [0..*] of ZI_BookingSupplement_U as _BookSupplement

  association [1..1] to ZI_Customer            as _Customer   on  $projection.CustomerID = _Customer.CustomerID
  association [1..1] to ZI_Carrier_U             as _Carrier    on  $projection.AirlineID = _Carrier.AirlineID
  association [1..1] to ZI_Connection          as _Connection on  $projection.AirlineID    = _Connection.AirlineID
                                                                  and $projection.ConnectionID = _Connection.ConnectionID
{

  key Booking.travel_id     as TravelID,

  key Booking.booking_id    as BookingID,

      Booking.booking_date  as BookingDate,

      Booking.customer_id   as CustomerID,

      Booking.carrier_id    as AirlineID,

      Booking.connection_id as ConnectionID,

      Booking.flight_date   as FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Booking.flight_price  as FlightPrice,

      @Semantics.currencyCode: true
      Booking.currency_code as CurrencyCode,

      _Travel.LastChangedAt as LastChangedAt, -- Take over ETag from parent

      /* Associations */
      _Travel,
      _BookSupplement,
      _Customer,
      _Carrier,
      _Connection

}
