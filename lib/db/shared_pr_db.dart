import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woedpress_app/models/woocommerce/login_model.dart';

class SecureSorageDB {
  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
// NABEGHEHA.COM
  Future setLoginDetails(
    LoginResponseModel? loginResponseModel,
  ) async {
    return await storage.write(
      key: 'login_details',
      value: loginResponseModel.toString().isNotEmpty
          ? jsonEncode(
              loginResponseModel!.toJson(),
            )
          : '',
    );
  }

  Future loginDetails() async {
    String loginDetails = await storage.read(key: 'login_details') as String;
    if (loginDetails.isNotEmpty) {
      LoginResponseModel data = LoginResponseModel.fromJson(
        jsonDecode(
          loginDetails,
        ),
      );
      return data;
    }
  }

// NABEGHEHA.COM
  Future<bool> isLoggedin() async {
    String? value = await storage.read(key: 'login_details');
    return value != null ? true : false;
  }

  Future<void> logOut() async {
    await storage.delete(key: 'login_details');
  }
}
