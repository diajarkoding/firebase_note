class NoteModel {
  final String id;
  final String title;
  final String desc;
  final String createdAt;

  NoteModel(
      {required this.id,
      required this.title,
      required this.desc,
      required this.createdAt});

  factory NoteModel.fromJson(String id, Map<String, dynamic> json) => NoteModel(
        id: id,
        title: json['title'],
        desc: json['desc'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'desc': desc,
        'createdAt': createdAt,
      };
}
