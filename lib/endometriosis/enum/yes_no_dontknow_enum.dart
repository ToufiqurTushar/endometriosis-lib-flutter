import '../dto/data.dart';

enum YesNoDontknowEnum{
  YES("Yes", "হ্যাঁ", 1),
  NO("No", "না", 0),
  DONT_KNOW("Don’t know", "জানা নেই", 2);

  const YesNoDontknowEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static YesNoDontknowEnum? getEnumByName(String? name) {
    for (YesNoDontknowEnum enm in YesNoDontknowEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return YesNoDontknowEnum.values.map((element) => element.toData()!).toList();
  }

}
extension YesNoDontknowEnumExtension on YesNoDontknowEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}