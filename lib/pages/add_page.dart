import 'package:chronoscope/constants/colors.dart';
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      color: primaryColor,
                      size: 50,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: secondaryColor),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    maxLines: 5,
                    style: const TextStyle(color: accentColor),
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
