import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/login_provider.dart';
import 'package:chronoscope/widgets/input_field.dart';
import 'package:chronoscope/widgets/remember_login.dart';
import 'package:chronoscope/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
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
                      pIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 25),
                    InputField(
                      hint: 'Password',
                      textEditingController: passwordController,
                      pIcon: const Icon(Icons.password),
                      sIcon: const Icon(
                        Icons.remove_red_eye,
                        size: 5,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const RememberLogin(),
                    const SizedBox(height: 25),
                    SubmitButton(
                      text: "Login",
                      onPressed: () {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        context.read<LoginProvider>().login(email, password);
                      },
                    ),
                    const SizedBox(height: 25),
                    SubmitButton(
                      text: "Register",
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
    );
  }
}
