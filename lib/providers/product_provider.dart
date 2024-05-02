import 'package:flutter/material.dart';
import 'package:pharmacy/models/products_model.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> get getProducts {
    return _products;
  }

  ProductModel? findByProdId(String productId) {
    if (_products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    return _products.firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> findByCategory({required String ctgName}) {
    List<ProductModel> ctgList = _products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(ctgName.toLowerCase()))
        .toList();

    return ctgList;
  }

  List<ProductModel> searchQuery(
      {required String searchText, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  final List<ProductModel> _products = [
    // Sprays
    ProductModel(
      //1
      productId: 'аква-марис-стронг',
      productTitle: "Аква марис стронг 30 мл",
      productPrice: "396.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nпредназначен для нанесения на слизистую оболочку носа для увлажнения слизистой оболочки и удаления выделений. Для уменьшения отека и облегчения носового дыхания при острых и хронических воспалительных и аллергических заболеваниях полости носа, придаточных пазух и носоглотки.  Для устранения отека слизистой оболочки полости носа, особенно у людей, страдающих повышенной чувствительностью к химическим лекарственным препаратам.",
      productImage:
          "https://images.apteka.ru/medium_aa8ccbae-6a94-455f-819d-0b508cc80e92.webp",
      productQuantity: "10",
    ),
    ProductModel(
      //2
      productId: 'Аквароса-50-мл',
      productTitle: "Аквароса+ 50 мл",
      productPrice: "378.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nПрименяется для профилактики острых и хронических воспалительных заболеваний полости носа, околоносовых пазух и носоглотки: -Острые и хронические риниты (насморк); -Острые и хронические синуситы; -Острые и хронические аденоидиты; -Аллергические и вазомоторные риниты, поллиноз; -Профилактика и комплексное лечение ОРВИ и гриппа.",
      productImage:
          "https://images.apteka.ru/medium_60f0ab9a-0fa7-4a95-a65b-be14b1fac6ba.webp",
      productQuantity: "15",
    ),
    ProductModel(
      //3
      productId: 'Олифрин 15 мл',
      productTitle: "Олифрин 15 мл",
      productPrice: "413.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nСредство может применяться у детей с 3-х лет и взрослых: • для создания защитного барьера и увлажнения слизистой оболочки носа; • для удаления избыточных выделений и образовавшихся в носовой полости корок; • для устранения симптоматических проявлений сухости (раздражение, зуд, жжение) слизистой оболочки носа, связанных с воздействием окружающей среды, сухого воздуха (кондиционирование, отопление) или послеоперационным заживлением.",
      productImage:
          "https://images.apteka.ru/medium_a5e8efc2-ca08-4462-895a-eb406d4d62f0.webp",
      productQuantity: "144",
    ),
    ProductModel(
      //4
      productId: const Uuid().v4(),
      productTitle: "Генферон лайт 50000 МЕ",
      productPrice: "602.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nПрофилактика и лечение гриппа и ОРВИ у взрослых и детей старше 14 лет.",
      productImage:
          "https://images.apteka.ru/medium_f3dfcd01-1c7a-4ffc-b0fe-92be2bef88b9.webp",
      productQuantity: "2363",
    ),
    ProductModel(
      //5
      productId: const Uuid().v4(),
      productTitle: "Отривин комплекс 84 мкг",
      productPrice: "396.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nСимптоматическое лечение отека и гиперемии носовой полости, острые респираторные заболевания с явлениями ринита (насморка), сопровождающегося заложенностью, острый аллергический ринит, поллиноз, синусит.",
      productImage:
          "https://images.apteka.ru/medium_cd3c2e6e-c91f-4a1d-bfb5-fa0f5ef9033a.webp",
      productQuantity: "3625",
    ),
    ProductModel(
      //6
      productId: const Uuid().v4(),
      productTitle: "Виброцил 35,125 мкг 15 мл",
      productPrice: "512.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nОстрый ринит (в т.ч., насморк при простудных заболеваниях); аллергический ринит (в т.ч. при сенной лихорадке); вазомоторный ринит; хронический ринит; острый и хронический синусит; острый средний отит (в качестве вспомогательного метода лечения). Подготовка к хирургическим вмешательствам в области носа и устранение отёка слизистой оболочки носа и придаточных пазух после хирургических вмешательств в этой области.",
      productImage:
          "https://images.apteka.ru/medium_2c6f0ee5-b5e9-448b-b61c-ce75a1d266a1.webp",
      productQuantity: "3636",
    ),

    ProductModel(
      //7
      productId: const Uuid().v4(),
      productTitle: "Снуп экстра 84 мкг 10 мл",
      productPrice: "204.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nОстрые респираторные заболевания с явлениями ринита (насморка), острый аллергический ринит, поллиноз, синусит, евстахиит, средний отит (в составе комбинированной терапии для уменьшения отека слизистой оболочки носоглотки).",
      productImage:
          "https://images.apteka.ru/medium_a95e426d-9b98-4ed9-9151-3990f0a01cbd.webp",
      productQuantity: "525",
    ),
    ProductModel(
      //8
      productId: const Uuid().v4(),
      productTitle: "ЗВЕЗДОЧКА НОЗ 0,1%",
      productPrice: "83.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nПрепарат ЗВЕЗДОЧКА НОЗ показан к применению у взрослых и детей с 6 лет. Он применяется для лечения острых респираторных заболеваний с явлениями ринита (насморка), острого аллергического ринита, поллиноза, синусита, евстахиита, среднего отита (в составе комбинированной терапии для уменьшения отека слизистой оболочки носоглотки).",
      productImage:
          "https://images.apteka.ru/medium_7573e947-189a-4084-a9ae-fecc1c3a761a.webp",
      productQuantity: "2526",
    ),
    ProductModel(
      //9
      productId: const Uuid().v4(),
      productTitle: "Отривин 140 мкг 10мл",
      productPrice: "203.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nОстрые респираторные заболевания с явлениями ринита (насморка), острый аллергический ринит, поллиноз, синусит, евстахиит, средний отит (в составе комбинированной терапии для уменьшения отека слизистой оболочки носоглотки).",
      productImage:
          "https://images.apteka.ru/original_88c4e1c2-9ec2-4599-a16e-3614141b0ed5.webp",
      productQuantity: "353",
    ),
    ProductModel(
      //10
      productId: const Uuid().v4(),
      productTitle: "Ринорус 0,1% 10 мл",
      productPrice: "104.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\n- острые респираторные заболевания с явлениями ринита (насморка), острый аллергический ринит, поллиноз, синусит, евстахиит, средний отит (в составе комбинированной терапии для уменьшения отека слизистой оболочки носоглотки);",
      productImage:
          "https://images.apteka.ru/medium_c9b2c638-5a3d-4236-83c4-e5629f4faf78.webp",
      productQuantity: "3873",
    ),
    ProductModel(
      //11
      productId: const Uuid().v4(),
      productTitle: "Ринофлуимуцил 10 мл",
      productPrice: "402.00",
      productCategory: "Спреи",
      productDescription:
          "Показания\nОстрый и подострый ринит с густым гнойно-слизистым секретом, хронический ринит, вазомоторный ринит, атрофический ринит, синусит.",
      productImage:
          "https://images.apteka.ru/medium_850a3faf-cb95-437e-9912-0e69ec6e28eb.webp",
      productQuantity: "62332",
    ),
    // Eyes
    // https://i.ibb.co/MDcGHsb/12-ASUS-ROG-Zephyrus-G15.jpg
    ProductModel(
      //12
      productId: const Uuid().v4(),
      productTitle: "Неттацин 0,3% капли глазные 5 мл",
      productPrice: "359.00",
      productCategory: "Капли",
      productDescription:
          "Показания\nМестное применение для лечения инфекций век и наружных отделов глаза, вызванных чувствительными к нетилмицину микроорганизмами.",
      productImage:
          "https://images.apteka.ru/medium_ea94cd7b-58ce-4742-a379-a55526e6cf15.webp",
      productQuantity: "525",
    ),
    ProductModel(
      //13
      productId: const Uuid().v4(),
      productTitle: "Офтолик капли глазные 10 мл",
      productPrice: "622.00",
      productCategory: "Капли",
      productDescription:
          "Показания\n1. Чувство жжения, раздражения и дискомфорта, вызванные сухостью глаза. 2. В качестве заменителей слезы в случае снижения секреции слёзной жидкости. 3. Синдром «сухого» глаза или любые другие состояния, требующие смягчения и увлажнения роговицы.",
      productImage:
          "https://images.apteka.ru/medium_b9982714-6e47-42b9-a35c-537a95b60b8f.webp",
      productQuantity: "5353",
    ),
    ProductModel(
      //14
      productId: const Uuid().v4(),
      productTitle: "Олопатин 1 мг/мл капли глазные 5 мл",
      productPrice: "300.00",
      productCategory: "Капли",
      productDescription:
          "Показания\nСимптоматическое лечение сезонного аллергического конъюнктивита.",
      productImage:
          "https://images.apteka.ru/medium_f503210a-00cd-4641-9c57-1bc76a9178e6.webp",
      productQuantity: "5335",
    ),
    ProductModel(
      //15
      productId: const Uuid().v4(),
      productTitle: "Офтан катахром капли глазные 10 мл",
      productPrice: "471.00",
      productCategory: "Капли",
      productDescription: "Показания\nКатаракта различного генеза.",
      productImage:
          "https://images.apteka.ru/medium_0d4d846d-6509-449b-adf5-f7a18e8a4466.webp",
      productQuantity: "2599",
    ),

    // Apparats
    ProductModel(
      //16
      productId: const Uuid().v4(),
      productTitle: "Глюкометр контур плюс уан",
      productPrice: "1601.00",
      productCategory: "Приборы",
      productDescription: "Показания\nДля определения уровня глюкозы в крови",
      productImage:
          "https://images.apteka.ru/medium_efa442da-2605-4ab9-a129-0765461ae21b.webp",
      productQuantity: "535352",
    ),
    ProductModel(
      //17
      productId: const Uuid().v4(),
      productTitle: "Тонометр UA-1200AC автомат с адаптером",
      productPrice: "5017.00",
      productCategory: "Приборы",
      productDescription:
          "Показания\nПрибор предназначен для применения в качестве индивидуального средства контроля артериального давления и частоты пульса, а также для динамических наблюдений за этими параметрами в медицинских учреждениях",
      productImage:
          "https://images.apteka.ru/medium_3d7a736f-8d69-4ce1-a8a7-6ccd0cdbd54e.webp",
      productQuantity: "252",
    ),
    ProductModel(
      //18
      productId: const Uuid().v4(),
      productTitle:
          "Тонометр UA-888E эконом автомат без адаптера манжета 22-32 см",
      productPrice: "1776.00",
      productCategory: "Приборы",
      productDescription:
          "Показания\nUA-888 - автоматический цифровой прибор, предназначенный для измерения величин систолического (верхнего), диастолического (нижнего) давления и частоты сердечных сокращений (пульса).",
      productImage:
          "https://images.apteka.ru/medium_00ba1cb6-eaad-43e0-940f-cb5cd4a95e7c.webp",
      productQuantity: "526",
    ),
    ProductModel(
      //19
      productId: const Uuid().v4(),
      productTitle: "Тонометр pro-39 автомат на запястье",
      productPrice: "1608.00",
      productCategory: "Приборы",
      productDescription:
          "Показания\nПрибор для измерения артериального давления и частоты пульса модели PRO-39 с принадлежностями предназначен для косвенного измерения систолического и диастолического артериального давления крови и частоты сердечных сокращений осциллометрическим способом. ",
      productImage:
          "https://images.apteka.ru/medium_7540ae5d-ba64-4ee4-b8e1-c8c19fc5862f.webp",
      productQuantity: "58385",
    ),
    // Drugs
    ProductModel(
      //20
      productId: const Uuid().v4(),
      productTitle: "Амбробене 0,0075/мл раствор для приема внутрь 100 мл",
      productPrice: "173.00",
      productCategory: "Препараты",
      productDescription:
          "Показания\nОстрые и хронические заболевания дыхательных путей, сопровождающиеся нарушением образования и отхождения мокроты",
      productImage:
          "https://images.apteka.ru/medium_0e4a9e3a-ca43-43ce-a077-b4fbc8395daa.webp",
      productQuantity: "7544",
    ),
    ProductModel(
      //21
      productId: const Uuid().v4(),
      productTitle: "Микстура мелиген-бронхо 1,7 г 15 шт.",
      productPrice: "110.00",
      productCategory: "Препараты",
      productDescription:
          "Показания\nв качестве БАД к пище - дополнительного источника витамина С, источника флавонондов и глицирризино-вой кислоты.",
      productImage:
          "https://images.apteka.ru/medium_f4da6a70-bbf7-448c-923c-e815de0a0ad7.webp",
      productQuantity: "7654",
    ),
    ProductModel(
      //22
      productId: const Uuid().v4(),
      productTitle: "Нормомед 50 мг/мл сироп 240 мл",
      productPrice: "55.12",
      productCategory: "Препараты",
      productDescription:
          "Показания\nЛечение гриппа и других ОРВИ в составе комплексной терапии. Лечение лабиального герпеса (Herpes simplex) в составе комплексной терапии.",
      productImage:
          "https://images.apteka.ru/medium_8808db3e-2e6b-42ea-8ec1-6340eee9fd74.webp",
      productQuantity: "36437",
    ),
    ProductModel(
      //23
      productId: const Uuid().v4(),
      productTitle: "Гербион сироп исландского мха сироп 150 мл",
      productPrice: "401.00",
      productCategory: "Препараты",
      productDescription:
          "Показания\nДанный препарат растительного происхождения, применяется для облегчения: - сухого, раздражающего кашля - осиплости и боли в горле.",
      productImage:
          "https://images.apteka.ru/medium_a1a5946e-cdd3-4bc6-a923-0934b0fe4940.webp",
      productQuantity: "36637",
    ),
    ProductModel(
      //24
      productId: const Uuid().v4(),
      productTitle: "Микстура от кашля для взрослых сухая порошок пакет 10 шт",
      productPrice: "106.00",
      productCategory: "Препараты",
      productDescription:
          "Показания\nЗаболевания дыхательных путей, сопровождающиеся кашлем с трудно отделяемой мокротой (трахеит, бронхит, бронхопневмония).",
      productImage:
          "https://images.apteka.ru/medium_dd6b1289-049c-4262-816c-83368b1d99d6.webp",
      productQuantity: "3637",
    ),
    ProductModel(
      //25
      productId: const Uuid().v4(),
      productTitle: "Доктор мом сироп 150 мл",
      productPrice: "377.00",
      productCategory: "Препараты",
      productDescription:
          "Показания\nСимптоматическая терапия острых и хронических заболеваний дыхательных путей, сопровождающихся сухим кашлем или кашлем с трудноотделяемой мокротой (фарингит, ларингит, в том числе лекторский, трахеит, бронхит).",
      productImage:
          "https://images.apteka.ru/medium_22009cf2-8c3a-401b-8bdd-5e6dd5a16711.webp",
      productQuantity: "8565",
    ),
    ProductModel(
      //26
      productId: const Uuid().v4(),
      productTitle: "Расторопша биокор 60 шт. таблетки",
      productPrice: "137.00",
      productCategory: "Препараты",
      productDescription:
          "Показания\nв качестве биологически активной добавки к пище - источника флаволигнанов.",
      productImage:
          "https://images.apteka.ru/medium_02e5bf41-8f30-498d-9d1c-4d15ce201a68.webp",
      productQuantity: "6437",
    ),
    ProductModel(
      //27
      productId: const Uuid().v4(),
      productTitle: "Глицин таблетки 50 шт 102 мг",
      productPrice: "86.00",
      productCategory: "Препараты",
      productDescription:
          "Показания\nВ качестве биологически активной добавки к пище - дополнительного источника глицина.",
      productImage:
          "https://images.apteka.ru/medium_eac4a768-af9d-44ab-936c-5d0938424572.webp",
      productQuantity: "7853",
    ),
    ProductModel(
      //28
      productId: const Uuid().v4(),
      productTitle: "Спаржа/шатавари таблетки 60 шт 500 мг",
      productPrice: "401.00",
      productCategory: "Препараты",
      productDescription:
          "Показания\nВ качестве биологически активной добавки к пище, источника флавоноидов, содержащей полифенольные соединения и сапонины;",
      productImage:
          "https://images.apteka.ru/medium_1904eb5d-df09-49ef-94c3-72affb63e86c.webp",
      productQuantity: "474",
    ),
    // Joints
    ProductModel(
      //29
      productId: const Uuid().v4(),
      productTitle: "Артра актив 25 мл 14 шт",
      productPrice: "2254.00",
      productCategory: "Капсулы",
      productDescription:
          "Показания\nВ качестве биологически активной добавки к пище - содержащей коллаген, дополнительного источника витаминов D3, C, В6, селена, марганца",
      productImage:
          "https://images.apteka.ru/medium_6533cc60-6cae-42db-a2d6-02e789bc5e73.webp",
      productQuantity: "7436",
    ),
    ProductModel(
      //30
      productId: const Uuid().v4(),
      productTitle: "Primebar коллаген микс 200 гр порошок",
      productPrice: "474.00",
      productCategory: "Капсулы",
      productDescription:
          "Показания\nВ качестве дополнительного источника витамина С, способствует улучшению прочности костей, суставов, сухожилий, связок, волос, ногтей и других тканей организма.",
      productImage:
          "https://images.apteka.ru/medium_bf96d99c-789a-4efb-9128-8028173857ef.webp",
      productQuantity: "3637",
    ),
    ProductModel(
      //31
      productId: const Uuid().v4(),
      productTitle: "Пиакартил 30 шт. капсулы массой 300 мг",
      productPrice: "1089.00",
      productCategory: "Капсулы",
      productDescription:
          "Показания\nВ качестве биологически активной добавки к пище - дополнительного источника фитостеринов: бета-Ситостерина и стигмастерина.",
      productImage:
          "https://images.apteka.ru/medium_79bae7ec-1ef0-4187-b39b-03f4cd194e4e.webp",
      productQuantity: "347343",
    ),
    ProductModel(
      //32
      productId: const Uuid().v4(),
      productTitle: "Дона 750 мг 60 шт",
      productPrice: "1972.00",
      productCategory: "Капсулы",
      productDescription:
          "Показания\nОстеоартроз периферических суставов и позвоночника, остеохондроз",
      productImage:
          "https://images.apteka.ru/medium_852c42c9-2864-4c9f-96ae-b1ca1807b8a1.webp",
      productQuantity: "7585",
    ),
    ProductModel(
      //33
      productId: const Uuid().v4(),
      productTitle:
          "Звездочка-прополис с ароматом мед-лимон 18 шт. таблетки по 2,5 г",
      productPrice: "148.00",
      productCategory: "Препарат",
      productDescription:
          "Показания\nВ качестве биологически активной добавки к пище - источника ментола, флавонов.",
      productImage:
          "https://images.apteka.ru/medium_9ea883db-9aef-4d93-92bc-14b56c491d15.webp",
      productQuantity: "47548",
    ),
    ProductModel(
      //34
      productId: const Uuid().v4(),
      productTitle: "Орвис таблетки для горла 40 шт по 0,5 г",
      productPrice: "383.00",
      productCategory: "Препарат",
      productDescription:
          "Показания\nв качестве биологически активной добавки к пище - дополнительного источника витамина С, источника ментола. Комплекс эфирных масел обладает противомикробным действием. Способствует улучшению состояния верхних дыхательных путей и горла, снятию раздражения (першения) в горле, облегчению дыхания и глотания.",
      productImage:
          "https://images.apteka.ru/medium_c4a645e1-a61e-4f97-866d-6466dcdcb152.webp",
      productQuantity: "7485",
    ),
    ProductModel(
      //35
      productId: const Uuid().v4(),
      productTitle: "Таблетки успокаивающие травы 30 шт.",
      productPrice: "209.00",
      productCategory: "Препарат",
      productDescription:
          "Показания\nВ качестве биологически активной добавки к пище, содержащей дубильные вещества и флавоноиды.",
      productImage:
          "https://images.apteka.ru/medium_fbf7dbc6-5ab4-4a23-9943-883d4b26b849.webp",
      productQuantity: "47433",
    ),
    ProductModel(
      //36
      productId: const Uuid().v4(),
      productTitle: "Сонные+ 30 шт. таблетки",
      productPrice: "250.00",
      productCategory: "Препарат",
      productDescription:
          "Показания\nВ качестве биологически активной добавки к пище, содержащей эфирные масла.",
      productImage:
          "https://images.apteka.ru/medium_72df7f62-7b6a-4dc0-aafa-34dad19da2c1.webp",
      productQuantity: "383",
    ),
  ];
}
