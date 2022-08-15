import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SizedHeightSpace extends StatelessWidget {
  const SizedHeightSpace(this.percentage, {super.key});
  final double percentage;
  @override
  Widget build(BuildContext context) =>
      SizedBox(height: Get.height * (percentage / 100));
}

class SizedWidthSpace extends StatelessWidget {
  const SizedWidthSpace(this.percentage, {super.key});
  final double percentage;
  @override
  Widget build(BuildContext context) =>
      SizedBox(width: Get.width * (percentage / 100));
}
