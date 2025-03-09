import 'package:dio/dio.dart';

class UserService {
  Dio dio = Dio();

  Future<dynamic> fetchUsers() async {
    try {
      Response response = await dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );

      return response.data;
    } catch (e) {
      print("❌ Error: $e");
    }
  }
}
