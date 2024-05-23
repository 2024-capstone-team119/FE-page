import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:allcon/pages/login/controller/account_controller.dart';
import 'package:allcon/pages/login/MyLogIn.dart';

Future<void> showDeleteDialog(
    BuildContext context, AccountController accountController) async {
  String? loginUserId;
  Future<void> loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserId = prefs.getString('userId');
  }

  await loadUserInfo();

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('회원탈퇴'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('같은 이메일로 재가입이 불가능합니다.'),
              Text(
                '회원 탈퇴하겠습니까? 😭',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('확인'),
                onPressed: () async {
                  if (loginUserId != null) {
                    bool isDeleted =
                        await accountController.deleteUser(loginUserId!);
                    Navigator.of(context).pop();
                    Get.offAll(const MyLogIn());
                    if (isDeleted) {
                      Get.snackbar('회원탈퇴 성공✔', "다음에 또 만나요!");
                      Get.offAll(const MyLogIn());
                    } else {
                      Get.snackbar('회원탈퇴 실패', "회원 탈퇴에 실패하였습니다.");
                    }
                  } else {
                    Get.snackbar('오류', '사용자 정보를 불러오지 못했습니다.');
                    print(
                        'User ID is null. Cannot proceed with user deletion.');
                  }
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
