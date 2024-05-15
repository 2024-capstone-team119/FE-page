import 'package:allcon/utils/validator_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserName extends StatefulWidget {
  final String? text;
  const EditUserName({super.key, this.text});

  @override
  State<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  final TextEditingController _textEditingController = TextEditingController();
  final _userNickFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.text ?? '';
    _textEditingController.addListener(() {
      final String text = _textEditingController.text.toLowerCase();
      _textEditingController.value = _textEditingController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
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
            SizedBox(height: 18),
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
              '수정할 닉네임을 입력해주세요.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _userNickFormKey,
              child: TextFormField(
                controller: _textEditingController,
                maxLength: 8,
                textAlign: TextAlign.center,
                validator: validateEditNick,
                decoration: const InputDecoration(
                  hintText: "닉네임",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  counterStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onFieldSubmitted: (_) {
                  if (_userNickFormKey.currentState!.validate()) {
                    Get.back(result: _textEditingController.text);
                  }
                },
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
              child: const Text('취소')),
          const SizedBox(width: 8),
          ElevatedButton(
              onPressed: () {
                if (_userNickFormKey.currentState!.validate()) {
                  Get.back(result: _textEditingController.text);
                }
              },
              child: const Text('완료')),
        ],
      ),
    );
  }
}
