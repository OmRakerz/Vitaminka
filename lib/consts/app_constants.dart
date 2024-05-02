import 'package:pharmacy/models/category_models.dart';
import 'package:pharmacy/services/assets_manager.dart';

class AppConstants {
  static String productImageUrl =
      "https://medinstruktsija.ru/wp-content/uploads/2022/07/Ksilometazolin.jpg";

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: "Спреи",
      images: AssetsManager.spray,
      name: "Спреи",
    ),
    CategoryModel(
      id: "Витамины",
      images: AssetsManager.vitamin,
      name: "Витамины",
    ),
    CategoryModel(
      id: "Капли",
      images: AssetsManager.eye,
      name: "Капли",
    ),
    CategoryModel(
      id: "Приборы",
      images: AssetsManager.apparat,
      name: "Приборы",
    ),
    CategoryModel(
      id: "Препараты",
      images: AssetsManager.drug,
      name: "Препараты",
    ),
    CategoryModel(
      id: "Аптечка",
      images: AssetsManager.kit,
      name: "Аптечка",
    ),
    CategoryModel(
      id: "Капсулы",
      images: AssetsManager.joint,
      name: "Капсулы",
    ),
    CategoryModel(
      id: "Порошки",
      images: AssetsManager.powder,
      name: "Порошки",
    ),
  ];

  static String apiKey = "AIzaSyC8DIgXxI7b3Un1MPReE_YMCc8YMVEcXK8";
  static String appId = "1:858855528783:android:ba358479cde8f332d04d3a";
  static String messagingSenderId = "858855528783";
  static String projectId = "pharmacy-c19ff";
  static String storageBucket = "pharmacy-c19ff.appspot.com";
}
