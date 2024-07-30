import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:matjary/domain/entities/Error.dart';
import 'package:matjary/domain/entities/country.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/category.dart';
import '../domain/entities/product.dart';
import '../domain/entities/user.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

getTokken() async {
  SharedPreferences prefs = await _prefs;
  String? token = prefs.getString("token");
  return token;
}
Future<String?> getLang() async {
  SharedPreferences prefs = await _prefs;
  String? lang = prefs.getString("lang");
  return lang;
}
Future<Map<String,String>> setHeaders()async{
  Map<String, String> headers = {
    "Accept-Language":"en",
    "Accept": "application/json",
    "Connection": "Keep-Alive",
  };
  return headers;
}


Future<Map<String, String>> addToHeaders(Map<String, String> headerItem)async{
  var headers=await setHeaders();
  headers.addAll(headerItem);
  return headers;
}

String baseURL = "http://192.168.1.19:80/api";

register({
  required String name,
  required String phone,
  required String password,
  required String confirmPassword,
  required String countryCode,
  required String countryId,
}) async {
  var body;
    var response = await http
        .post(Uri.parse("$baseURL/users/register"), headers: await setHeaders(), body: {
      "name": name,
      "phone": phone,
      "password": password,
      "language":"en",
      "confirm_possword": confirmPassword,
      "country_code": countryCode,
      "country_id": countryId,
      "device_token": "hahaha"
    });
  if (response.statusCode == 200) {
    body = jsonDecode(response.body);
    print(body);
    var user = User.fromJson(body["data"]);
    checkPhone(phone: phone, countryCode: countryCode).
    then((value){return user;}).catchError((e){
      throw("checkPhone : $e");
    });
  } else {
    body = jsonDecode(response.body);
    print(body);
    throw ("register : "+body["message"]);
  }
}

checkPhone({
  required String phone,
  required String countryCode,
}) async {
  var body;
  var response = await http
      .post(Uri.parse("$baseURL/users/checkPhone"), headers:await setHeaders(), body: {
    "phone": phone,
    "country_code": countryCode,
  });
  if (response.statusCode == 200) {
    body = jsonDecode(response.body);
    print(body);
    var user = User.fromJson(body["data"]);
    print(user);
    return user;
  } else {
    body = jsonDecode(response.body);
    print(body);
    throw ("checkPhone : "+body["message"]);
  }
}

checkOTP({
  required String phone,
  // required String otp,
  // required String deviceToken,
  required String countryCode,
  // required String type,
}) async {
  var response = await http
      .post(Uri.parse("$baseURL/users/checkOtp"), headers:await setHeaders(), body: {
    "phone": phone,
    "country_code": countryCode,
    "device_token": "haha",
    "otp": "1234",
    "type": "register",
  });
  print(jsonDecode(response.body));
}

Future<Either<User,ErrorMessage>> login({
  required String phone,
  required String password,
}) async {
  User user;
  var body;
  var response = await http.post(Uri.parse("$baseURL/users/login"),
      headers:await setHeaders(),
      body: {"phone": phone, "password": password, "device_token": "habita"});
  if (response.statusCode == 200) {
     body = jsonDecode(response.body);
    print(body);
    user = User.fromJson(body["data"]);
    print(user);

    return Left(user);

  } else {

    body = jsonDecode(response.body);

    return Right(ErrorMessage(message:body["message"],errors: body["errors"] ));

  }
}

Future<List<Country>> getCountries() async {
  List<Country> countries = [];
  var response = await http
      .get(headers:await setHeaders(), Uri.parse("$baseURL/users/countriesPicker"))
      .then((value) {
    var body = jsonDecode(value.body);
    print(body);
    countries = List.generate(body["data"]["countries"].length,
        (index) => Country.fromJson(body["data"]["countries"][index]));
    print(countries);
  }).catchError((e) {
    print(e.toString());
  });

  return countries;
}

Future<List<Categories>> getCategories() async {
  var response = await http.get(
    Uri.parse("$baseURL/home/?categoryId=0"),
    headers:await addToHeaders({"Authorization": "Bearer ${await getTokken()}"})
  );
  var body = jsonDecode(response.body);
  print(body);
  List<Categories> categories = List.generate(
      (body["data"]["home"]["categories"]).length,
      (index) =>
          Categories.fromJSON(body["data"]["home"]["categories"][index]));
  return categories;
}

Future<List<Product>> getProducts({required int categoryId}) async {
  var response = await http.get(
    Uri.parse("$baseURL/home/?categoryId=$categoryId"),
    headers:await addToHeaders({"Authorization": "Bearer ${await getTokken()}"}),
  );
  var body = jsonDecode(response.body);
  List<Product> products = List.generate((body["data"]["home"]["newProducts"]).length,
      (index) => Product.fromJSON(body["data"]["home"]["newProducts"][index]));
  return products;
}

 Future<List<Product>>changeFavorites(String productId) async {

  var body;
  var response = await http.post(Uri.parse("$baseURL/wishlists"),
      headers: await addToHeaders({"Authorization": "Bearer ${await getTokken()}"}),
      body: {
        "product_id": productId,
      });
 body=jsonDecode(response.body);
  List<Product> favorites = List.generate((body["data"]["products"]).length,
          (index) => Product.fromJSON(body["data"]["products"][index]));
 print(body);
 print(favorites);
 return favorites;
}

Future<List<Product>> getFavorites(String productId) async {
  var response = await http.get(
    Uri.parse("$baseURL/wishlists"),
    headers: await addToHeaders({"Authorization": "Bearer ${await getTokken()}"}),
  );
  var body = jsonDecode(response.body);
  List<Product> products = List.generate(body["data"]["products"].length,
      (index) => Product.fromJSON(body["data"]["index"]));
  return products;
}

addAddress({
  required String title,
  required String address,
  required String phone,
  required String countryCode,
})async{
  var response = await http.post(Uri.parse("$baseURL/users/addresses"),
      headers: await addToHeaders({"Authorization": "Bearer ${await getTokken()}"}),
      body: {
        "title":title,
        "lat":"30.556610",
        "lng":"30.556610",
        "address":address,
        "is_default":"1",
        "phone":phone,
        "country_code":countryCode
      });
  print(jsonDecode(response.body));
}

placeOrder(List order)async{
  var body={"address_id":"1",};
for(int i=0;i<order.length;i++){
  body.addAll({"products[$i][product_id]":"${order[i]["product_id"]}",
    "products[$i][quantity]":"${order[i]["quantity"]}"
  });
}
  var response = await http.post(Uri.parse("$baseURL/orders"),
      headers: await addToHeaders({"Authorization": "Bearer ${await getTokken()}"}),
      body:body);
  print(jsonDecode(response.body));
}