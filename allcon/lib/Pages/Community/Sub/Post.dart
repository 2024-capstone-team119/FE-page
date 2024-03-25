import 'package:allcon/Pages/Community/Home.dart';
import 'package:allcon/Util/validator_util.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:allcon/Widget/custom_elevated_btn.dart';
import 'package:allcon/Widget/custom_text_area.dart';
import 'package:allcon/Widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:allcon/Data/Content.dart';
import 'package:get/get.dart';
import '../controller/content_controller.dart';

class MyContentWrite extends StatefulWidget {
  const MyContentWrite({super.key});

  @override
  _ContentWriteState createState() => _ContentWriteState();
}

class _ContentWriteState extends State<MyContentWrite> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '커뮤니티'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: _titleController,
                hint: "제목",
                funValidator: validateTitle(),
              ),
              const SizedBox(height: 16),
              CustomTextArea(
                controller: _contentController,
                hint: "내용",
                funValidator: validateContent(),
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
                  child: const Text('사진 첨부하기'),
                ),
                const SizedBox(height: 8),
                CustomElevatedBtn(
                  text: "업로드",
                  funPageRoute: () {
                    if (_formKey.currentState!.validate()) {
                      Content newContent = Content(
                        postId: ContentController().contents.length + 1,
                        title: _titleController.text,
                        content: _contentController.text,
                        date: DateTime.now(),
                        isLike: false,
                        like: 0,
                        comment: [],
                      );
                      ContentController().addContent(newContent);
                      // 업로드 후 초기화
                      _titleController.clear();
                      _contentController.clear();
                      // 홈 페이지로 이동
                      Get.to(() => const MyCommunity());
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
