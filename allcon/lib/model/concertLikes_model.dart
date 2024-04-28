class ConcertLikes {
  final String id;
  final String userId;
  final List<String> concertId;

  ConcertLikes(this.id, this.userId, this.concertId);

  ConcertLikes.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        concertId =
            (json['concertId'] == null) ? [] : json['concertId'].cast<String>();

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'concertId': concertId,
      };
}
