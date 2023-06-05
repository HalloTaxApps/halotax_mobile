import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/userAPI_model.dart';

class UserApi {
  Future<List<dynamic>> fetchUser() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/data_user'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['data'];
      List<Datum> data =
          body.map((dynamic item) => Datum.fromJson(item)).toList();
      return data;
    } else {
      throw Exception('Fetch Failed');
    }
  }

  Future<dynamic> createUser(dynamic input) async {
    var response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/data_user'),
      body: json.encode(input),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    try {
      Map<String, dynamic> json = jsonDecode(response.body);
      return UserApiModel.fromJson(json);
    } catch (e) {
      print(response.body);
    }
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> json = jsonDecode(response.body);
    //   return UserApiModel.fromJson(json);
    // } else {
    //   throw Error();
    // }
  }
}
