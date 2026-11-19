
import '../enum/content_enum.dart';
import 'content.dart';

class ScreeningPage {
  ScreeningPage({
      this.page, 
      this.pageTitle, 
      this.contents,});

  int? page;
  String? pageTitle;
  List<Content>? contents;

  Content? getContentWithPageIndicator() {
    if(contents == null) return null;
    var contentsWithPageIndicator = contents?.where((item) => item.type == ContentEnum.PAGE_INDICATOR);
    if((contentsWithPageIndicator?.length??0) > 0) {
      return contentsWithPageIndicator!.first;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['pageTitle'] = pageTitle;
    if (contents != null) {
      map['contents'] = contents?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}