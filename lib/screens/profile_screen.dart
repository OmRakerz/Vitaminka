import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:pharmacy/models/user_model.dart';
import 'package:pharmacy/providers/theme_provider.dart';
import 'package:pharmacy/providers/user_provider.dart';
import 'package:pharmacy/screens/auth/login.dart';
import 'package:pharmacy/screens/inner_screens/viewed_resently.dart';
import 'package:pharmacy/screens/inner_screens/wishlist_screen.dart';
import 'package:pharmacy/screens/loading_manager.dart';
import 'package:pharmacy/services/assets_manager.dart';
import 'package:pharmacy/services/my_app_methods.dart';
import 'package:pharmacy/widgets/app_name_text.dart';
import 'package:pharmacy/widgets/custom_list_tile.dart';
import 'package:pharmacy/widgets/subtitles_text.dart';
import 'package:pharmacy/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppMethods.showErrorOrWarningDialog(
        context: context,
        subtitles: "Произошла ошибка $error",
        fct: () {},
      );
    } finally {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(),
        leading: Image.asset(AssetsManager.shoppingCart),
        // Добавил от себя
        leadingWidth: 35,
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child:
                      TitleTextWidget(label: "Пожалуйста, войдите, в систему"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.background,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel!.userImage,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleTextWidget(label: userModel!.userName),
                              SubtitileTextWidget(label: userModel!.userEmail),
                            ],
                          )
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleTextWidget(label: "Общее"),
                    CustomListTile(
                      imagePath: AssetsManager.wishlistSvg,
                      text: "Избранное",
                      function: () {
                        Navigator.pushNamed(context, WishlistScreen.routeName);
                      },
                    ),
                    CustomListTile(
                        imagePath: AssetsManager.recent,
                        text: "Недавно просмотренные",
                        function: () {
                          Navigator.pushNamed(
                              context, ResentlyViewedScreen.routeName);
                        }),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TitleTextWidget(label: "Настройки"),
                    SwitchListTile(
                      title: Text(themeProvider.getIsDarkTheme
                          ? "Тёмная тема"
                          : "Светлая тема"),
                      value: themeProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themeProvider.setDarkTheme(themevalue: value);
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 67, 3, 151),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                        onPressed: () async {
                          if (user == null) {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          } else {
                            await MyAppMethods.showErrorOrWarningDialog(
                                context: context,
                                subtitles: "Вы уверены?",
                                isError: false,
                                fct: () async {
                                  await FirebaseAuth.instance.signOut();
                                  if (!mounted) return;
                                  Navigator.pushNamed(
                                      context, LoginScreen.routeName);
                                });
                          }
                        },
                        icon: Icon(user == null ? Icons.login : Icons.logout),
                        label: Text(user == null ? "Вход" : "Выход"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitileTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
