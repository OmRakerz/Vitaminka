import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/consts/my_validators.dart';
import 'package:pharmacy/screens/auth/login.dart';
import 'package:pharmacy/screens/loading_manager.dart';
import 'package:pharmacy/services/my_app_methods.dart';
import 'package:pharmacy/widgets/app_name_text.dart';
import 'package:pharmacy/widgets/auth/pick_image_widget.dart';
import 'package:pharmacy/widgets/subtitles_text.dart';
import 'package:pharmacy/widgets/titles_text.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _confirmPasswordController;
  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;
  XFile? _pickedImage;
  final auth = FirebaseAuth.instance;
  String? userImageUrl;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    // Focus Nodes
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _registerFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null) {
      MyAppMethods.showErrorOrWarningDialog(
          context: context,
          subtitles: "Не забудьте подобрать изображение",
          fct: () {});
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      try {
        setState(() {
          isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child("userImages")
            .child("${_emailController.text.trim()}.jpg");

        await ref.putFile(File(_pickedImage!.path));
        userImageUrl = await ref.getDownloadURL();
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        User? user = auth.currentUser;
        final uid = user!.uid;
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          "userId": uid,
          "userName": _nameController.text,
          "userImage": userImageUrl,
          "userEmail": _emailController.text.toLowerCase(),
          "createdAt": Timestamp.now(),
          "userWish": [],
          "userCart": [],
        });

        Fluttertoast.showToast(
            msg: "Учётная запись успешно создана",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } on FirebaseAuthException catch (error) {
        if (!mounted) return;
        await MyAppMethods.showErrorOrWarningDialog(
          context: context,
          subtitles: "Произошла ошибка ${error.message}",
          fct: () {},
        );
      } catch (error) {
        if (!mounted) return;
        await MyAppMethods.showErrorOrWarningDialog(
          context: context,
          subtitles: "Произошла ошибка $error",
          fct: () {},
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
        context: context,
        cameraFCT: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFCT: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        },
        removeFCT: () {
          setState(() {
            _pickedImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60.0,
                  ),
                  const AppNameTextWidget(
                    fontSize: 30,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextWidget(label: "Добро пожаловать"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: size.width * 0.3,
                    width: size.width * 0.3,
                    child: PickImageWidget(
                      pickedImage: _pickedImage,
                      function: () async {
                        await localImagePicker();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "ФИО",
                            prefixIcon: Icon(
                              IconlyLight.message,
                            ),
                          ),
                          validator: (value) {
                            return MyValidators.displayNamevalidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Адрес электронной почты",
                            prefixIcon: Icon(
                              IconlyLight.message,
                            ),
                          ),
                          validator: (value) {
                            return MyValidators.emailValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "Пароль",
                            prefixIcon: const Icon(
                              IconlyLight.lock,
                            ),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            return MyValidators.passwordValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_confirmPasswordFocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                              hintText: "Пароль",
                              prefixIcon: const Icon(
                                IconlyLight.lock,
                              ),
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: Icon(obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          validator: (value) {
                            return MyValidators.repeatPasswordValidator(
                                value: value,
                                password: _passwordController.text);
                          },
                          onFieldSubmitted: (value) {
                            _registerFct();
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              backgroundColor: Color.fromARGB(255, 88, 56, 131),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            icon: const Icon(IconlyBold.addUser),
                            label: const Text(
                              "Зарегистрироваться",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () async {
                              _registerFct();
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SubtitileTextWidget(
                                label: "У вас уже есть аккаунт?"),
                            TextButton(
                                child: const SubtitileTextWidget(
                                  label: "Войти",
                                  fontStyle: FontStyle.italic,
                                  textDecoration: TextDecoration.underline,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    LoginScreen.routeName,
                                  );
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
