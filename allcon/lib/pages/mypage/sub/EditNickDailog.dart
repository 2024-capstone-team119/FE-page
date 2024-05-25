import 'package:allcon/pages/mypage/controller/profile_controller.dart';
import 'package:allcon/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:allcon/utils/validator_util.dart';
import 'package:allcon/service/account/registService.dart';

class EditUserName extends StatefulWidget {
  final String? text;
  const EditUserName({super.key, this.text});

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  final TextEditingController _textEditingController = TextEditingController();
  final _userNickFormKey = GlobalKey<FormState>();
  final _registService = RegistService();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.text ?? '';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            editTextField(),
            const SizedBox(height: 10),
            Buttons(),
          ],
        ),
      ),
    );
  }

  Widget editTextField() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Text(
              '🎨 수정할 닉네임을 입력해주세요 🎨',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _userNickFormKey,
                child: TextFormField(
                  controller: _textEditingController,
                  maxLength: 8,
                  textAlign: TextAlign.center,
                  validator: validateEditNick,
                  onTap: () {
                    _textEditingController.clear();
                  },
                  decoration: const InputDecoration(
                    hintText: "닉네임",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                    counterStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Buttons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('취소'),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () async {
              if (_userNickFormKey.currentState!.validate()) {
                final isNickExists = await _registService
                    .checkNicknameExists(_textEditingController.text);
                if (isNickExists) {
                  Get.snackbar('닉네임 수정 실패 😱', '이미 등록된 닉네임입니다.',
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white);
                } else {
                  Get.back(result: _textEditingController.text);
                }
              }
            },
            child: const Text('완료'),
          ),
        ],
      ),
    );
  }
}
