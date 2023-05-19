import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/routes/app_pages.dart';
import 'package:lenoid/routes/route_path.dart';
import 'package:lenoid/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      theme: darkCustomTheme,
      initialRoute: RoutePath.kMain,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
