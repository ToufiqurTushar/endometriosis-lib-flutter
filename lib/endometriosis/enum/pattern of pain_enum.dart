import '../dto/data.dart';

enum PatternOfPainEnum{
  ONE("Pain starts before the menstrual cycle, increases in the middle,intensifies at the end, and often persists even after menstruation ends", "মাসিক শুরু হওয়ার আগে ব্যথা শুরু হয়, মাসিকের মাঝামাঝি পর্যায়ে ব্যথা বেড়ে যায় এবং মাসিকের শেষের দিকে ব্যথা তীব্রতর হয়। অনেক সময় ব্যথা মাসিক শেষ হওয়ার পরেও থেকে যায়।", 1),
  TWO("Pain starts at the onset of menstruation, intensifies in the middle, and continues until the end", "মাসিক শুরু হওয়ার সাথে সাথে ব্যথা শুরু হয়, মাসিকের মাঝামাঝি পর্যায়ে ব্যথা বেড়ে যায় এবং এই ব্যথা মাসিকের শেষ পর্যন্ত তীব্র অবস্থায় থেকে যায়।", 2),
  THREE("Pain starts before the start of menstruation and subsides within 2-3 days", "মাসিক শুরু হওয়ার আগে ব্যথা শুরু হয় এবং দুই থেকে তিন দিনের মধ্যে ব্যথা কমে যায়।", 3),
  FOUR("Pain starts at the onset of menstruation and subsides within 2-3 days", "মাসিক শুরু হওয়ার সাথে সাথেই ব্যথা শুরু হয় এবং দুই থেকে তিন দিনের মধ্যে ব্যথা কমে যায়।", 4);

  const PatternOfPainEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static PatternOfPainEnum? getEnumByName(String? name) {
    for (PatternOfPainEnum enm in PatternOfPainEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return PatternOfPainEnum.values.map((element) => element.toData()!).toList();
  }

}
extension PatternOfPainEnumExtension on PatternOfPainEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}