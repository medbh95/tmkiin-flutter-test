import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmkiin_test/model/login.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  LoginReponse? login;
  var isLoggedin = false.obs,
      uname = "".obs,
      email = "".obs,
      pwd = "".obs,
      token = "".obs;
  var isDataLoading = false.obs;

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

  savePref(
    bool isLogged,
    String token,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('islogged', isLogged);
    prefs.setString("token", token);
  }

  @override
  void onClose() {}
  void readPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Re?turn bool
    bool? isLogged = prefs.getBool('islogged');
    String? tokenID = prefs.getString('token');
    if (isLogged != null) {
      isLoggedin.value = isLogged;
      if (tokenID != null) {
        token(tokenID);
      }

      if (isLogged) {
        Get.offNamed('/main');
      }
    }
  }

  loginfunction(String email, password) async {
    Map data = {'email': email, 'password': password};
    print(data);

    String body = json.encode(data);
    Uri? url = Uri.tryParse("${Api.home}api/login");
    try {
      isDataLoading(true);
      var response = await http.post(
        url!,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        //Or put here your next screen using Navigator.push() method

        var result = jsonDecode(response.body);

        login = LoginReponse.fromJson(result);
        savePref(true, login!.token!);

        emailController.text = "";
        pwdController.text = "";
        Get.snackbar("Sucess", "Welcome Back !",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            margin: EdgeInsets.all(10));
        Get.offNamed('/main');
        print(login?.token);
      } else {
        Get.snackbar("Error", "Login credentials are invalid",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            margin: EdgeInsets.all(10));
      }
    } catch (e) {
      print('Error while getting data is $e');
      Get.snackbar("Error", "Something Went Wrong !",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.all(10));
    } finally {
      isDataLoading(false);
    }
  }
}
