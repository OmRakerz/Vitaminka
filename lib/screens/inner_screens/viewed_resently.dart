import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/providers/viewed_prod_provider.dart';
import 'package:pharmacy/services/assets_manager.dart';
import 'package:pharmacy/widgets/empty_widget_bag.dart';
import 'package:pharmacy/widgets/products/products_widget.dart';
import 'package:pharmacy/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class ResentlyViewedScreen extends StatelessWidget {
  static const routeName = "/ResentlyViewedScreen";
  const ResentlyViewedScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return viewedProdProvider.getviewedProdItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "В списке желаний пока ничего нет",
              subtitle: "Добавьте интересующие \nвас товары из каталога",
              buttonText: "Купить сейчас",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleTextWidget(
                  label:
                      "Недавно просмотренные (${viewedProdProvider.getviewedProdItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              // Добавил от себя
              leadingWidth: 35,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: viewedProdProvider.getviewedProdItems.length,
              builder: (context, index) {
                return ProductWidget(
                  productId: viewedProdProvider.getviewedProdItems.values
                      .toList()[index]
                      .productId,
                );
              },
              crossAxisCount: 2,
            ),
          );
  }
}
