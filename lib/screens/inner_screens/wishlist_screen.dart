import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/providers/wishlist_provider.dart';
import 'package:pharmacy/services/assets_manager.dart';
import 'package:pharmacy/services/my_app_methods.dart';
import 'package:pharmacy/widgets/empty_widget_bag.dart';
import 'package:pharmacy/widgets/products/products_widget.dart';
import 'package:pharmacy/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return wishlistProvider.getWishlistItems.isEmpty
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
                      "Избранное (${wishlistProvider.getWishlistItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              // Добавил от себя
              leadingWidth: 35,

              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialog(
                      isError: false,
                      context: context,
                      subtitles: "Удалить предметы?",
                      fct: () {
                        wishlistProvider.clearLocalWishlist();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishlistProvider.getWishlistItems.length,
              builder: (context, index) {
                return ProductWidget(
                  productId: wishlistProvider.getWishlistItems.values
                      .toList()[index]
                      .productId,
                );
              },
              crossAxisCount: 2,
            ),
          );
  }
}
