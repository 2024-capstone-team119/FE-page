import '../Content.dart';

List<Content> freeContentsSample = [
  Content(
      postId: 1,
      title: "자게 제목1",
      content: "자게 1 내용입니다.\n number1" * 10,
      like: 3,
      date: DateTime.parse("2021-06-28"),
      isLike: true,
      comment: [
        "뭐하는 어플이야?",
        "올콘이야😂",
        "믿고 써볼게!!!",
        "댓글4",
        "댓글5",
        "댓글6",
      ]),
  Content(
      postId: 2,
      title: "자게 제목투투222?",
      like: 5,
      date: DateTime.parse("2021-06-27"),
      comment: [
        "뭐하는 어플이야?",
        "올콘이야😂",
        "믿고 써볼게!!!",
        "댓글4",
        "댓글5",
        "댓글6",
      ]),
  Content(
      postId: 3,
      title: "자게 제목1",
      content: "자게 제목일입니다.\n number1" * 10,
      like: 1,
      date: DateTime.parse("2021-06-28")),
  Content(
      postId: 4,
      title: "자게 제목투투222?",
      content: "자게 제목일입니다.\n number1" * 10,
      like: 0,
      date: DateTime.parse("2021-06-27")),
  Content(
      postId: 5,
      title: "자게 제목1",
      content: "자게 제목일입니다.\n number1" * 10,
      like: 0,
      date: DateTime.parse("2021-06-28")),
  Content(
      postId: 6,
      title: "자게 제목투투222?",
      like: 0,
      date: DateTime.parse("2021-06-27")),
  Content(
      postId: 7,
      title: "자게 제목1",
      content: "자게 제목일입니다.\n number1" * 10,
      like: 0,
      date: DateTime.parse("2021-06-28")),
  Content(
      postId: 8,
      title: "자게 제목투투222?",
      like: 0,
      date: DateTime.parse("2021-06-27")),
  Content(
      postId: 9,
      title: "자게 제목1",
      content: "자게 제목일입니다.\n number1" * 10,
      like: 0,
      date: DateTime.parse("2021-06-28")),
  Content(
      postId: 10,
      title: "자게 제목투투222?",
      like: 0,
      date: DateTime.parse("2021-06-27")),
  Content(
      postId: 11,
      title: "자게 제목1",
      content: "자게 제목일입니다.\n number1" * 10,
      like: 0,
      date: DateTime.parse("2021-06-28"),
      comment: [
        "뭐하는 어플이야?",
        "올콘이야😂",
        "믿고 써볼게!!!",
        "댓글4",
        "댓글5",
        "댓글6",
      ]),
  Content(
      postId: 12,
      title: "자게 마지막",
      content: "자게 리스트뷰 마지막 끝에 위치한 게시글임..." * 40,
      like: 0,
      date: DateTime.parse("2021-06-27"),
      comment: [
        "뭐하는 어플이야?",
        "올콘이야😂",
        "믿고 써볼게!!!",
        "댓글4",
        "댓글5",
        "댓글6",
      ]),
];

List<Content> reviewContentsSample = [
  Content(
    postId: 21,
    title: "브루노마스 3일 양일콘 후기",
    boardName: "후기",
    content: "[레전드 브루노마스]\n갈 수 있음 꼭 가!!!!!",
    like: 22,
  ),
  Content(
    postId: 22,
    boardName: "후기",
    content: "테일러스위프트\n드디어 내한 n년 소취 후기",
    like: 34,
  ),
  Content(
    postId: 23,
    title: "찰푸레전드 찍음",
    boardName: "후기",
    content: "비록 1시간 반콘이지만,, 올타임 레전드!!!!",
    like: 37,
  ),
  Content(
    postId: 24,
    title: "2024 현카 슈퍼콘 후기입니당",
    boardName: "후기",
    content: "안녕하세요.\n 현카 슈퍼콘 취켓팅 주인공입니다. 다름 아니라",
    like: 26,
  ),
];

List<Content> changeContentsSample = [
  Content(
      postId: 31,
      content: "25일 서울콘 양도합니다.",
      like: 5,
      date: DateTime.parse("2021-06-25")),
  Content(
      postId: 32,
      content: "올콘 양도구함 제발ㅜ",
      like: 22,
      date: DateTime.parse("2021-06-23")),
];

List<Content> carpoolContentsSample = [
  Content(
      postId: 41,
      content: "카풀 구해요ㅠㅠㅠㅠㅠ제발",
      like: 0,
      date: DateTime.parse("2021-06-28")),
  Content(
      postId: 42,
      content: "콘서트 전까지 같이 놀 사람 구함",
      like: 0,
      date: DateTime.parse("2023-06-28")),
];
