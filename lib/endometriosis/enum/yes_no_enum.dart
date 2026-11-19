import '../dto/data.dart';

enum YesNoEnum{
  YES("Yes", "হ্যাঁ", 1),
  NO("No", "না", 0);

  const YesNoEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static YesNoEnum? getEnumByName(String? name) {
    for (YesNoEnum enm in YesNoEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return YesNoEnum.values.map((element) => element.toData()!).toList();
  }

}
extension YesNoEnumExtension on YesNoEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}