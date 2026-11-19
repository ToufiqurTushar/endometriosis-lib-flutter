import '../dto/data.dart';

enum RelationshipEnum{
  MOTHER("Mother", "মা", 1),
  SISTER("Sister", "বোন", 2),
  TWIN_SISTER("Twin sister", "যমজ বোন", 3),
  MATERNAL_AUNT("Maternal aunt", "খালা", 4),
  PATERNAL_AUNT("Paternal aunt", "ফুপু", 5);

  const RelationshipEnum(this.labelEn, this.labelBn, this.value);

  final String labelEn;
  final String labelBn;
  final int value;

  static RelationshipEnum? getEnumByName(String? name) {
    for (RelationshipEnum enm in RelationshipEnum.values) {
      if (enm.name == name) {
        return enm;
      }
    }
    return null;
  }

  static List<Data> getDataList() {
    return RelationshipEnum.values.map((element) => element.toData()!).toList();
  }

}
extension RelationshipEnumExtension on RelationshipEnum {
  Data? toData() => Data(labelEn: this.labelEn,labelBn: this.labelBn, value: this.value);
}