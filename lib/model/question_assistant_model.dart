class QuestionAssistantModel {
  QuestionAssistantModel({
      this.questionId, 
      this.question, 
      this.questionType, 
      this.questionOption1, 
      this.questionOption2, 
      this.questionStatus,});

  QuestionAssistantModel.fromJson(dynamic json) {
    questionId = json['question_id'];
    question = json['question'];
    questionType = json['question_type'];
    questionOption1 = json['question_option1'];
    questionOption2 = json['question_option2'];
    questionStatus = json['question_status'];
  }
  String? questionId;
  String? question;
  String? questionType;
  dynamic questionOption1;
  dynamic questionOption2;
  String? questionStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question_id'] = questionId;
    map['question'] = question;
    map['question_type'] = questionType;
    map['question_option1'] = questionOption1;
    map['question_option2'] = questionOption2;
    map['question_status'] = questionStatus;
    return map;
  }

}