@AbapCatalog.sqlViewName: 'ZITRAVEL_U'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel view - CDS data model'

define root view ZI_Travel_U
  as select from /dmo/travel as Travel -- the travel table is the data source for this view

  composition [0..*] of ZI_Booking_U as _Booking

  association [0..1] to ZI_Agency    as _Agency   on $projection.AgencyID = _Agency.AgencyID
  association [0..1] to ZI_Customer  as _Customer on $projection.CustomerID = _Customer.CustomerID
  association [0..1] to I_Currency       as _Currency on $projection.CurrencyCode = _Currency.Currency

{
  key Travel.travel_id     as TravelID,

      Travel.agency_id     as AgencyID,

      Travel.customer_id   as CustomerID,

      Travel.begin_date    as BeginDate,

      Travel.end_date      as EndDate,
    
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.booking_fee   as BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.total_price   as TotalPrice,

      @Semantics.currencyCode: true
      Travel.currency_code as CurrencyCode,

      Travel.description   as Memo,

      Travel.status        as Status,

      Travel.lastchangedat as LastChangedAt,

      /* Associations */
      _Booking,
      _Agency,
      _Customer,
      _Currency
}
