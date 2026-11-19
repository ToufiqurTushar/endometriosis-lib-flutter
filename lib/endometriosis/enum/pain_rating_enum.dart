import '../dto/data.dart';

enum PainRatingEnum{
  ONE("No pain (0)", "কোন ব্যথা নেই (০)", 1),
  TWO("Mild pain (1-3)", "হালকা ব্যথা (১-৩)", 2),
  THREE("Moderate pain (4-6)", "মাঝারি ব্যথা (৪-৬)", 3),
  FOUR("Severe pain (7-10)", "তীব্র ব্যথা (৭-১০)", 4);

  const PainRatingEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static PainRatingEnum? getEnumByName(String? name) {
    for (PainRatingEnum enm in PainRatingEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return PainRatingEnum.values.map((element) => element.toData()!).toList();
  }

}
extension PainRatingEnumExtension on PainRatingEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}