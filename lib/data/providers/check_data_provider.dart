import 'package:dio/dio.dart';
import 'dart:io';
import '../../utils/constants.dart';

class CheckDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = const Duration(minutes: 2)
    ..options.receiveTimeout = const Duration(minutes: 1);

  Future<Response> extractAccountNumber(File image) async {
    try {
      FormData formData = FormData.fromMap({
        'check_image': await MultipartFile.fromFile(image.path),
      });

      final response = await dio.patch(
        extractAccountNumberEndpoint,
        data: formData,
      );
      return response;
    } catch (e) {
      print('Error extracting account number: $e');
      throw e;
    }
  }
}