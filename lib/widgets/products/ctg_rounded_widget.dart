import 'package:flutter/material.dart';
import 'package:pharmacy/screens/search_screen.dart';
import 'package:pharmacy/widgets/subtitles_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  final String image, name;
  const CategoryRoundedWidget(
      {super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          SearchScreen.routeName,
          arguments: name,
        );
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          SubtitileTextWidget(
            label: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
