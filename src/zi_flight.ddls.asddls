@AbapCatalog.sqlViewName: 'ZIFLIGHT_RE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight view'

define view ZI_Flight as select from /dmo/flight as Flight
{ 
 
    key Flight.carrier_id          as AirlineID, 
    key Flight.connection_id       as ConnectionID, 
    key Flight.flight_date         as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'  
    Flight.price                   as Price, 
    @Semantics.currencyCode: true
    Flight.currency_code           as CurrencyCode, 
    Flight.plane_type_id           as PlaneType, 
    Flight.seats_max               as MaximumSeats, 
    Flight.seats_occupied          as OccupiedSeats
}
