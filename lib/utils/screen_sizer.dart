import 'package:get/get.dart';

double getScreenHeightByPercentage(double percentage) =>
    Get.height * (percentage / 100);

double getScreenWidthByPercentage(double percentage) =>
    Get.width * (percentage / 100);
