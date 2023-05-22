import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lenoid/pages/home/home_page.dart';
import 'package:lenoid/pages/library/library_page.dart';

class MainController extends GetxController {
  final index = 0.obs;
  final showContent = false.obs;
  final GlobalKey indexKey = GlobalKey();
  List<Widget> pages = [const HomePage(), const LibraryPage()];

  int get currentPageIndex => index.value;
  setCurrentPageIndex(int value) {
    index.value = value;
  }
}
