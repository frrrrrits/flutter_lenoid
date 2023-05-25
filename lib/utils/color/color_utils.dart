import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorUtils {
  static final materialTheme = Theme.of(Get.context!);
  static Color elevationOverlay = ElevationOverlay.colorWithOverlay(
    materialTheme.colorScheme.surface,
    materialTheme.colorScheme.primary,
    12,
  );
}
