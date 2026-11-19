class AnswerDto {
  AnswerDto({
      this.answerValue, 
      this.questionCode, 
      this.questionType, 
      this.answerText,
      this.uuid,});

  AnswerDto.fromJson(dynamic json) {
    answerValue = json['answerValue'];
    questionCode = json['questionCode'];
    questionType = json['questionType'];
    answerText = json['answerText'];
    uuid = json['uuid'];
  }
  int? answerValue;
  String? questionCode;
  String? questionType;
  String? uuid;
  dynamic answerText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answerValue'] = answerValue;
    map['questionCode'] = questionCode;
    map['questionType'] = questionType;
    map['answerText'] = answerText;
    map['uuid'] = uuid;
    return map;
  }
  static fromJsonList(list) => List<AnswerDto>.from(list.map((x) => AnswerDto.fromJson(x)));

  // int getAnswerValueFromMap(Map<String, dynamic> map) {
  //   var answer = map[questionCode]??null;
  //   int? answerValue;
  //   if(questionCode == 'pm1') {
  //     var today = DateTime.now();
  //     int age = today.year - (answer as DateTime).year;
  //     if(age < 30) answerValue = 0;
  //     else if(age >= 30 && age <= 40) answerValue = 1;
  //     else answerValue = 0;
  //   }
  //   return answerValue??-1;
  // }
}
