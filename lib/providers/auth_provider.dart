import 'package:boilerplate/routing/app_router.dart';
import 'package:boilerplate/services/api_service/api_service.dart';
import 'package:boilerplate/utils/helper_function.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  /// Sign UP API
  Future signUp(FormData data) async {
    startLoader();
    await ApiService()
        .networkService(isMultipartData: true)
        .signUp(data)
        .then((value) {
      if (value != null) {
        HelperFunction().showToast(navigatorKey.currentContext!, value['message']);
      }

      stopLoader();
      notifyListeners();
    });
  }

  /// Clear AUth Provider
  clearProvider() {
    isLoading = false;
  }
}
