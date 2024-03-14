class Concert {
  final int concertId;
  String? title;
  String? performer;
  DateTime? date;
  String? area;
  String? place;
  String? imgUrl;
  int? age;
  int? time;

  Concert({
    required this.concertId,
    this.performer,
    this.title,
    this.date,
    this.area,
    this.place,
    this.imgUrl,
    this.age,
    this.time,
  });
}
