import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pharmacy/widgets/titles_text.dart';

class AppNameTextWidget extends StatelessWidget {
  final double fontSize;
  const AppNameTextWidget({super.key, this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 4),
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: TitleTextWidget(
        label: "Vитаминка",
        fontSize: fontSize,
      ),
    );
  }
}
