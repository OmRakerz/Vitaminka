import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/models/cart_model.dart';
import 'package:pharmacy/providers/cart_provider.dart';
import 'package:pharmacy/widgets/subtitles_text.dart';
import 'package:provider/provider.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  final CartModel cartModel;
  const QuantityBottomSheetWidget({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  cartProvider.updateQuantity(
                    productId: cartModel.productId,
                    quantity: index + 1,
                  );
                  Navigator.pop(context);
                },
                child: Center(
                  child: SubtitileTextWidget(
                    label: "${index + 1}",
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
