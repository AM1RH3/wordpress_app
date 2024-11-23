import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:woedpress_app/api/api_service.dart';
import 'package:woedpress_app/models/woocommerce/register_model.dart';
import 'package:woedpress_app/ui/login/login_page.dart';
import 'package:woedpress_app/ui/utils/custom_button_widget.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';
import 'package:woedpress_app/ui/utils/custom_dialog_box.dart';
import 'package:woedpress_app/ui/utils/custom_form_field.dart';
import 'package:woedpress_app/ui/utils/custom_waiting.dart';
import 'package:woedpress_app/ui/utils/validators.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late APIService apiService;
  late CustomerModel customerModel;
  // NABEGHEHA.COM
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isApiCalled = false;

  late TextEditingController firstName =
      TextEditingController(text: customerModel.firstName);
  late TextEditingController lastName =
      TextEditingController(text: customerModel.lastName);
  late TextEditingController email =
      TextEditingController(text: customerModel.email);
  // NABEGHEHA.COM
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
        apiService.createCustomer(customerModel).then(
          (retRes) {
            setState(() {
              isApiCalled = false;
            });
            if (retRes) {
              CustomDialogBox.showMessage(
                // ignore: use_build_context_synchronously
                context,
                'ثبت نام موفق',
                'ثبت نام شما با موفقیت انجام شد',
                'بستن',
                () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return const LoginPage();
                      },
                    ),
                  );
                },
              );
            } else {
              CustomDialogBox.showMessage(
                // ignore: use_build_context_synchronously
                context,
                'ثبت نام ناموفق',
                'ایمیلی که استفاده کردید تکراری است',
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

    void navigatetoLogin() {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) {
            return const LoginPage();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: 'ثبت نام'),
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
                        // FIRSTNAME
                        BuildCustomFormField(
                          controller: firstName,
                          // NABEGHEHA.COM
                          labelName: 'نام',
                          onChanged: (value) {
                            customerModel.firstName = value;
                          },
                          validator: CustomValidator.fieldMustComplete,
                        ),
                        const SizedBox(height: 30.0),
                        // LASTNAME
                        BuildCustomFormField(
                          controller: lastName,
                          labelName: 'نام خانوادگی',
                          onChanged: (value) {
                            customerModel.lastName = value;
                          },
                          validator: CustomValidator.fieldMustComplete,
                        ),
                        const SizedBox(height: 30.0),
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
                                title: 'ثبت نام', onPressed: clicktoSignUp),
                            const SizedBox(width: 20.0),
                            BuildCustomButton(
                                title: 'قبلاً اکانت ساختی؟',
                                onPressed: navigatetoLogin),
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
