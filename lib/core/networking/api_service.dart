import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ApiService {
  late Dio dio;
  BaseOptions options = BaseOptions(
    baseUrl: "https://flutter.prominaagency.com/api/",
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
    followRedirects: true,
    maxRedirects: 5,
  );

  ApiService() {
    dio = Dio(options);
  }

  Future<bool> loginUser(
      BuildContext context, String email, String password) async {
    try {
      String apiUrl = "auth/login";
      FormData formData = FormData.fromMap({
        "email": email,
        "password": password,
      });
      Response response = await dio.post(
        apiUrl,
        data: formData,
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (response.statusCode == 200) {
        // Successful login
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to login. Please try again.'),
          ),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
      return false;
    }
  }

  String? authToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMmU2MzlhNGJhZTM0YmFmMmZkM2EzMjYwNDdhZWE1YmIxMGMzNmY1ZDM1YmIyYzUzNDNiNGMwYWE4YWFhMjUyMDQwOWZiOGYxMjY2NzhlOWQiLCJpYXQiOjE3MTIwMjAyNzQuMzA0NTM1LCJuYmYiOjE3MTIwMjAyNzQuMzA0NTM3LCJleHAiOjE3NDM1NTYyNzQuMzAzMzk2LCJzdWIiOiIyMDciLCJzY29wZXMiOltdfQ.irFnHB27wjAzh-ASayPBVSvzMGcO8p-UOXRX3N0b-jvI5AbNxT8xJXHEx7kY5uVw4HYP4026ggVOoPNzlJS3xBclf83bD_Itqn1HFe3owy0fnYIKLkryaern6o3WlX26_EubflT-scstwEisXD7Y30T-ExAZ5fYMaMdbpBJxlL7dGyo7KnJx_PTOKp-DBvYnZ526NJMJ99PpHEFEjas2GteAP2FZxHS1EJZuczfkM0hb_Lpb3a3VM9KOBNXOkT9_zRtRj9QBHi3YYPuBFqOpqj7h8jsDqNcqEtswkw858YsOJj9hTM6JI5ArdNwsA8Vgoq6Ub12lHtB0Bso7P3wl-Kjd7XTf1WUEB2xNKiaFXmJ9EDlKBEO-tV3pNvI7f4oD8Unver3iuXBTLsbQR3vocAOIUZv3gB9xn5IYKMCahnJApZJPf00hQhhGh45Uqa6tq0Fwbuwv4tlq-fG0YpuqqJB_hA901f2lbXbZES4WjeK8c6io-eQVFXGejXlQQB-NLhLOgfIMEdYvbJ231TsHMnjyJBXJ2Gjji2bVlhNN-4HGdCHFeyAb4b_nYFJIINFxtBCUGzKTuUFklMIqkHrb3xLjBxzZ6cw7tLF4icp6XX7ifq5qfdHoF4ujCt_733gLZl9dC7ED5BJto65nTx1ZRPwpm6K7GiR8Jh08pY2PuOw';

  Future<void> uploadImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      try {
        FormData formData = FormData.fromMap({
          'img': await MultipartFile.fromFile(imageFile.path,
              filename: 'image.jpg'),
        });

        Dio dio = Dio();
        if (authToken != null) {
          dio.options.headers['Authorization'] = 'Bearer $authToken';
        }
        Response response = await dio.post(
          'https://flutter.prominaagency.com/api/upload',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image uploaded successfully.'),
              backgroundColor: Colors.blue,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to upload image. Please try again.'),
            ),
          );
        }
      } on DioException catch (e) {
        if (e.response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Server error. Please try again later.'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Network error. Please check your internet connection.'),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected.'),
        ),
      );
    }
  }

  Future<List<String>> fetchImages(BuildContext context) async {
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $authToken';
      Response response = await dio.get(
        'https://flutter.prominaagency.com/api/my-gallery',
      );

      if (response.statusCode == 200) {
        final responseData = response.data['data']['images'] as List<dynamic>;
        final List<String> imageUrls =
            responseData.map<String>((url) => url.toString()).toList();
        return imageUrls;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch images. Please try again.'),
          ),
        );
        throw Exception('Failed to fetch images');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
      rethrow;
    }
  }
}
