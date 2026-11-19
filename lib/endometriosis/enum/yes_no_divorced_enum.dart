import '../dto/data.dart';

enum YesNoDivorcedEnum{
  YES("Yes", "হ্যাঁ", 1),
  NO("No", "না", 0),
  DIVORCED("Divorced", "তালাকপ্রাপ্ত/ডিভোর্সড", 2);

  const YesNoDivorcedEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static YesNoDivorcedEnum? getEnumByName(String? name) {
    for (YesNoDivorcedEnum enm in YesNoDivorcedEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return YesNoDivorcedEnum.values.map((element) => element.toData()!).toList();
  }

}
extension YesNoDivorcedEnumExtension on YesNoDivorcedEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}