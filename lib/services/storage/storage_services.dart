import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StorageServices {
  Future<String?> uploadFileData(File newImage) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/${dotenv.env['CLOUD_NAME']!}/upload',
      );
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = dotenv.env['UPLOAD_PRESET']!
        ..files.add(await http.MultipartFile.fromPath('file', newImage.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);

        final url = jsonMap['url'];
        return url;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }
}
