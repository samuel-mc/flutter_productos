import 'package:flutter/material.dart';

class LogginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool loading) {
    _isLoading = loading;
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
