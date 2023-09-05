import 'dart:convert';

import 'package:calmwheel/const/const.dart';
import 'package:calmwheel/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/memory_structure.dart';
import '../style/text_style.dart';
import 'dashboard_view_model.dart';

class SortOrderSheet extends StatefulWidget {
  SortOrderSheet({super.key});

  @override
  State<SortOrderSheet> createState() => _SortOrderSheetState();
}

class _SortOrderSheetState extends State<SortOrderSheet> {
  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = Provider.of<DashboardViewModel>(context);
    return Scaffold(
        backgroundColor: themeColor,
        body: SingleChildScrollView(
            padding: leftRightPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.event,
                    color: secondarythemeColor,
                  ),
                  title: Text(
                    "Sort by event date",
                    style: normal,
                  ),
                  onTap: () {
                    viewModel.sortByEventDate();
                    Navigator.of(context).pop();

                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.calendar_month,
                    color: secondarythemeColor,
                  ),
                  title: Text(
                    "Sort by last reminder sent",
                    style: normal,
                  ),
                  onTap: () {
                    viewModel.sortByLastReminderDate();
                      Navigator.of(context).pop();

                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.calendar_today,
                    color: secondarythemeColor,
                  ),
                  title: Text(
                    "Sort by Date Added",
                    style: normal,
                  ),
                  onTap: () {
                    viewModel.sortByDateAdded();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )));
  }
}
