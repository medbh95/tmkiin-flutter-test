import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';

import 'constants/routes.dart';

void main() {
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(350, name: "smallMobile"),
          const ResponsiveBreakpoint.resize(400, name: "mediumMobile"),
          const ResponsiveBreakpoint.resize(600, name: "bigMobile"),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        ],
      ),
      initialRoute: RouteConstant.homeScreen,
      getPages: appRoutes(),
    );
  }));
}
