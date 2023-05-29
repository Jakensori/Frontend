import 'package:flutter/cupertino.dart';
import 'package:temp_project/const/colors.dart';
import 'package:temp_project/toss/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 320.0,
      decoration: BoxDecoration(
        border: Border.all(color: GREY_COLOR),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${product.name} 에게',
            style: const TextStyle(fontSize: 20, color: BLACK_COLOR),
          ),
          SizedBox(height: 15),
          //Container(height: 1.0, width: 320.0, color: GREY_COLOR),
          SizedBox(height: 15),
          Text(
            '${product.price} 원',
            style: const TextStyle(
                fontSize: 30, color: BLACK_COLOR, fontWeight: FontWeight.w400),
          ),
          //SizedBox(height: 15),
        ],
      ),
    );
  }
}
