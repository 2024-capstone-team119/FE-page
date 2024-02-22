import 'package:flutter_validator/flutter_validator.dart';

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
