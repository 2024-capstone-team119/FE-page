// 로그인 요청시 서버로 전송할 데이터 포함하는 데이터 전송 객체
class LoginReqModel {
  final String? email;
  final String? password;

  LoginReqModel(this.email, this.password);

  // 서버로 전송할 Json 형태 데이터 생성
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
