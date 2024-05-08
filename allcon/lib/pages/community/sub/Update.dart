import 'package:allcon/model/community_model.dart';
import 'package:allcon/pages/community/Home.dart';
import 'package:allcon/pages/community/controller/content_controller.dart';
import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/widget/custom_text_area.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class MyContentUpdate extends StatefulWidget {
  final int initialCategory;
  final String? category;
  final String? title;
  final String? content;

  final Content originContent;

  const MyContentUpdate({
    super.key,
    required this.initialCategory,
    this.category,
    this.title,
    this.content,
    required this.originContent,
  });

  @override
  _ContentUpdateState createState() => _ContentUpdateState();
}

class _ContentUpdateState extends State<MyContentUpdate> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late String? _selectedCategory = widget.category;
  late int _selectedCategoryIndex = widget.initialCategory;

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
              CustomDropdownButton(
                items: const ['자유게시판', '후기', '카풀'],
                value: _selectedCategory!,
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
                hint: "제목",
                controller: _titleController,
                funValidator: validateTitle(),
              ),
              const SizedBox(height: 16),
              CustomTextArea(
                hint: "내용",
                controller: _contentController,
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
                  child: const Text('사진 첨부/교체'),
                ),
                const SizedBox(height: 5.0),
                CustomElevatedBtn(
                  text: "수정완료",
                  funPageRoute: () {
                    if (_formKey.currentState!.validate()) {
                      // 수정된 컨텐트
                      Content updatedContent = Content(
                        category: _selectedCategory!,
                        postId: widget.originContent.postId,
                        writer: widget.originContent.writer,
                        title: _titleController.text,
                        content: _contentController.text,
                        date: widget.originContent.date,
                        isLike: widget.originContent.isLike,
                        likeCounts: widget.originContent.likeCounts,
                        commentCounts: widget.originContent.commentCounts,
                      );

                      // ContentController에 업데이트된 내용을 전달하여 업데이트합니다.
                      ContentController().updateContent(
                          updatedContent, _selectedCategoryIndex);

                      // 수정된 내용을 반영한 MyCommunity 페이지로 이동합니다.
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
