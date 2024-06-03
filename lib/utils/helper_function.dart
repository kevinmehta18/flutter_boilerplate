import 'package:boilerplate/providers/auth_provider.dart';
import 'package:boilerplate/routing/app_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:boilerplate/constants.dart/colors.dart';
import 'package:boilerplate/constants.dart/miscellaneous.dart';
import 'package:boilerplate/constants.dart/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class HelperFunction {
  static Future<void> clearAppData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    AuthProvider().dispose();
    Provider.of<AuthProvider>(navigatorKey.currentContext!, listen: false)
        .clearProvider();
  }

  showToast(
    BuildContext context,
    String title, {
    ToastificationType? toastType,
  }) {
    Color shadowColor;
    switch (toastType) {
      case ToastificationType.error:
        shadowColor = kRed.withOpacity(0.5);
        break;
      case ToastificationType.info:
        shadowColor = kBlue.withOpacity(0.5);
        break;
      case ToastificationType.warning:
        shadowColor = kYellow.withOpacity(0.5);
        break;
      default:
        shadowColor = kGreen.withOpacity(0.5);
    }
    toastification.dismissAll();
    toastification.show(
      context: context,
      title: Text(
        title,
        style: text14Bold,
      ),
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.topCenter,
      animationDuration: kAnimationDuration,
      borderRadius: BorderRadius.circular(8),
      type: toastType ?? ToastificationType.success,
      style: ToastificationStyle.fillColored,
      boxShadow: [
        BoxShadow(color: shadowColor, blurRadius: 10, spreadRadius: 5)
      ],
      closeButtonShowType: CloseButtonShowType.none,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      progressBarTheme: ProgressIndicatorThemeData(
          color: kWhite, linearTrackColor: kWhite.withOpacity(0.5)),
    );
  }
}
