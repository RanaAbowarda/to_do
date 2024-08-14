class TaskModel {
  String id;
  String title;
  String subTitle;
  bool isDone;
  int date;

  TaskModel({
    required this.title,
    required this.subTitle,
    required this.date,
    this.id = "",
    this.isDone = false,
  });
  TaskModel .fromJson(Map<String, dynamic> json) :this(
   
        date: json["date"],
        subTitle: json["subTitle"],
        title: json["title"],
        id: json["id"],
        isDone: json["isDone"]);

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "subTitle": subTitle,
      "title": title,
      "id": id,
      "isDone": isDone
    };
  }
}
