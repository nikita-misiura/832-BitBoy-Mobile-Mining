import 'package:flutter/widgets.dart';

extension BuildContextExt on BuildContext {
  void hideKeyboard() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
