class Board {
  final int index;
  final String title;
  bool? hasNew = false;
  Function? titleType;
  Function? contentType;
  List<dynamic>? contents;

  Board(
      {required this.index,
      required this.title,
      this.hasNew,
      this.titleType,
      this.contentType,
      this.contents});
}
