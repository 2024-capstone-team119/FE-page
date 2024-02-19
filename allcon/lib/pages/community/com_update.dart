import 'package:allcon/pages/community/com_home.dart';
import 'package:allcon/pages/community/com_review.dart';
import 'package:allcon/pages/community/com_write.dart';
import 'package:allcon/util/validator_util.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/widget/custom_text_area.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyContentUpdate extends StatefulWidget {
  @override
  _ContentUpdateState createState() => _ContentUpdateState();
}

class _ContentUpdateState extends State<MyContentUpdate> {
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '커뮤니티',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hint: "제목",
                funValidator: validateTitle(),
                value: "제목수정해줘1", // 서버에서 불러오기
              ),
              SizedBox(height: 16),
              CustomTextArea(
                hint: "내용",
                funValidator: validateContent(),
                value: "내용수정해줘1 " * 30,
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
                child: Text('사진 첨부/교체'),
              ),
              SizedBox(height: 12),
              CustomElevatedBtn(
                text: "수정완료",
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    print('버튼 클릭 업로드');
                    Get.back();
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
