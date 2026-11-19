import 'package:endometriosis_lib_flutter/endometriosis/npage/detail_view/endometriosis_detail_result_view.dart';
import 'package:flutter_rapid/flutter_rapid.dart';

import 'endometriosis/endometriosis_home_view.dart';
import 'endometriosis/npage/list/endometriosis_screening_list_view.dart';
import 'endometriosis/npage/result/endometriosis_result_view.dart';
import 'endometriosis/npage/screening/endometriosis_screening_view.dart';

class EndometriosisAppRegistry extends RapidModuleRegistry {
  @override
  List<RapidView> getPages() {
    return [
      const EndometriosisScreeningView(),
      const EndometriosisResultView(),
      const EndometriosisScreeningListView(),
      const EndometriosisHomeView(),
      const EndometriosisDetailResultView(),
    ];
  }
}
