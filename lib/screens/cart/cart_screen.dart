import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:pharmacy/providers/cart_provider.dart';
import 'package:pharmacy/screens/cart/cart_bottom_checkout.dart';
import 'package:pharmacy/screens/cart/cart_widget.dart';
import 'package:pharmacy/services/assets_manager.dart';
import 'package:pharmacy/services/my_app_methods.dart';
import 'package:pharmacy/widgets/empty_widget_bag.dart';
import 'package:pharmacy/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Ваша корзина пуста!",
              subtitle: "Добавьте интересующие \nвас товары из каталога",
              buttonText: "Купить сейчас",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialog(
                        isError: false,
                        context: context,
                        subtitles: "Удалить предметы",
                        fct: () {
                          cartProvider.clearLocalCart();
                        });
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                    color: Colors.red,
                  ),
                )
              ],
              title: TitleTextWidget(
                  label: "Корзина (${cartProvider.getCartItems.length})"),
              leading: Image.asset(AssetsManager.shoppingCart),
              // Добавил от себя
              leadingWidth: 35,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values
                            .toList()
                            .reversed
                            .toList()[index],
                        child: const CartWidget(),
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomSheet: const CartBottomCheckout(),
          );
  }
}
