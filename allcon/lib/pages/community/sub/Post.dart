import 'package:allcon/Data/Sample/community_sample.dart';
import 'package:allcon/pages/community/Home.dart';
import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/widget/custom_text_area.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get.dart';
import '../controller/content_controller.dart';

class MyContentWrite extends StatefulWidget {
  final String initialCategory;
  final int tabIdx;

  const MyContentWrite({
    super.key,
    required this.initialCategory,
    required this.tabIdx,
  });

  @override
  _ContentWriteState createState() => _ContentWriteState();
}

class _ContentWriteState extends State<MyContentWrite> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  late String _selectedCategory;
  late int _selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedCategoryIndex = widget.tabIdx;
  }

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
              CustomDropdownButton(
                items: const ['자유게시판', '후기', '카풀'],
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value.toString();
                    // 선택된 카테고리의 인덱스 찾기
                    _selectedCategoryIndex = ['자유게시판', '후기', '카풀']
                        .indexWhere((category) => category == value);
                  });
                },
              ),
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
                      Post newContent = Post(
                        category: _selectedCategory,
                        postId: '${postsamples.length}',
                        userId: '0',
                        title: _titleController.text,
                        nickname: '추가작성자',
                        text: _contentController.text,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        likes: [],
                        likeCounts: 0,
                        commentCount: 0,
                      );
                      // 선택된 카테고리의 인덱스 전달
                      ContentController().addContent(
                          newContent, _selectedCategoryIndex, postsamples);
                      // 업로드 후 초기화
                      _titleController.clear();
                      _contentController.clear();
                      // 홈 페이지로 이동
                      Get.to(() => MyCommunity(
                            initialTabIndex: _selectedCategoryIndex,
                          ));
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
