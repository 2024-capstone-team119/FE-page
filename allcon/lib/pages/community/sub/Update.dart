import 'package:allcon/model/community_model.dart';
import 'package:allcon/pages/community/Home.dart';
import 'package:allcon/pages/community/controller/post_controller.dart';
import 'package:allcon/pages/community/sub/Likes.dart';
import 'package:allcon/pages/community/sub/MyContent.dart';
import 'package:allcon/pages/login/controller/account_controller.dart';
import 'package:allcon/service/community/postService.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:allcon/widget/custom_elevated_btn.dart';
import 'package:allcon/widget/custom_text_area.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class MyContentUpdate extends StatefulWidget {
  final int initialCategory;
  final String? category;
  final String? title;
  final String? text;
  final Post originPost;
  final int route;

  const MyContentUpdate({
    super.key,
    required this.initialCategory,
    this.category,
    this.title,
    this.text,
    required this.originPost,
    required this.route,
  });

  @override
  _ContentUpdateState createState() => _ContentUpdateState();
}

class _ContentUpdateState extends State<MyContentUpdate> {
  final _formKey = GlobalKey<FormState>();
  final PostController _postController = Get.put(PostController());
  final AccountController _accountController = Get.put(AccountController());

  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late String? _selectedCategory = widget.category;
  late int _selectedCategoryIndex = widget.initialCategory;

  late String? userId;
  late String? userNickname;

  Future<void> fetchAccountInfo() async {
    var accountList = await _accountController.loadInfo();
    userId = accountList[0];
    userNickname = accountList[1];
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.text);
    fetchAccountInfo();
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
                    _selectedCategoryIndex =
                        _postController.fetchTabIndex(_selectedCategory!);
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
                const SizedBox(height: 5.0),
                CustomElevatedBtn(
                  icon: CupertinoIcons.pencil_ellipsis_rectangle,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  buttonColor: lightMint,
                  text: "수정 완료",
                  funPageRoute: () async {
                    if (_formKey.currentState!.validate()) {
                      // 수정된 컨텐트
                      var updatedPost = {
                        'category': _selectedCategory!,
                        'title': _titleController.text,
                        'text': _contentController.text,
                      };

                      await PostService.updatePost(
                          widget.originPost.postId, updatedPost);

                      // 커뮤니티 홈으로 이동
                      if (widget.route == 0) {
                        Get.to(() => MyCommunity(
                            initialTabIndex: _selectedCategoryIndex));
                      }
                      // 내 게시글로 이동
                      else if (widget.route == 1) {
                        Get.to(() => const MyContent());
                      }
                      // 좋아요 목록으로 이동
                      else {
                        Get.to(() => MyContentLikes(
                            initialCategory: _selectedCategory!,
                            tabIdx: _selectedCategoryIndex,
                            userId: userId ?? '',
                            nickname: userNickname ?? ''));
                      }
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
