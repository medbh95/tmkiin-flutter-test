import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tmkiin_test/controller/mainview_controller.dart';

import '../constants/constants.dart';
import 'rounded_corners_button.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  late String title;
  CustomAppBar({required this.title});
  @override
  Size get preferredSize => Size.fromHeight(10.h);

  @override
  Widget build(BuildContext context) {
    var search = "";
    final maincontroller = Get.put(MainViewController());
    return PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Stack(fit: StackFit.loose, children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: orangeCustom,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)))),
          Align(
              alignment: Alignment(0.0, 2),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                    width: 80.w,
                    child: GetBuilder<MainViewController>(
                        init: MainViewController(),
                        builder: (value) => TextField(
                            maxLines: 1,
                            maxLength: 30,
                            cursorColor: orangeCustom,
                            textInputAction: TextInputAction.done,
                            controller: maincontroller.searchController,
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey),
                                counterText: "",
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.solid,
                                      color: orangeCustom),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintStyle: TextStyle(color: Colors.black54),
                                hintText: "Search",
                                fillColor: Colors.white),
                            onChanged: (value) {
                              print(maincontroller.isSearching.value);
                              if (maincontroller
                                  .searchController.text.isEmpty) {
                                maincontroller.isSearching(false);
                              } else {
                                maincontroller.isSearching(true);

                                maincontroller
                                    .searchString(value.toLowerCase());

                                maincontroller.filtredList(maincontroller
                                    .products.value
                                    .where((prod) => (prod!.title!
                                            .toLowerCase()
                                            .contains(maincontroller
                                                .searchString.value) ||
                                        prod.description!
                                            .toLowerCase()
                                            .contains(maincontroller
                                                .searchString.value)))
                                    .toList());
                                print(maincontroller.filtredList.value);
                              }
                            },
                            style: TextStyle(color: Colors.black))),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GetBuilder<MainViewController>(
                        init: MainViewController(),
                        builder: (value) => RoundedCornersButton(
                            child: Text('OK',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500)),
                            fillColor: orangeCustom,
                            borderColor: Colors.transparent,
                            height: 35,
                            width: 35,
                            borderRadius: 5,
                            onpressed: () {
                              maincontroller.isSearching(true);
                            },
                            textColor: Colors.white)),
                  ),
                ],
              )),
        ]));
  }
}
