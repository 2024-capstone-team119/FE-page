import 'package:allcon/Util/validator_util.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/custom_elevated_btn.dart';
import 'package:allcon/Widget/custom_text_area.dart';
import 'package:allcon/Widget/custom_text_form_field.dart';
import 'package:allcon/Widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class MyContentUpdate extends StatefulWidget {
  final String title;
  final String content;

  const MyContentUpdate(
      {super.key, required this.title, required this.content});

  @override
  _ContentUpdateState createState() => _ContentUpdateState();
}

class _ContentUpdateState extends State<MyContentUpdate> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: "커뮤니티"),
      bottomNavigationBar: const MyBottomNavigationBar(
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
                value: widget.title ?? "", // 서버에서 불러오기
              ),
              const SizedBox(height: 16),
              CustomTextArea(
                hint: "내용",
                funValidator: validateContent(),
                value: widget.content,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: max(MediaQuery.of(context).viewInsets.bottom * 0.05, 16.0),
          ),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    print('사진 첨부 클릭 성공');
                  },
                  child: const Text('사진 첨부/교체'),
                ),
                const SizedBox(height: 5.0),
                CustomElevatedBtn(
                  text: "수정완료",
                  funPageRoute: () {
                    if (_formKey.currentState!.validate()) {
                      print('버튼 클릭 업로드');
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
