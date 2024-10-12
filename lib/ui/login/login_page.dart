import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woedpress_app/api/api_service.dart';
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

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late APIService apiService;
  late CustomerModel customerModel;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isApiCalled = false;

  late TextEditingController email =
      TextEditingController(text: customerModel.email);

  late TextEditingController password =
      TextEditingController(text: customerModel.password);

  @override
  void initState() {
    apiService = APIService();
    customerModel = CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void clicktoSignUp() {
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
            if (retRes.success!) {
              CustomDialogBox.showMessage(
                context,
                'ورود موفق ',
                'با موفقیت وارد شدید',
                'بستن',
                () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return const RootPage();
                      },
                    ),
                  );
                },
              );
            } else {
              CustomDialogBox.showMessage(
                context,
                'ناموفق',
                'ایمیل یا پسوورد اشتباه است',
                'بستن',
                () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
        );
      }
    }

    void navigatetoSignup() {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) {
            return const SignupPage();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: ' ورود به برنامه'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 100.0,
            left: 20.0,
            right: 20.0,
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.8,
              child: Form(
                key: globalKey,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // EMAIL
                        BuildCustomFormField(
                          controller: email,
                          formFieldtextDirection: TextDirection.ltr,
                          labelName: 'ایمیل',
                          onChanged: (value) {
                            customerModel.email = value;
                          },
                          validator: CustomValidator.emailValidator,
                        ),
                        const SizedBox(height: 30.0),
                        // PASSWORD
                        BuildCustomFormField(
                          controller: password,
                          labelName: 'پسورد',
                          formFieldtextDirection: TextDirection.ltr,
                          obscureText: true,
                          onChanged: (value) {
                            customerModel.password = value;
                          },
                          validator: CustomValidator.passwordValidator,
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          children: [
                            BuildCustomButton(
                                title: ' ورود', onPressed: clicktoSignUp),
                            const SizedBox(width: 20.0),
                            BuildCustomButton(
                                title: 'اکانت ندارید',
                                onPressed: navigatetoSignup),
                            // () {
                            //   Navigator.pushReplacement(
                            //     context,
                            //     PageTransition(
                            //         child: const SignupPage(),
                            //         type: PageTransitionType.leftToRight),
                            //   );
                            // }),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        isApiCalled ? const CustomWaiting() : const Text(''),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
