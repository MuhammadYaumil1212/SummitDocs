class ReceiptEntity {
  final String receivedFrom;
  final String amount;
  final String inPaymentOf;
  final String paymentDate;
  final String invoiceNo;
  final String conferenceTitle;
  final String UserconferenceTitle;
  final String placeAndDate;

  ReceiptEntity(
    this.receivedFrom,
    this.amount,
    this.inPaymentOf,
    this.paymentDate,
    this.invoiceNo,
    this.conferenceTitle,
    this.UserconferenceTitle,
    this.placeAndDate,
  );
}
