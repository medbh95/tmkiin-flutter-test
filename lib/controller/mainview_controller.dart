import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmkiin_test/model/dummy_products_model.dart';
import 'package:tmkiin_test/model/error.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class MainViewController extends GetxController {
  final searchController = TextEditingController();
  var selected = false.obs;
  var token = "".obs;
  var products = <ProductsDummy?>[].obs;
  var filtredList = <ProductsDummy?>[].obs;
  var isDataLoading = false.obs;
  var searchString = "".obs;
  var isSearching = false.obs;
  var categoriesList = <String?>[].obs;
  ErrorReponse? logoutRes;
  void setpage(int pageNbr) {
    pageController.animateToPage(
      pageNbr,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: false,
  );
  @override
  Future<void> onInit() async {
    super.onInit();
    readPrefs();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    readPrefs();
  }

  void readPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? tokenID = prefs.getString('token');

    if (tokenID != null) {
      token(tokenID);
      fetchProducts();
    }
  }

  savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('islogged');
    prefs.remove("token");
  }

  @override
  void onClose() {}
  logout(String token) async {
    //print(token);
    // savePref();

    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET', Uri.parse("${Api.home}api/logout"));
      request.body = json.encode({"token": token});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = jsonDecode(await response.stream.bytesToString());

        logoutRes = ErrorReponse.fromJson(result);
        print(logoutRes!.message);
        //  if (logoutRes!.success!) {
        savePref();
        Get.toNamed("/home");
        Get.snackbar("Sucess", logoutRes!.message!,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            margin: EdgeInsets.all(10));
        //}
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error while getting data is $e');
    }
  }

  Future<List<ProductsDummy>> getProducts() async {
    print(token);

    final response =
        await http.get(Uri.tryParse("https://fakestoreapi.com/products")!);

    print("Json Data: ${response.body}");

    List<ProductsDummy> prodList = (json.decode(response.body) as List)
        .map((data) => ProductsDummy.fromJson(data))
        .toList();
    categoriesList(prodList.map((e) => e.category.toString()).toSet().toList());
    print(categoriesList.value);
    if (response.statusCode == 200) {
      return prodList;
    } else {
      throw Exception("Error getting Json Data");
    }
  }

  void fetchProducts() async {
    try {
      isDataLoading(true);
      var prod = await getProducts();
      if (prod != null) {
        products.value = prod;
      }
    } finally {
      isDataLoading(false);
    }
  }
}
