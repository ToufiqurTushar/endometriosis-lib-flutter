import '../../common/method/utils.dart';
import 'answer_dto.dart';

class ResultDto {
  ResultDto({
    this.userId,
    this.riskScaleEn,
    this.riskScaleBn,
    this.resultEn,
    this.resultBn,
    this.resultSBF,
    this.resultPHBF,
    this.resultRBF,
    this.colorCode,
    this.measurementJsonId,
    this.id,
    this.uuid,
    this.createdAt,
    this.lastUpdated,
    this.createdById,
    this.updatedById,
    this.input});

  ResultDto.fromJson(dynamic json) {
    userId = json['userId'];
    riskScaleEn = json['riskScaleEn'];
    riskScaleBn = json['riskScaleBn'];
    resultEn = json['resultEn'];
    resultBn = json['resultBn'];
    resultSBF = json['resultSBF'];
    resultPHBF = json['resultPHBF'];
    resultRBF = json['resultRBF'];
    colorCode = json['colorCode'];
    measurementJsonId = json['measurementJsonId'];
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['created_at'];
    lastUpdated = json['last_updated'];
    createdById = json['created_by_id'];
    updatedById = json['updated_by_id'];
    if (json['input'] != null) {
      input = [];
      json['input'].forEach((v) {
        input?.add(Input.fromJson(v));
      });
    }
  }
  int? userId;
  String? riskScaleEn;
  String? riskScaleBn;
  String? resultEn;
  String? resultBn;
  dynamic resultSBF;
  dynamic resultPHBF;
  dynamic resultRBF;
  String? colorCode;
  int? measurementJsonId;
  int? id;
  String? uuid;
  int? createdAt;
  int? lastUpdated;
  int? createdById;
  int? updatedById;
  List<Input?>? input;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['riskScaleEn'] = riskScaleEn;
    map['riskScaleBn'] = riskScaleBn;
    map['resultEn'] = resultEn;
    map['resultBn'] = resultBn;
    map['resultSBF'] = resultSBF;
    map['resultPHBF'] = resultPHBF;
    map['resultRBF'] = resultRBF;
    map['colorCode'] = colorCode;
    map['measurementJsonId'] = measurementJsonId;
    map['id'] = id;
    map['uuid'] = uuid;
    map['created_at'] = createdAt;
    map['last_updated'] = lastUpdated;
    map['created_by_id'] = createdById;
    map['updated_by_id'] = updatedById;
    if (input != null) {
      map['input'] = input?.map((v) => v?.toJson()).toList();
    }
    return map;
  }

  static fromJsonList(list) => List<ResultDto>.from(list.map((x) => ResultDto.fromJson(x)));

  getRiskScale() {
    if(Utils.isLocaleEn()) {
      return riskScaleEn??'';
    } else {
      return riskScaleBn??'';
    }
  }

  getResult() {
    if(Utils.isLocaleEn()) {
      return resultEn??'';
    } else {
      return resultBn??'';
    }
  }
}


class Input {
  Input({
    this.questionCode,
    this.answerText,
    this.answerValue,});

  Input.fromJson(dynamic json) {
    questionCode = json['questionCode'];
    answerText = json['answerText'] != null ? json['answerText'].cast<String>() : [];
    answerValue = json['answerValue'];
  }
  String? questionCode;
  List<String>? answerText;
  int? answerValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionCode'] = questionCode;
    map['answerText'] = answerText;
    map['answerValue'] = answerValue;
    return map;
  }

}