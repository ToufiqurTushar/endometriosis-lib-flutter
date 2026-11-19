import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/color_config.dart';
import '../../dto/screening_page.dart';
import '../../endometriosis_home_i18n.dart';
import 'endometriosis_screening_logic.dart';
import '../../nview/build_items.dart';
import '../../nview/form/simple_button.dart';
import '../../repository/endometriosis_repository.dart';

class EndometriosisScreeningView extends RapidView<EndometriosisScreeningLogic> {
  static String routeName = "/endometriosis_screening";

  const EndometriosisScreeningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=> WillPopScope(
      onWillPop: () async {
        controller.pressBackWarning();
        return false;
        //return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>controller.pressBackWarning(),),
          title: Text("${'title_screening_page'.tr} ${kDebugMode?controller.currentPage.page:""}"),
          backgroundColor: Colors.white,
          foregroundColor: ColorConfig.textFieldIconColor,
          titleTextStyle: const TextStyle(fontSize: 18, color: ColorConfig.textFieldIconColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorConfig.backgroundColor,
        body: SafeArea(
          child: Column(children: [
            Expanded(child: BodyContainer(context))
          ],),
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Row(mainAxisAlignment:MainAxisAlignment.center, children: [
            Visibility(visible: !controller.isFirstPage, child: FlexButton('label_previous'.tr, flex: 1, background: Colors.white,textStyle: const TextStyle(color: ColorConfig.textFieldIconColor, fontWeight: FontWeight.bold), onPressed: controller.previousPage)),
            Visibility(visible: !controller.isLastPage, child: FlexButton('label_next'.tr, flex: 1,background: Colors.white, textStyle: const TextStyle(color: ColorConfig.textFieldIconColor,fontWeight: FontWeight.bold), onPressed: controller.nextPage)),
            Visibility(
              visible: controller.isLastPage,
              child: FlexButton('label_submit'.tr, flex: 1, onPressed: (){
                controller.submit();
              }),
            )
          ])
        ),
      ),
    ));
  }

  BodyContainer(BuildContext context) {
    return Stack(
      children: [
        FormBuilder(
            key: controller.form,
            onChanged: () {
              controller.form.currentState!.save();
              controller.form.currentState!.fields.entries.forEach((entry){
                if(entry.value.isDirty) {
                  try{
                    controller.formTransformedValues[entry.key] = entry.value.transformedValue;
                  } catch(e){
                    controller.formTransformedValues.remove(entry.key);
                  }
                  RLog.info("Dirty key ${entry.key}: ${controller.formTransformedValues[entry.key]}");
                }
                RLog.info(controller.formTransformedValues);
              });
              //final allKeys = controller.form.currentState?.fields.keys.toList();
              //RLog.info('All field keys: $allKeys');
            },
            child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.mPageController,
                itemCount: controller.screeningPages.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  return FutureBuilder<ScreeningPage> (
                      future: controller.getScreeningPages(index),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.hasData){
                          ScreeningPage screeningPage = snapshot.data;
                          return _PageScrollWrapper(
                            child: Column(
                              children: [
                                buildEachPage(
                                    screeningPage,
                                    context,
                                    controller.form,
                                    background: controller.isFirstPage? Colors.white: null,
                                    elevation: controller.isFirstPage? 0: 1,
                                    padding: controller.isFirstPage? 2: 8
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                  );
                }
            )
        ),
      ],
    );
  }



  @override
  void loadDependentLogics() {
    Get.lazyPut<EndometriosisRepository>(() => EndometriosisRepository());
    Get.lazyPut<EndometriosisScreeningLogic>(() => EndometriosisScreeningLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return EndometriosisHomeI18N.getTranslations();
  }
}

class _PageScrollWrapper extends StatefulWidget {
  final Widget child;
  const _PageScrollWrapper({required this.child});

  @override
  State<_PageScrollWrapper> createState() => _PageScrollWrapperState();
}

class _PageScrollWrapperState extends State<_PageScrollWrapper> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: _scrollController,
      interactive: true,
      thumbColor: ColorConfig.textFieldIconColor,
      thumbVisibility: true,
      trackVisibility: true,
      thickness: 6,
      radius: const Radius.circular(30),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: widget.child,
      ),
    );
  }
}
