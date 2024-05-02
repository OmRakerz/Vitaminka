import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/subtitles_text.dart';
import 'package:pharmacy/widgets/titles_text.dart';

class EmptyBagWidget extends StatelessWidget {
  final String imagePath, title, subtitle, buttonText;
  const EmptyBagWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            TitleTextWidget(
              label: "Упс!",
              fontSize: 40,
              color: Color.fromARGB(255, 201, 32, 20),
            ),
            SizedBox(
              height: 20,
            ),
            SubtitileTextWidget(
              label: title,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
            SizedBox(
              height: 10,
            ),
            SubtitileTextWidget(
              label: subtitle,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: Color.fromARGB(255, 67, 3, 151),
                ),
                onPressed: () {},
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
