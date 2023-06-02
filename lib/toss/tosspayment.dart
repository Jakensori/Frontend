import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:temp_project/const/colors.dart';
import 'package:temp_project/smart_contract.dart';
//import 'package:temp_project/toss/mockserver.dart';
import 'package:temp_project/toss/order_widget.dart';
import 'package:temp_project/toss/product.dart';
import 'package:temp_project/toss/product_request.dart';
import 'package:temp_project/toss/product_wiget.dart';
import 'package:toss_payment/toss_payment.dart';

/*void main() async {
  /// 예시를 위해 만든 mock server 입니다.
  //await MockServer.startServer();

  runApp(const MyApp());
}*/

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Toss Payment Demo',
//       theme: ThemeData(
//         primaryColor: Color(0xffFFC646),
//       ),
//       home: const TossPaymentPage(title: '기부금 결제하기'),
//     );
//   }
// }

class TossPaymentPage extends StatefulWidget {
  final String? foundation;
  final int? money;

  const TossPaymentPage(
      {required this.foundation, required this.money, Key? key})
      : super(key: key);

  @override
  State<TossPaymentPage> createState() => _TossPaymentPageState();
}

class _TossPaymentPageState extends State<TossPaymentPage> {
  String fnd = '';
  int money = 0;

  @override
  void initState() {
    fnd = widget.foundation!;
    money = widget.money!;
  }

  late final Product _product = Product(price: money, name: fnd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Center(
          child: Text(
            '결제하기',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: BLACK_COLOR,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Center(
              child: ProductWidget(
                product: _product,
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 6,
            childAspectRatio: 2 / 0.75,
            children: List.generate(8, (index) {
              Widget ret = Container(
                width: 20.0,
                height: 30,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: GREY_COLOR),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              );

              switch (index) {
                case 0:
                  ret = OrderWidget(
                    title: '카드',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '카드',
                  );
                  break;
                case 1:
                  ret = OrderWidget(
                    title: '카드 자동결제',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '카드자동결제',
                  );
                  break;
                case 2:
                  ret = OrderWidget(
                    title: '카드 앱 바로 열기',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '카드앱바로열기',
                  );
                  break;
                case 3:
                  ret = OrderWidget(
                    title: '가상계좌',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '가상계좌',
                  );
                  break;
                case 4:
                  ret = OrderWidget(
                    title: '계좌이체',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '계좌이체',
                  );
                  break;
                case 5:
                  ret = OrderWidget(
                    title: '휴대폰',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '휴대폰',
                  );
                  break;
                case 6:
                  ret = OrderWidget(
                    title: '도서문화상품권',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '도서문화상품권',
                  );
                  break;
                case 7:
                  ret = OrderWidget(
                    title: '토스결제',
                    product: _product,
                    onTap: (request) {
                      _showPayment(context, request);
                    },
                    payBy: '토스결제',
                  );
                  break;
              }
              return ret;
            }),
          ),
        ]),
      ),
    );
  }

  _showPayment(BuildContext context, PaymentRequest request) async {
    var ret = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (context) {
          bool success = false;
          return Container(
            margin: const EdgeInsets.only(top: 110),
            child: PaymentWebView(
              title: _product.name,
              paymentRequestUrl: request.url,
              onPageStarted: (url) {
                dev.log('onPageStarted.url = $url', name: "PaymentWebView");
              },
              onPageFinished: (url) {
                dev.log('onPageFinished.url = $url', name: "PaymentWebView");
                // TODO something to decide the payment is successful or not.
                success = url.contains('approve');
              },
              onDisposed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SmartContract(title: 'no')),
                    (route) => false);
              },
              onTapCloseButton: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SmartContract(title: 'no')),
                    (route) => false);
                //Navigator.of(context).pop(success);
              },
            ),
          );
        });
    dev.log('ret = $ret', name: '_showPayment');
  }
}

extension PaymentRequestExtension on PaymentRequest {
  Uri get url {
    // TODO 토스페이를 위해 만든 Web 주소를 넣어주세요. 아래는 예시입니다.
    print(json);
    return Uri.https("pass-meal.site", "donation/request/", json);
  }
}
