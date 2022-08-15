import 'package:get/get.dart';

// taking height value by percentage to give resposive
double getScreenHeightByPercentage(double percentage) =>
    Get.height * (percentage / 100);

// taking width value by percentage to give resposive
double getScreenWidthByPercentage(double percentage) =>
    Get.width * (percentage / 100);
