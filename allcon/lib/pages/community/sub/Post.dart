import 'package:allcon/pages/community/Home.dart';
import 'package:allcon/service/community/postService.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/widget/custom_text_area.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? loginUserId;
  String? loginUserNickname;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedCategoryIndex = widget.tabIdx;
    _loadInfo();
  }

  // 지금 로그인 된 유저의 정보 가져오기
  _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserNickname = prefs.getString('userNickname'); // 저장된 닉네임
    loginUserId = prefs.getString('userId'); // 저장된 id
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
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 12.0, left: 12.0),
              child: CustomElevatedBtn(
                icon: CupertinoIcons.airplane,
                iconColor: Colors.white,
                textColor: Colors.white,
                buttonColor: lightMint,
                text: "업로드",
                funPageRoute: () async {
                  if (_formKey.currentState!.validate()) {
                    var newContent = {
                      'category': _selectedCategory,
                      'userId': loginUserId,
                      'nickname': loginUserNickname,
                      'title': _titleController.text,
                      'text': _contentController.text,
                    };

                    await PostService.addPost(newContent);

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
            ),
          ),
        ),
      ),
    );
  }
}
