import '../dto/data.dart';

enum YesNoOftenEnum{
  YES("Yes", "হ্যাঁ", 1),
  NO("No", "না", 0),
  OFTEN("Often", "প্রায়ই", 2);

  const YesNoOftenEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static YesNoOftenEnum? getEnumByName(String? name) {
    for (YesNoOftenEnum enm in YesNoOftenEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return YesNoOftenEnum.values.map((element) => element.toData()!).toList();
  }

}
extension YesNoOftenEnumExtension on YesNoOftenEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}