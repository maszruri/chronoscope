import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/upload_provider.dart';
import 'package:chronoscope/widgets/submit_button.dart';
import 'package:chronoscope/widgets/upload_container.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UploadPage extends StatelessWidget {
  UploadPage({super.key});

  final FlipCardController flipCardController = FlipCardController();
  final TextEditingController descriptionController = TextEditingController();

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
                UploadContainer(flipCardController: flipCardController),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: secondaryColor),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    style: const TextStyle(color: accentColor),
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.description),
                  ),
                ),
                const SizedBox(height: 15),
                SubmitButton(
                  text: AppLocalizations.of(context)!.upload,
                  onPressed: () {
                    String description = descriptionController.text.trim();
                    var image = context.read<UploadProvider>().imageFile;
                    if (description.isEmpty || image == null) {
                      const snackDesc = SnackBar(
                        content: Text("Please fill all requirement"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackDesc);
                    } else {
                      context
                          .read<UploadProvider>()
                          .onUpload(context, description);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
