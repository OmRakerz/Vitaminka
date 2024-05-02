import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/consts/app_constants.dart';
import 'package:pharmacy/consts/theme_data.dart';
import 'package:pharmacy/providers/cart_provider.dart';
import 'package:pharmacy/providers/product_provider.dart';
import 'package:pharmacy/providers/theme_provider.dart';
import 'package:pharmacy/providers/user_provider.dart';
import 'package:pharmacy/providers/viewed_prod_provider.dart';
import 'package:pharmacy/providers/wishlist_provider.dart';
import 'package:pharmacy/root_screen.dart';
import 'package:pharmacy/screens/auth/forgot_pasword.dart';
import 'package:pharmacy/screens/auth/login.dart';
import 'package:pharmacy/screens/auth/register.dart';
import 'package:pharmacy/screens/inner_screens/orders/orders_screen.dart';
import 'package:pharmacy/screens/inner_screens/products_details.dart';
import 'package:pharmacy/screens/inner_screens/viewed_resently.dart';
import 'package:pharmacy/screens/inner_screens/wishlist_screen.dart';
import 'package:pharmacy/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Этот виджет является корнем приложения
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: AppConstants.apiKey,
          appId: AppConstants.appId,
          messagingSenderId: AppConstants.messagingSenderId,
          projectId: AppConstants.projectId,
          storageBucket: AppConstants.storageBucket,
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SelectableText(snapshot.error.toString()),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return ThemeProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return ProductProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return CartProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return WishlistProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return ViewedProdProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return UserProvider();
            }),
          ],
          child:
              Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Vитаминка',
              theme: Styles.themeData(
                  isDarkTheme: themeProvider.getIsDarkTheme, context: context),
              // home: const RootScreen(),
              home: const LoginScreen(),
              routes: {
                RootScreen.routeName: (context) => const RootScreen(),
                ProductDetails.routeName: (context) => const ProductDetails(),
                WishlistScreen.routeName: (context) => const WishlistScreen(),
                ResentlyViewedScreen.routeName: (context) =>
                    const ResentlyViewedScreen(),
                RegisterScreen.routeName: (context) => const RegisterScreen(),
                LoginScreen.routeName: (context) => const LoginScreen(),
                OrdersScreenFree.routeName: (context) =>
                    const OrdersScreenFree(),
                ForgotPasswordScreen.routeName: (context) =>
                    const ForgotPasswordScreen(),
                SearchScreen.routeName: (context) => const SearchScreen(),
              },
            );
          }),
        );
      },
    );
  }
}
