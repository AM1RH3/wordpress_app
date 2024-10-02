import 'package:woedpress_app/ui/utils/extensions.dart';

class CustomValidator {
  static String? fieldMustComplete(String? value) {
    if (value.toString().isEmpty) {
      return 'این فیلد باید تکمیل شود';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value.toString().isEmpty) {
      return 'این فیلد باید تکمیل شود';
      // } else if (!value!.isValidPassword) {
    } else if (!value!.isNotEmpty) {
      return 'پسورد قوی نمی باشد';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value.toString().isEmpty) {
      return 'این فیلد باید تکمیل شود';
    } else if (!value!.isValidEmail) {
      return 'فرمت ایمیل صحیح نیست';
    }
    return null;
  }
}
