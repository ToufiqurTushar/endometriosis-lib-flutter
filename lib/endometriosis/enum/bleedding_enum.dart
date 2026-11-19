import '../dto/data.dart';

enum BleedingEnum{
  ONE("Scanty bleeding", "অল্প বা সামান্য রক্তপাত", 1),
  TWO("Normal bleeding", "স্বাভাবিক রক্তপাত", 2),
  THREE("Heavy bleeding", "অতিরিক্ত বা অনেক বেশি রক্তপাত", 3);

  const BleedingEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static BleedingEnum? getEnumByName(String? name) {
    for (BleedingEnum enm in BleedingEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return BleedingEnum.values.map((element) => element.toData()!).toList();
  }

}
extension BleedingEnumExtension on BleedingEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}