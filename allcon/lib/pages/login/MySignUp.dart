import 'package:allcon/pages/home/Home.dart';
import 'package:allcon/pages/login/MyLogIn.dart';
import 'package:allcon/service/account/registService.dart';
import 'package:flutter/material.dart';
import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:get/get.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({Key? key}) : super(key: key);

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  final _emailFormKey = GlobalKey<FormState>();
  final _pwdFormKey = GlobalKey<FormState>();
  final _userNameFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _pwdConfirmController = TextEditingController();
  final _userNameController = TextEditingController();

  final _registService = RegistService();

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 60, 10, 20),
          child: SafeArea(
            child: Column(
              children: [
                WellcomText(),
                SignUpStep(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget WellcomText() {
    return Row(
      children: [
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              '반가워요!',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 26.0,
              ),
            ),
            SizedBox(width: 5.0),
            Text(
              'O',
              style: TextStyle(
                color: Colors.deepPurple,
                fontFamily: 'Cafe24Moyamoya',
                fontSize: 40.0,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget SignUpStep() {
    return Expanded(
      child: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        physics: ScrollPhysics(),
        elevation: 0,
        steps: [
          Step(
            title: Text('이메일'),
            content: Column(
              children: <Widget>[
                Form(
                  key: _emailFormKey,
                  child: CustomTextFormField(
                    hint: '이메일 주소를 입력해주세요',
                    funValidator: validateEmail(),
                    controller: _emailController,
                  ),
                )
              ],
            ),
          ),
          Step(
            title: Text('비밀번호'),
            content: Column(
              children: <Widget>[
                Form(
                  key: _pwdFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hint: '비밀번호를 입력해주세요',
                        funValidator: validatePwd(),
                        controller: _pwdController,
                      ),
                      CustomTextFormField(
                        hint: '비밀번호를 다시 입력해주세요',
                        funValidator: (value) {
                          if (value != _pwdController.text) {
                            return '비밀번호가 일치하지 않습니다.';
                          }
                          return null;
                        },
                        controller: _pwdConfirmController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Step(
            title: Text('닉네임'),
            content: Column(
              children: <Widget>[
                Form(
                  key: _userNameFormKey,
                  child: CustomTextFormField(
                    hint: '닉네임을 입력해주세요',
                    funValidator: validateUserName(),
                    controller: _userNameController,
                  ),
                )
              ],
            ),
          ),
        ],
        onStepContinue: () async {
          switch (_currentStep) {
            case 0:
              // 이메일 형식 유효할 경우
              if (_emailFormKey.currentState!.validate()) {
                bool emailExists = await _registService
                    .checkEmailExists(_emailController.text);
                // 이메일 중복 아닐 경우
                if (!emailExists) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  Get.snackbar('회원가입 실패', '이미 등록된 이메일입니다.');
                }
              }
              break;
            case 1:
              if (_pwdFormKey.currentState!.validate()) {
                setState(() {
                  _currentStep++;
                });
              }
              break;
            // 닉네임중복확인
            case 2:
              if (_userNameFormKey.currentState!.validate()) {
                bool nickNameExists = await _registService
                    .checkNicknameExists(_userNameController.text);
                // 닉네임 중복 아닐 경우 -> 회원가입
                if (!nickNameExists) {
                  var req = await _registService.registerUser(
                    _emailController.text,
                    _pwdController.text,
                    _userNameController.text,
                  );
                  if (req is Exception) {
                    Get.snackbar('회원가입 실패', '회원가입에 실패하였습니다😭');
                  } else {
                    Get.offAll(MyLogIn());
                  }
                } else {
                  Get.snackbar('회원가입 실패', '이미 등록된 닉네임입니다.');
                }
              }
              break;
          }
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep <= 0)
              Get.back();
            else
              _currentStep -= 1;
          });
        },
      ),
    );
  }
}
