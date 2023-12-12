class UserQuestionnaireResponse {
  String? userId;
  int? questionId;
  String? question;
  String? response;

  UserQuestionnaireResponse(
      {this.userId, this.questionId, this.question, this.response});

  factory UserQuestionnaireResponse.fromJson(Map<String, dynamic> json) =>
      UserQuestionnaireResponse(
        userId: json[UserQuestionnaireResponseJsonKeys.userId],
        questionId: json[UserQuestionnaireResponseJsonKeys.questionId],
        question: json[UserQuestionnaireResponseJsonKeys.question],
        response: json[UserQuestionnaireResponseJsonKeys.response],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[UserQuestionnaireResponseJsonKeys.userId] = userId;
    data[UserQuestionnaireResponseJsonKeys.questionId] = questionId;
    data[UserQuestionnaireResponseJsonKeys.question] = question;
    data[UserQuestionnaireResponseJsonKeys.response] = response;
    return data;
  }
}

class UserQuestionnaireResponseJsonKeys {
  UserQuestionnaireResponseJsonKeys._();

  static const userId = 'userId';
  static const questionId = 'questionId';
  static const question = 'question';
  static const response = 'response';
}
