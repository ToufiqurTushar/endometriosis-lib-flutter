import '../dto/data.dart';

enum MenstrualCycleEnum{
  ONE("<21 Days", "২১ দিনের আগে", 1),
  TWO("21-35 Days", "২১ থেকে ৩৫ দিনের মাঝে", 2),
  THREE(">35 Days", "৩৫ দিনের পরে", 3);

  const MenstrualCycleEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static MenstrualCycleEnum? getEnumByName(String? name) {
    for (MenstrualCycleEnum enm in MenstrualCycleEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return MenstrualCycleEnum.values.map((element) => element.toData()!).toList();
  }

}
extension MenstrualCycleEnumExtension on MenstrualCycleEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}