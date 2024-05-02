import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/models/products_model.dart';
import 'package:pharmacy/providers/viewed_prod_provider.dart';
import 'package:pharmacy/screens/inner_screens/products_details.dart';
import 'package:pharmacy/widgets/products/heart_btn_widget.dart';
import 'package:pharmacy/widgets/subtitles_text.dart';
import 'package:provider/provider.dart';

class LatesteArrivalProductsWidget extends StatelessWidget {
  const LatesteArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productsModel = Provider.of<ProductModel>(context);
    final viewedProvider = Provider.of<ViewedProdProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProvider.addProductToHistory(
              productId: productsModel.productId);

          await Navigator.pushNamed(
            context,
            ProductDetails.routeName,
            arguments: productsModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: productsModel.productImage,
                    width: size.width * 0.30,
                    height: size.width * 0.30,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productsModel.productTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        HeartButtonWidget(
                          productId: productsModel.productId,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    child: SubtitileTextWidget(
                      label: "${productsModel.productPrice}\₽",
                      color: Colors.blue,
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
