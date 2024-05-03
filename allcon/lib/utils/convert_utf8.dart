import 'dart:convert';

dynamic convertUtf8ToObject(dynamic body) {
  // json 데이터로 변경
  String responseBody = jsonEncode(body);
  dynamic convertBody = jsonDecode(utf8.decode(responseBody.codeUnits));
  return convertBody;
}
