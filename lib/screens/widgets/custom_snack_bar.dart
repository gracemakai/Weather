import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

customSnackBar({String? title, String? message})  {
  return Get.snackbar(
    title ?? "",
    message ?? "",
    backgroundColor: Theme.of(navigatorKey.currentContext!).primaryColorLight,
    duration: const Duration(seconds: 3)
  );
}
