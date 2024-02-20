import 'package:auto_size_text/auto_size_text.dart';
import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/register_provider.dart';
import 'package:chronoscope/widgets/input_field.dart';
import 'package:chronoscope/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: height * 0.8 / 3,
              alignment: Alignment.bottomCenter,
              child: const AutoSizeText(
                "Are You Ready \nTo Be Chronoscoped?",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 30,
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
                      hint: 'Name',
                      textEditingController: nameController,
                      pIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 25),
                    InputField(
                      hint: 'Email',
                      textEditingController: emailController,
                      pIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 25),
                    InputField(
                      hint: 'Password',
                      textEditingController: passwordController,
                      pIcon: const Icon(Icons.password),
                    ),
                    const SizedBox(height: 25),
                    InputField(
                      hint: 'Confirm Password',
                      textEditingController: confirmController,
                      pIcon: const Icon(Icons.password),
                    ),
                    const SizedBox(height: 25),
                    SubmitButton(
                      text: "Register",
                      onPressed: () {
                        final String name = nameController.text.trim();
                        final String email = emailController.text.trim();
                        final String password = passwordController.text.trim();
                        context
                            .read<RegisterProvider>()
                            .registration(name, email, password);
                        if (context.read<RegisterProvider>().isError) {
                          debugPrint(context.read<RegisterProvider>().message);
                        } else {
                          debugPrint("Gacor");
                        }
                      },
                    ),
                    const SizedBox(height: 25),
                    SubmitButton(
                      text: "Login",
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
