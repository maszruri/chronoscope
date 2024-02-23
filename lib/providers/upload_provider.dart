import 'dart:typed_data';

import 'package:chronoscope/models/upload_response.dart';
import 'package:chronoscope/services/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class UploadProvider extends ChangeNotifier {
  String? imagePath;
  XFile? imageFile;
  final ApiService apiService;
  bool isUploading = false;
  String message = "";
  UploadResponse? uploadResponse;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future onUpload(BuildContext context, String description) async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);

    if (imagePath == null || imageFile == null) return;
    final fileName = imageFile!.name;
    final bytes = await imageFile!.readAsBytes();
    final newBytes = await compressImage(bytes);

    await upload(
      newBytes,
      fileName,
      description,
    );
    if (uploadResponse != null) {
      setImageFile(null);
      setImagePath(null);
    }
    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(message)),
    );
    debugPrint(message);
  }

  Future<void> upload(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    try {
      message = "";
      uploadResponse = null;
      isUploading = true;
      notifyListeners();
      uploadResponse =
          await apiService.uploadDocument(bytes, fileName, description);
      message = uploadResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      ///
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }

  UploadProvider(this.apiService);
}
