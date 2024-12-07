import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:woedpress_app/api/api_service.dart';
import 'package:woedpress_app/db/secure_db.dart';
import 'package:woedpress_app/models/woocommerce/register_model.dart';
import 'package:woedpress_app/ui/root/root_page.dart';
import 'package:woedpress_app/ui/signup/signup_page.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';
import 'package:woedpress_app/ui/utils/custom_button_widget.dart';
import 'package:woedpress_app/ui/utils/custom_dialog_box.dart';
import 'package:woedpress_app/ui/utils/custom_form_field.dart';
import 'package:woedpress_app/ui/utils/custom_waiting.dart';
import 'package:woedpress_app/ui/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
// NABEGHEHA.COM
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late APIService apiService;
  late CustomerModel customerModel;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
// NABEGHEHA.COM
  TextEditingController email = TextEditingController(
      // text: 'am1rh3@hotmail.com',
      );
  TextEditingController password = TextEditingController(
      // text: 'admin',
      );

  bool isApiCalled = false;

  void loginButton() {
    if (globalKey.currentState!.validate()) {
      setState(() {
        isApiCalled = true;
      });
      apiService
          .loginCustomer(
        email.text,
        password.text,
      )
          .then(
        (retRes) {
          setState(() {
            isApiCalled = false;
          });
          if (retRes.success == true) {
            SecureSorageDB().setLoginDetails(retRes);
            CustomDialogBox.showMessage(
              // ignore: use_build_context_synchronously
              context,
              'موفقیت آمیز',
              'ورود با موفقیت انجام شد',
              'ورود به برنامه',
              () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) {
                      return const RootPage();
                    },
                  ),
                  (_) => false,
                );
              },
            );
          } else if (retRes.success == false) {
            CustomDialogBox.showMessage(
              // ignore: use_build_context_synchronously
              context,
              'خطا کد ${retRes.statusCode}',
              retRes.message.toString(),
              'بستن',
              () {
                Navigator.of(context).pop();
              },
            );
          }
        },
      ).catchError((err) {
        setState(() {
          isApiCalled = false;
        });
        CustomDialogBox.showMessage(
          // ignore: use_build_context_synchronously
          context,
          'خطا',
          err.toString(),
          'بستن',
          () {
            Navigator.of(context).pop();
          },
        );
      });
    }
  }

  void navigatetoSignUp() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      CupertinoPageRoute(
        builder: (context) {
          return const SignupPage();
        },
      ),
    );
  }

  @override
  void initState() {
    apiService = APIService();
    customerModel = CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: 'ورود به برنامه'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Image.asset(
              'assets/images/login_page.png',
            ),
            SizedBox(
              height: size.height * 0.5,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: SizedBox(
                      width: size.width * 0.9,
                      // height: size.height * 0.9,
                      child: Form(
                        key: globalKey,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 30.0),
                              BuildCustomFormField(
                                labelName: 'ایمیل',
                                controller: email,
                                formFieldtextDirection: TextDirection.ltr,
                                validator: CustomValidator.emailValidator,
                              ),
                              const SizedBox(height: 30.0),
                              BuildCustomFormField(
                                labelName: 'پسورد',
                                controller: password,
                                formFieldtextDirection: TextDirection.ltr,
                                validator: CustomValidator.passwordValidator,
                              ),
                              const SizedBox(height: 30.0),
                              Row(
                                children: [
                                  BuildCustomButton(
                                      title: 'ورود', onPressed: loginButton),
                                  const SizedBox(width: 20.0),
                                  BuildCustomButton(
                                      title: 'اکانت ندارید؟',
                                      onPressed: navigatetoSignUp),
                                ],
                              ),
                              // NABEGHEHA.COM
                              const SizedBox(height: 30.0),
                              isApiCalled
                                  ? const CustomWaiting()
                                  : const Text(''),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
