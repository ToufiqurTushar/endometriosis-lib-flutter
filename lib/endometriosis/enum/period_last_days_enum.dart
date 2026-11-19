import '../dto/data.dart';

enum PeriodLastDaysEnum{
  ONE("1-7 Days", "১ থেকে ৭ দিন", 0),
  TWO(">7 Days", "৭ দিনের বেশি", 1);

  const PeriodLastDaysEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static PeriodLastDaysEnum? getEnumByName(String? name) {
    for (PeriodLastDaysEnum enm in PeriodLastDaysEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return PeriodLastDaysEnum.values.map((element) => element.toData()!).toList();
  }

}
extension PeriodLastDaysEnumExtension on PeriodLastDaysEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}