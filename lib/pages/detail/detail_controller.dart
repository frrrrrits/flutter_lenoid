import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailController extends GetxController with GetTickerProviderStateMixin {
  final String url;
  DetailController({required this.url});
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
