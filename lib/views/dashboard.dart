import 'dart:convert';

import 'package:calmwheel/const/const.dart';
import 'package:calmwheel/style/text_style.dart';
import 'package:calmwheel/views/dashboard_view_model.dart';
import 'package:calmwheel/views/sort_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_new_modal_sheet.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DashboardViewModel viewModel =
          Provider.of<DashboardViewModel>(context, listen: false);
      viewModel.onPageLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = Provider.of<DashboardViewModel>(context);
    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
          child: Padding(
              padding: leftRightPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: viewModel.searchField,
                            style: normal,
                            onChanged: (val) {
                              viewModel.searchFilter();
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "Search by title, tags",
                                hintStyle: normal,
                                filled: true,
                                fillColor: themeColor, //
                                enabledBorder: border,
                                focusedBorder: border,
                                disabledBorder: border,
                                border: border)),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: themeColor,
                                 
                                  builder: (context) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      child: SortOrderSheet()),
                                );
                              },
                              child: const Icon(
                                Icons.filter_alt_outlined,
                                size: 35.0,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(child: 
                  Stack(children: [
                    if (viewModel.memories.isEmpty) ...{
                      viewModel.isBusy == false?
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No memory Found :( Please try creating one.",
                            style: normal,
                          )):const SizedBox()
                    } else ...{
                      viewModel.isBusy == false
                          ? 
                              SingleChildScrollView(
                                  child: Column(
                                      key: Key(viewModel.searchField.text),
                                      children: List.generate(
                                        viewModel.uiProfileList.length,
                                        (index) {
                                          viewModel.id =
                                              viewModel.uiProfileList[index].id;
                                          return InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  backgroundColor: themeColor,
                                                  isScrollControlled: true,
                                                  builder: (context) =>
                                                      SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.55,
                                                    child: ModalSheetBottomTop(
                                                      isEdit: true,
                                                      data: viewModel
                                                          .uiProfileList[index],
                                                      index: index,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        viewModel
                                                            .uiProfileList[
                                                                index]
                                                            .title,
                                                        style: normal,
                                                      )),
                                                      Text(
                                                        viewModel
                                                                .uiProfileList[
                                                                    index]
                                                                .eventdate ??
                                                            "",
                                                        style: normal,
                                                      ),
                                                    ],
                                                  ),
                                                  viewModel.uiProfileList[index]
                                                              .lastSentDate !=
                                                          null
                                                      ? const SizedBox(
                                                          height: 5.0,
                                                        )
                                                      : const SizedBox(),
                                                  viewModel.uiProfileList[index]
                                                              .lastSentDate !=
                                                          null
                                                      ? Text(
                                                          "Last sent: ${viewModel.uiProfileList[index].lastSentDate ?? ""}",
                                                          style: normal,
                                                        )
                                                      : const SizedBox(),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    "Date Added: ${viewModel.uiProfileList[index].dateAdded}",
                                                    style: normal,
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  (viewModel
                                                                  .uiProfileList[
                                                                      index]
                                                                  .tags ??
                                                              "")
                                                          .isNotEmpty
                                                      ? Wrap(
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                          children: List.generate(
                                                              (viewModel
                                                                          .uiProfileList[
                                                                              index]
                                                                          .tags
                                                                          ?.split(
                                                                              ",") ??
                                                                      [])
                                                                  .length,
                                                              (id) {
                                                            return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            3.0,
                                                                        right:
                                                                            3.0),
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5.0,
                                                                      right:
                                                                          5.0,
                                                                      top: 2.0,
                                                                      bottom:
                                                                          2.0),
                                                                  decoration: const BoxDecoration(
                                                                      color:
                                                                          secondarythemeColor,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(40.0))),
                                                                  child: Text(viewModel
                                                                          .uiProfileList[
                                                                              index]
                                                                          .tags
                                                                          ?.split(
                                                                              ",")[id]
                                                                          .trim() ??
                                                                      ""),
                                                                ));
                                                          }))
                                                      : const SizedBox(),
                                                  (viewModel
                                                                  .uiProfileList[
                                                                      index]
                                                                  .tags
                                                                  ?.split(
                                                                      ",") ??
                                                              [])
                                                          .isNotEmpty
                                                      ? const SizedBox(
                                                          height: 5.0,
                                                        )
                                                      : const SizedBox(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        viewModel
                                                            .uiProfileList[
                                                                index]
                                                            .description,
                                                        style: small,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider()
                                                ],
                                              ));
                                        },
                                      )))
                          : const SizedBox()
                    },
                    viewModel.isBusy
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox()
                  ]))
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: themeColor,
            isScrollControlled: true,
            builder: (context) => SizedBox(
              child: ModalSheetBottomTop(
                isEdit: false,
              ),
              height: MediaQuery.of(context).size.height * 0.55,
            ),
          );
        },
        child: const Icon(Icons.add, size: 40, color: themeColor),
        elevation: 3.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
