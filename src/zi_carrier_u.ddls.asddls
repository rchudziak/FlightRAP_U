@AbapCatalog.sqlViewName: 'ZICARRIER_REU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Carrier view'

define view ZI_Carrier_U as select from /dmo/carrier as Airline 
{ 
  key Airline.carrier_id        as AirlineID, 
  
  @Semantics.text: true
  Airline.name                  as Name, 
  
  @Semantics.currencyCode: true
  Airline.currency_code         as CurrencyCode    
}   
