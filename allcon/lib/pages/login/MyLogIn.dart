import 'package:allcon/pages/login/controller/account_controller.dart';
import 'package:allcon/pages/home/Home.dart';
import 'package:allcon/pages/login/MySignUp.dart';
import 'package:allcon/pages/login/controller/user_controller.dart';
import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLogIn extends StatefulWidget {
  const MyLogIn({super.key});

  @override
  State<MyLogIn> createState() => _MyMyLogInState();
}

class _MyMyLogInState extends State<MyLogIn> {
  final _formKey = GlobalKey<FormState>();
  final AccountController _accountController = Get.put(AccountController());

  final _userEmail = TextEditingController();
  final _userPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WellcomText(),
                SizedBox(height: 20),
                SingInForm(),
                SizedBox(height: 10),
                IsntUser(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget WellcomText() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '올콘해요!',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 26.0,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'O',
              style: TextStyle(
                color: Colors.deepPurple,
                fontFamily: 'Cafe24Moyamoya',
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget SingInForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              hint: "이메일을 입력해주세요",
              funValidator: validateEmail(),
              controller: _userEmail,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              hint: "비밀번호를 입력해주세요",
              funValidator: validatePwd(),
              controller: _userPwd,
            ),
            SizedBox(height: 32),
            CustomElevatedBtn(
                text: "로그인",
                funPageRoute: () async {
                  if (_formKey.currentState!.validate()) {
                    String token = await _accountController.login(
                        _userEmail.text.trim(), _userPwd.text.trim());
                    if (token != "-1") {
                      print("토큰 받기 성공");
                      Get.to(() => MyHome());
                    } else {
                      Get.snackbar('로그인 실패 😭', "다시 시도해주세요!");
                    }
                  }
                })
          ],
        ));
  }

  Widget IsntUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '아직 올콘러가 아니세요?',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(MySignUp());
          },
          child: Text(
            '회원가입',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
