import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmkiin_test/model/error.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../model/register.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final cpwdController = TextEditingController();
  final unameController = TextEditingController();
  Register? register;
  ErrorEmailReponse? error_register;
  var isDataLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  registerfunction(String name, email, password) async {
    Map data = {'name': name, 'email': email, 'password': password};
    print(data);

    String body = json.encode(data);
    Uri? url = Uri.tryParse("${Api.home}api/register");
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
        var result = jsonDecode(response.body);
        try {
          register = Register.fromJson(result);

          emailController.text = "";
          pwdController.text = "";
          unameController.text = "";
          cpwdController.text = "";
          Get.snackbar("Sucess", "Account Created ! ${register!.data!.name!}",
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              margin: EdgeInsets.all(10));
          print(register?.success);
          Get.toNamed("/home");
        } catch (e) {
          print('Error while getting data is $e');
          error_register = ErrorEmailReponse.fromJson(result);
          Get.snackbar("Error", "${error_register!.error!.email![0]} !",
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              margin: EdgeInsets.all(10));
        }
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
