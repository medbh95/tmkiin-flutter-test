import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tmkiin_test/controller/login_controller.dart';

import '../constants/constants.dart';
import 'rounded_corners_button.dart';

class LoginScreen extends GetView<LoginController> {
  var email;
  var pwd;
  final logincontroller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: Color.fromARGB(255, 70, 68, 68),
                      fontSize: 27.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 70, 68, 68), fontSize: 17.sp),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 8.h,
                  child: TextField(
                      maxLines: 1,
                      maxLength: 30,
                      cursorColor: orangeCustom,
                      textInputAction: TextInputAction.next,
                      controller: logincontroller.emailController,
                      decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: orangeCustom),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(color: Colors.black54),
                          hintText: "Username , Email or Phone Number",
                          fillColor: greyCustom),
                      onChanged: (String value) {
                        email = value;
                      },
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 8.h,
                  child: TextField(
                      maxLines: 1,
                      maxLength: 30,
                      cursorColor: orangeCustom,
                      textInputAction: TextInputAction.done,
                      controller: logincontroller.pwdController,
                      decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: orangeCustom),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(color: Colors.black54),
                          hintText: "Password",
                          fillColor: greyCustom),
                      onChanged: (String value) {
                        pwd = value;
                      },
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Color.fromARGB(30, 226, 64, 12)),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(
                          color: orangeCustom,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              RoundedCornersButton(
                  child: Text('Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500)),
                  fillColor: orangeCustom,
                  borderColor: Colors.transparent,
                  height: 60,
                  width: 80.w,
                  borderRadius: 20,
                  onpressed: () {
                    var email = logincontroller.emailController.text;
                    var pwd = logincontroller.pwdController.text;

                    (email.isEmpty || pwd.isEmpty)
                        ? Get.snackbar("Error", "Please fill all fields",
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Colors.white,
                            margin: EdgeInsets.all(10))
                        : logincontroller.loginfunction(email, pwd);
                  },
                  textColor: Colors.white),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You dont have an account ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 70, 68, 68),
                          fontSize: 14.sp),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Color.fromARGB(30, 226, 64, 12)),
                      ),
                      onPressed: () {
                        Get.toNamed("/register");
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: orangeCustom,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
