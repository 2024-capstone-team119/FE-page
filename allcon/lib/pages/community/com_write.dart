import 'package:allcon/pages/community/com_home.dart';
import 'package:allcon/util/validator_util.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/widget/custom_text_area.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyContentWrite extends StatefulWidget {
  @override
  _ContentWriteState createState() => _ContentWriteState();
}

class _ContentWriteState extends State<MyContentWrite> {
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: '커뮤니티'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hint: "제목",
                funValidator: validateTitle(),
              ),
              SizedBox(height: 16),
              CustomTextArea(
                hint: "내용",
                funValidator: validateContent(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  print('사진 첨부 클릭 성공');
                },
                child: Text('사진 첨부하기'),
              ),
              SizedBox(height: 12),
              CustomElevatedBtn(
                text: "업로드",
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    print('버튼 클릭 업로드');
                    Get.off(MyCommunity());
                  }
                },
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
