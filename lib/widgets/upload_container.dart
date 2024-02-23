import 'dart:io';

import 'package:camera/camera.dart';
import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/providers/upload_provider.dart';
import 'package:chronoscope/widgets/submit_button.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UploadContainer extends StatelessWidget {
  const UploadContainer({
    super.key,
    required this.flipCardController,
  });

  final FlipCardController flipCardController;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: FlipCard(
        controller: flipCardController,
        front: Builder(builder: (context) {
          var imagePath = context.watch<UploadProvider>().imagePath;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: secondaryColor),
              image: imagePath == null
                  ? null
                  : DecorationImage(
                      fit: BoxFit.contain,
                      image: FileImage(
                        File(
                          imagePath.toString(),
                        ),
                      ),
                    ),
            ),
            alignment: Alignment.center,
            child: Visibility(
              visible: context.watch<UploadProvider>().imagePath == null
                  ? true
                  : false,
              child: const Icon(
                Icons.add,
                color: primaryColor,
                size: 50,
              ),
            ),
          );
        }),
        back: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: secondaryColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubmitButton(
                text: AppLocalizations.of(context)!.gallery,
                onPressed: () {
                  onGalleryView(context)
                      .whenComplete(() => flipCardController.toggleCard());
                },
              ),
              const SizedBox(height: 15),
              SubmitButton(
                text: AppLocalizations.of(context)!.camera,
                onPressed: () {
                  onCameraView(context)
                      .whenComplete(() => flipCardController.toggleCard());
                },
              ),
              const SizedBox(height: 15),
              SubmitButton(
                  text: 'Custom Camera',
                  onPressed: () {
                    onCustomCameraView(context)
                        .whenComplete(() => flipCardController.toggleCard());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future onGalleryView(BuildContext context) async {
    final provider = context.read<UploadProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Future onCameraView(BuildContext context) async {
    final provider = context.read<UploadProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Future onCustomCameraView(BuildContext context) async {
    final provider = context.read<UploadProvider>();
    final cameras = await availableCameras();
    if (!context.mounted) return;
    final XFile? resultImageFile =
        await context.pushNamed('customCamera', extra: cameras);
    if (resultImageFile != null) {
      provider.setImageFile(resultImageFile);
      provider.setImagePath(resultImageFile.path);
    }
  }
}
