import 'package:flutter/material.dart';
import 'package:woedpress_app/db/shared_pr_db.dart';
import 'package:woedpress_app/ui/login/login_page.dart';
import 'package:woedpress_app/ui/root/root_page.dart';

class LoginOrNot extends StatelessWidget {
  const LoginOrNot({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedService.isLoggedin(),
      builder: (BuildContext context, AsyncSnapshot<bool> loginModel) {
        if (loginModel.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
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
