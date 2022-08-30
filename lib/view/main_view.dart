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
                    child: Text('Products',
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
                      maincontroller.setpage(0);
                    },
                    textColor: Colors.white)),
                Obx(
                  () => RoundedCornersButton(
                      child: Text('Categories',
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
                        maincontroller.setpage(1);
                      },
                      textColor: Colors.white),
                )
              ],
            ),
            Expanded(
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: maincontroller.pageController,
                onPageChanged: (value) {
                  if (value == 1) {
                    maincontroller.selected(true);
                  } else {
                    maincontroller.selected(false);
                  }
                },
                children: <Widget>[
                  Container(
                    child: Obx(() {
                      if (maincontroller.isDataLoading.value)
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      else if (maincontroller.isSearching.value &&
                          maincontroller.filtredList.length == 0) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No items found',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                "assets/nosearch.png",
                                height: 20.h,
                                width: 50.w,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: (!maincontroller.isSearching.value)
                                ? maincontroller.products.length
                                : maincontroller.filtredList.length,
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
                                          imageUrl: (!maincontroller
                                                  .isSearching.value)
                                              ? maincontroller
                                                  .products[index]!.image!
                                              : maincontroller
                                                  .filtredList[index]!.image!,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 177, 124, 238)),
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
                                              (!maincontroller
                                                      .isSearching.value)
                                                  ? maincontroller
                                                      .products[index]!.title!
                                                  : maincontroller
                                                      .filtredList[index]!
                                                      .title!,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 70, 68, 68),
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                (!maincontroller
                                                        .isSearching.value)
                                                    ? maincontroller
                                                        .products[index]!
                                                        .rating!
                                                        .rate!
                                                        .toString()
                                                    : maincontroller
                                                        .filtredList[index]!
                                                        .rating!
                                                        .rate!
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 70, 68, 68),
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
                                        (!maincontroller.isSearching.value)
                                            ? maincontroller
                                                .products[index]!.description!
                                            : maincontroller.filtredList[index]!
                                                .description!,
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 70, 68, 68),
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
                  ),
                  Container(child: Obx(() {
                    if (maincontroller.isDataLoading.value)
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: maincontroller.categoriesList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                      maincontroller.categoriesList[index]!),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ));
                          });
                    }
                  }))
                ],
              ),
            ),

            ///*/*

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
