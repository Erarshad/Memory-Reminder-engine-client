import 'dart:convert';

import 'package:calmwheel/const/const.dart';
import 'package:calmwheel/model/memory_structure_v2.dart';
import 'package:calmwheel/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../style/text_style.dart';
import 'dashboard_view_model.dart';

class ModalSheetBottomTop extends StatefulWidget {
  bool? isEdit;
  ProfileV2? data;
  int? index;
  ModalSheetBottomTop({super.key, required this.isEdit, this.data, this.index});

  @override
  State<ModalSheetBottomTop> createState() => _ModalSheetBottomTopState();
}

class _ModalSheetBottomTopState extends State<ModalSheetBottomTop> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String? base64;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isEdit ?? false) {
      setState(() {
        setDataForEdit();
      });
    }

    super.initState();
  }

  void setDataForEdit() {
    emailFieldController.text = widget.data?.email ?? "";
    titleFieldController.text = widget.data?.title ?? "";
    descriptionController.text = widget.data?.description ?? "";
    eventDateController.text = widget.data?.eventdate ?? "";
    tagsController.text = widget.data?.tags??"";
    base64 = widget.data?.image64 ?? "";
  }

  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = Provider.of<DashboardViewModel>(context);
    return Scaffold(
        backgroundColor: themeColor,
        body: SingleChildScrollView(
          padding: leftRightPadding,
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: normal,
                      controller: emailFieldController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: const Icon(Icons.mail),
                          prefixIconColor: Colors.white,
                          hintText: "Email",
                          hintStyle: normal,
                          filled: true,
                          fillColor: themeColor, //
                          enabledBorder: border,
                          focusedBorder: border,
                          disabledBorder: border,
                          errorStyle: error,
                          errorBorder: errorborder,
                          border: border),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            validateEmail(value) == false) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      style: normal,
                      controller: titleFieldController,
                      decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: const Icon(Icons.title),
                          prefixIconColor: Colors.white,
                          hintText: "Title",
                          hintStyle: normal,
                          filled: true,
                          fillColor: themeColor, //
                          enabledBorder: border,
                          focusedBorder: border,
                          disabledBorder: border,
                          errorStyle: error,
                          errorBorder: errorborder,
                          border: border),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      style: normal,
                      controller: descriptionController,
                      decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: const Icon(Icons.description),
                          prefixIconColor: Colors.white,
                          hintText: "Description",
                          hintStyle: normal,
                          filled: true,
                          fillColor: themeColor, //
                          enabledBorder: border,
                          focusedBorder: border,
                          disabledBorder: border,
                          errorStyle: error,
                          errorBorder: errorborder,
                          border: border),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid Description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        controller: eventDateController,
                        style: normal,
                        onTap: () {
                          viewModel.setDate(context, (val) {
                            setState(() {
                              eventDateController.text =
                                  "${val.day}/${val.month}/${val.year}";
                            });
                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: const Icon(Icons.calendar_month),
                            prefixIconColor: Colors.white,
                            hintText: "Event Date",
                            hintStyle: normal,
                            filled: true,
                            fillColor: themeColor, //
                            enabledBorder: border,
                            focusedBorder: border,
                            disabledBorder: border,
                            errorStyle: error,
                            errorBorder: errorborder,
                            border: border)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        style: normal,
                        controller: tagsController,
                        decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: const Icon(Icons.tag),
                            prefixIconColor: Colors.white,
                            hintText: "Tags (comma seprated)",
                            hintStyle: normal,
                            filled: true,
                            fillColor: themeColor, //
                            enabledBorder: border,
                            focusedBorder: border,
                            disabledBorder: border,
                            errorStyle: error,
                            errorBorder: errorborder,
                            border: border)),
                    (base64 ?? "").isNotEmpty
                        ? const SizedBox(
                            height: 10.0,
                          )
                        : const SizedBox(),
                    (base64 ?? "").isNotEmpty
                        ? Image.memory(base64Decode(base64 ?? ""))
                        : const SizedBox(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        style: normal,
                        controller: imageController,
                        onTap: () {
                          viewModel.pickImage((path, base64) {
                            imageController.text = path;
                            this.base64 = base64;
                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: const Icon(Icons.image),
                            prefixIconColor: Colors.white,
                            hintText: "Select image",
                            hintStyle: normal,
                            filled: true,
                            fillColor: themeColor, //
                            enabledBorder: border,
                            focusedBorder: border,
                            disabledBorder: border,
                            errorStyle: error,
                            errorBorder: errorborder,
                            border: border)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        secondarythemeColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            color: themeColor)))),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.isEdit == false) {
                                  viewModel.addMemory(
                                      emailFieldController.text,
                                      titleFieldController.text,
                                      descriptionController.text,
                                      eventDateController.text,
                                      base64,
                                      tagsController.text);
                                } else {
                                  viewModel.edit(
                                      emailFieldController.text,
                                      titleFieldController.text,
                                      descriptionController.text,
                                      eventDateController.text,
                                      base64,
                                      tagsController.text,
                                      widget.index ?? -1);
                                }
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              (widget.isEdit == false) ? "Add" : "Update",
                              style: smallerBlack,
                            ))
                      ],
                    )
                  ])),
        ));
  }
}
