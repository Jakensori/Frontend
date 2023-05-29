class PaymentRequest {
  final String payBy;
  int? amount;
  String? orderId;
  String? orderName;
  String? customerName;
  String? successUrl;
  String? failUrl;

  // billing auth
  String? customerKey;

  // card direct
  String? flowMode;
  String? cardCompany;

  // virtual account
  int? validHours;
  Map<String, String>? cashReceipt;

  // account transfer
  String? bank;

  PaymentRequest({
    required this.payBy,
    this.amount,
    //this.orderId,
    this.orderName,
    this.customerName,
    this.successUrl,
    this.failUrl,

    // billing auth
    this.customerKey,

    // card direct
    this.flowMode,
    this.cardCompany,

    // virtual account
    // this.validHours,
    // this.cashReceipt,
    // account transfer
    this.bank,
  });

  Map<String, dynamic> get json {
    Map<String, dynamic> ret = {};

    ret.addAll({"pay_by": payBy});

    if (amount != null) {
      ret.addAll({"amount": "$amount"});
    }

    if (orderId != null) {
      ret.addAll({"order_id": orderId});
    }
    if (orderName != null) {
      ret.addAll({"order_name": orderName});
    }
    if (customerName != null) {
      ret.addAll({"customer_name": customerName});
    }
    if (customerKey != null) {
      ret.addAll({"customer_key": customerKey});
    }
    if (flowMode != null) {
      ret.addAll({"flow_mode": flowMode});
    }
    if (cardCompany != null) {
      ret.addAll({"card_company": cardCompany});
    }
    // if (validHours != null) {
    //   ret.addAll({"valid_hours": "$validHours"});
    // }
    // if (cashReceipt != null) {
    //   ret.addAll({"cash_receipt": cashReceipt});
    // }

    if (bank != null) {
      ret.addAll({"bank": bank});
    }

    return ret;
  }

  factory PaymentRequest.card(
      {required int amount,
      //required String orderId,
      required String orderName,
      required String customerName,
      required}) {
    return PaymentRequest(
      payBy: "카드",
      amount: amount,
      //orderId: orderId,
      orderName: orderName,
      customerName: customerName,
      //successUrl: "http://52.78.205.224:8000/donation/approve/",
      //failUrl: "http://52.78.205.224:8000/donation/fail/",
    );
  }

  static PaymentRequest? fromJson(json) {
    PaymentRequest? ret;
    switch (json['pay_by']) {
      case "카드":
        ret = PaymentRequest.card(
            amount: int.parse(json['amount']),
            //orderId: json['order_id'],
            orderName: json['order_name'],
            customerName: json['customer_name']);
        break;
      // case "카드자동결제":
      //   ret = PaymentRequest.billingAuth(customerKey: json['customer_key']);
      //   break;
      // case "카드앱바로열기":
      //   ret = PaymentRequest.cardDirect(
      //       amount: int.parse(json['amount']),
      //       orderId: json['order_id'],
      //       orderName: json['order_name'],
      //       customerName: json['customer_name'],
      //       cardCompany: json['card_company']);
      //   break;
      // case "가상계좌":
      //   ret = PaymentRequest.virtualAccount(
      //       amount: int.parse(json['amount']),
      //       orderId: json['order_id'],
      //       orderName: json['order_name'],
      //       customerName: json['customer_name']);
      //   break;
      // case "계좌이체":
      //   ret = PaymentRequest.accountTransfer(
      //       amount: int.parse(json['amount']),
      //       orderId: json['order_id'],
      //       orderName: json['order_name'],
      //       customerName: json['customer_name'],
      //       bank: json['bank']);
      //   break;
      // case "휴대폰":
      //   ret = PaymentRequest.phone(
      //       amount: int.parse(json['amount']),
      //       orderId: json['order_id'],
      //       orderName: json['order_name'],
      //       customerName: json['customer_name']);
      //   break;
      // case "도서문화상품권":
      //   ret = PaymentRequest.giftCard(
      //       amount: int.parse(json['amount']),
      //       orderId: json['order_id'],
      //       orderName: json['order_name'],
      //       customerName: json['customer_name']);
      //   break;

      // case "토스결제":
      //   ret = PaymentRequest.tossPay(
      //       amount: int.parse(json['amount']),
      //       orderId: json['order_id'],
      //       orderName: json['order_name'],
      //       customerName: json['customer_name']);
      //   break;
    }
    return ret;
  }
}
