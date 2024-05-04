import 'package:validators/validators.dart';

Function validateTitle() {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (value.length > 35) {
      return "제목의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}

Function validateContent() {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (value.length > 10000) {
      return "내용의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}

// 로그인-회원가입시 이메일 유효성 검사
Function validateEmail() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (!isEmail(value)) {
      return "이메일 형식에 맞지 않습니다.";
    } else if (value.length > 10000) {
      return "내용의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}

// 로그인-회원가입시 비밀번호 유효성 검사
Function validatePwd() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (value.length > 12) {
      return "비밀번호 길이를 초과하였습니다.";
    } else if (value.length < 8) {
      return "비밀번호의 최소 길이는 8자입니다.";
    } else {
      return null;
    }
  };
}

// 회원가입시 닉네임 유효성 검사
Function validateUserName() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (value.length > 8) {
      return "닉네임은 최대 8자입니다.";
    } else {
      return null;
    }
  };
}

// 유저닉네임 수정시 유효성 검사
String? validateEditNick(String? value) {
  if (value!.isEmpty) {
    return "공백이 들어갈 수 없습니다.";
  } else if (value.length > 8) {
    return "닉네임은 최대 8자입니다.";
  } else {
    return null;
  }
}
