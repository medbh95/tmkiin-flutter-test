import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tmkiin_test/constants/constants.dart';
import 'package:tmkiin_test/controller/mainview_controller.dart';
import 'package:tmkiin_test/view/custom_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'rounded_corners_button.dart';

class MainView extends GetView<MainViewController> {
  final maincontroller = Get.put(MainViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'TMK IIIN'),
      body: Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => RoundedCornersButton(
                    child: Text('Coffees',
                        style: TextStyle(
                            color: (!maincontroller.selected.value)
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500)),
                    fillColor: (!maincontroller.selected.value)
                        ? orangeCustom
                        : greyCustom,
                    borderColor: Colors.transparent,
                    height: 6.h,
                    width: 40.w,
                    borderRadius: 10,
                    onpressed: () {
                      maincontroller.selected(false);
                      print(maincontroller.selected.value);
                    },
                    textColor: Colors.white)),
                Obx(
                  () => RoundedCornersButton(
                      child: Text('Restaurants',
                          style: TextStyle(
                              color: (maincontroller.selected.value)
                                  ? Colors.white
                                  : Colors.grey,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500)),
                      fillColor: (maincontroller.selected.value)
                          ? orangeCustom
                          : greyCustom,
                      borderColor: Colors.transparent,
                      height: 6.h,
                      width: 40.w,
                      borderRadius: 10,
                      onpressed: () {
                        maincontroller.selected(true);
                        print(maincontroller.selected.value);
                      },
                      textColor: Colors.white),
                )
              ],
            ),

            ///*/*
            Obx(() {
              if (maincontroller.isDataLoading.value)
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              else {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: maincontroller.products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                                child: CachedNetworkImage(
                                  height: 25.h,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  imageUrl:
                                      maincontroller.products[index]!.image!,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 30,
                                      color:
                                          Color.fromARGB(255, 177, 124, 238)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: Text(
                                      maxLines: 1,
                                      maincontroller.products[index]!.title!,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 70, 68, 68),
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        maincontroller
                                            .products[index]!.rating!.rate!
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 70, 68, 68),
                                            fontSize: 14.sp),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                maincontroller.products[index]!.description!,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 70, 68, 68),
                                    fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            }),

            //***** */
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: orangeCustom,
        onPressed: () {
          maincontroller.logout(maincontroller.token.value);
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
