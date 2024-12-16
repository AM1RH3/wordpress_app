import 'package:flutter/material.dart';
import 'package:woedpress_app/db/secure_db.dart';
import 'package:woedpress_app/ui/login/login_page.dart';
import 'package:woedpress_app/ui/root/root_page.dart';

class LoginOrNot extends StatelessWidget {
  const LoginOrNot({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SecureSorageDB().isLoggedin(),
      builder: (BuildContext context, AsyncSnapshot<bool> loginModel) {
        if (loginModel.connectionState == ConnectionState.waiting) {
          return Container();
        }
        if (loginModel.connectionState == ConnectionState.done) {
          if (loginModel.hasData && loginModel.data!) {
            return const RootPage();
          } else {
            return const LoginPage();
          }
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
