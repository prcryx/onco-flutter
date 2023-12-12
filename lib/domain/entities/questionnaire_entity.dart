//

class QuestionnaireEntity {
  int id;
  String? photoUrl;
  String? question;
  List<String>? options;

  QuestionnaireEntity({
    required this.id,
    this.photoUrl,
    this.question,
    this.options,
  });

  factory QuestionnaireEntity.fromJson(Map<String, dynamic> json) =>
      QuestionnaireEntity(
        id: json[QuestionnaireEntityJsonKey.id],
        photoUrl: json[QuestionnaireEntityJsonKey.photoUrl],
        question: json[QuestionnaireEntityJsonKey.question],
        options: List<String>.from(
            json[QuestionnaireEntityJsonKey.options].map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[QuestionnaireEntityJsonKey.id] = id;
    data[QuestionnaireEntityJsonKey.photoUrl] = photoUrl;
    data[QuestionnaireEntityJsonKey.question] = question;
    data[QuestionnaireEntityJsonKey.options] = options;
    return data;
  }
}

class QuestionnaireEntityJsonKey {
  QuestionnaireEntityJsonKey._();
  static String id = 'id';
  static String photoUrl = 'photoUrl';
  static String question = 'question';
  static String options = 'options';
}
