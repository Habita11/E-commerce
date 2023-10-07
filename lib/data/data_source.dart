import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../domain/entities/category.dart';


Future register({
  required String name,
  required String phone,
  required String password,
  required String confirmPassword,


}) async {
  var response = await http.post(
      Uri.parse("http://192.168.1.9:80/api/users/register"),
      headers: {
        "Accept-Language": "en",
        "Accept": "application/json"
      },
      body: {
        "name": name,
        "phone": phone,
        "password": password,
        "confirm_password": confirmPassword,
        "country_code": "20",
        "country_id": "1",
        "device_token": "hahaha"
      }
  );
  print(response.body);
}

Future getCategories() async {
  var response = await http.get(
      Uri.parse("http://192.168.1.28:80/api/home/?categoryId=0"),
      headers: {
        "Accept-Language": "ar",
      },

  );
  var body=jsonDecode(response.body);
 List<Categories> categories=List.generate(body["data"]["home"]["categories"], (index) => Categories.fromJSON(body["data"]["home"]["categories"][index]));
}

main() {
 getCategories();
}
