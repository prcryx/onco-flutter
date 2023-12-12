class MetaDoc {
  int? count;

  MetaDoc({this.count});

  factory MetaDoc.fromJson(Map<String, dynamic> json) => MetaDoc(
        count: json[MetaJsonKey.count],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[MetaJsonKey.count] = count;
    return data;
  }

  static MetaDoc get init => MetaDoc(count: 1);
}

class MetaJsonKey {
  MetaJsonKey._();
  static const count = 'count';
  static const questionnaireResponseCount = 'questionnaireResponseCount';
  static const firstQuestionId = 'firstQuestionId';
}

class MetaConstants {
  MetaConstants._();
  static int questionId = 1702137093250;
}

class UserMetaDoc {
  int? questionnaireResponseCount;
  int? firstQuestionId;

  UserMetaDoc({this.questionnaireResponseCount, this.firstQuestionId});

  factory UserMetaDoc.fromJson(Map<String, dynamic> json) => UserMetaDoc(
        questionnaireResponseCount:
            json[MetaJsonKey.questionnaireResponseCount],
        firstQuestionId: json[MetaJsonKey.firstQuestionId],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[MetaJsonKey.questionnaireResponseCount] = questionnaireResponseCount;
    data[MetaJsonKey.firstQuestionId] = firstQuestionId;
    return data;
  }

  static UserMetaDoc initWith({int? firstQuestionId}) => UserMetaDoc(
      questionnaireResponseCount: 1, firstQuestionId: firstQuestionId);
  static UserMetaDoc initWithConstant() => UserMetaDoc(
      questionnaireResponseCount: 0, firstQuestionId: MetaConstants.questionId);
}
