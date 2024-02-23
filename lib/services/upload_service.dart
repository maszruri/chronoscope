import 'dart:typed_data';

import 'package:chronoscope/models/upload_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<UploadResponse> uploadDocument(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    String token = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = dotenv.env['STORIES_URL']!;
    token = prefs.getString('token')!;

    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    final Map<String, String> fields = {
      "description": description,
    };
    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      bytes,
      filename: fileName,
    );
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $token',
    };

    request.fields.addAll(fields);
    request.files.add(multiPartFile);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;
    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      final UploadResponse uploadResponse = UploadResponse.fromJson(
        responseData,
      );
      return uploadResponse;
    } else {
      throw Exception("Upload file error");
    }
  }
}
