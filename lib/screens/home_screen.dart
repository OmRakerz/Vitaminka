import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/consts/app_constants.dart';
import 'package:pharmacy/providers/product_provider.dart';
import 'package:pharmacy/services/assets_manager.dart';
import 'package:pharmacy/widgets/app_name_text.dart';
import 'package:pharmacy/widgets/products/ctg_rounded_widget.dart';
import 'package:pharmacy/widgets/products/latest_arrival_products_widget.dart';
import 'package:pharmacy/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(),
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        // Добавил от себя
        leadingWidth: 35,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return Image.asset(
                      AppConstants.bannersImages[index],
                    );
                  },
                  itemCount: AppConstants.bannersImages.length,
                  autoplay: true,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TitleTextWidget(
                label: "Последнее поступление",
                fontSize: 20,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                        value: productProvider.getProducts[index],
                        child: const LatesteArrivalProductsWidget());
                  },
                ),
              ),
              const TitleTextWidget(
                label: "Категории",
                fontSize: 22,
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children:
                    List.generate(AppConstants.categoriesList.length, (index) {
                  return CategoryRoundedWidget(
                    image: AppConstants.categoriesList[index].images,
                    name: AppConstants.categoriesList[index].name,
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
