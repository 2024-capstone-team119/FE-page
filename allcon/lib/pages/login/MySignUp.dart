import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({super.key});

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  final _emailFormKey = GlobalKey<FormState>();
  final _pwdFormKey = GlobalKey<FormState>();
  final _userNameFormKey = GlobalKey<FormState>();

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
                SingUpStep(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget WellcomText() {
    // 위젯 함수로 선언
    return Row(
      children: [
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              '환영합니다!',
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
                fontSize: 36.0,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget SingUpStep() {
    int _currentStep = 0;
    return Stepper(
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
                child: CustomTextFormField(
                  hint: '이메일 주소를 입력해주세요',
                  funValidator: validatePwd(),
                ),
              )
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
                ),
              )
            ],
          ),
        ),
      ],
      onStepContinue: () {
        setState(() {
          if (_currentStep < 2) {
            _currentStep += 1;
          }
        });
      },
    );
  }
}
