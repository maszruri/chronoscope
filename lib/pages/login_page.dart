import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/login_provider.dart';
import 'package:chronoscope/widgets/input_field.dart';
import 'package:chronoscope/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: height * 1 / 3,
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    "Chronoscope",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 50,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                ),
                Container(
                  height: height * 2 / 3,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 25,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InputField(
                          hint: 'Email',
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          pIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InputField(
                                hint: 'Password',
                                textEditingController: passwordController,
                                textInputType: TextInputType.text,
                                pIcon: const Icon(Icons.password),
                                isObscure:
                                    context.watch<LoginProvider>().isObscure,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<LoginProvider>().toggleObscure();
                              },
                              icon: const Icon(Icons.remove_red_eye,
                                  color: secondaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        SubmitButton(
                          text: AppLocalizations.of(context)!.login,
                          onPressed: () {
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();
                            context
                                .read<LoginProvider>()
                                .login(email, password, context);
                          },
                        ),
                        const SizedBox(height: 25),
                        SubmitButton(
                          text: AppLocalizations.of(context)!.register,
                          onPressed: () {
                            context.pushNamed('register');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (context.watch<LoginProvider>().isLoading)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (context.watch<LoginProvider>().isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          ),
      ],
    );
  }
}
