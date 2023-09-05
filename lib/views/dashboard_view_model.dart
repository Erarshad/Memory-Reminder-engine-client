import 'dart:convert';
import 'dart:io';
import 'package:calmwheel/const/const.dart';
import 'package:calmwheel/model/memory_structure_v2.dart';
import 'package:calmwheel/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DashboardViewModel extends ChangeNotifier {
  bool isBusy = false;
  setBusy(bool val) {
    isBusy = val;
    notifyListeners();
  }

  onPageLoad() async {
    fetchMemories();
  }

  void fetchMemories() async {
    setBusy(true);
    final response = await http.get(Uri.parse("$baseUrl/getMemories"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final profile = profileFromJson(response.body);
      memories = profile;
      searchFilter();

      notifyListeners();
    } else {
      setBusy(false);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('failed to load data');
    }

    setBusy(false);
  }

  void addMemoryToServer(ProfileV2 pf) async {
    setBusy(true);
    final response = await http.post(Uri.parse("$baseUrl/createMemory"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(pf));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      showToast("Memory added successfully");
    } else {
      setBusy(false);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('failed to load data');
    }

    setBusy(false);
  }

  void updateMemoryToServer(ProfileV2 pf) async {
    setBusy(true);
    final response = await http.post(Uri.parse("$baseUrl/updateMemory"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(pf));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      showToast("Memory updated successfully");
    } else {
      setBusy(false);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('failed to load data');
    }

    setBusy(false);
  }

  List<ProfileV2> memories = [];
  TextEditingController searchField = TextEditingController();
  DateTime now = DateTime.now();
  void setDate(BuildContext context, Function(DateTime) onDateChange) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      now = picked;

      onDateChange(picked);

      notifyListeners();
    }
  }

  void pickImage(Function(String, String) path) async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
    if (image != null) {
      List<int> imageBytes = File(image.path).readAsBytesSync();

      String base64Image = base64Encode(imageBytes);
      path(image.path, base64Image);
      notifyListeners();
    }
  }

  int id = 0;
  void addMemory(String email, String title, String description,
      String? eventDate, String? base64, String? tags) {
         id++;
    ProfileV2 pf = ProfileV2(
        id: id,
        email: email,
        title: title,
        description: description,
        eventdate: eventDate ?? "",
        image64: base64,
        dateAdded: "${now.day}/${now.month}/${now.year}",
        tags: tags ?? "");

    memories.add(pf);
    searchFilter();
    //make api call
    addMemoryToServer(pf);
   

    notifyListeners();
  }

  void edit(String email, String title, String description, String? eventDate,
      String? base64, String? tags, int index) {
    ProfileV2 pf = memories[index];
    pf.email = email;
    pf.title = title;
    pf.description = description;
    pf.eventdate = eventDate ?? "";
    pf.image64 = base64;
    pf.tags = tags ?? "";

    searchFilter();

    //make api call
    updateMemoryToServer(pf);

    notifyListeners();
  }

  List<ProfileV2> uiProfileList = [];
  void searchFilter() {
    if (searchField.text.isEmpty) {
      uiProfileList = memories;
      notifyListeners();
    } else {
      uiProfileList = memories
          .where((element) =>
              (element.title
                  .toLowerCase()
                  .contains(searchField.text.toLowerCase())) ||
              (element.tags?.contains(searchField.text) == true))
          .toList();
      notifyListeners();
    }
  }

  void sortByEventDate() {
    try {
      uiProfileList.sort((a, b) {
        if ((a.eventdate ?? "").isEmpty || (b.eventdate ?? "").isEmpty) {
          return 0;
        }
        return DateFormat("dd/mm/yyyy")
            .parse(a.eventdate ?? "")
            .compareTo(DateFormat("dd/mm/yyyy").parse(b.eventdate ?? ""));
      });

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void sortByLastReminderDate() {
    try {
      uiProfileList.sort((a, b) {
        if ((a.lastSentDate ?? "").isEmpty || (b.lastSentDate ?? "").isEmpty) {
          return 0;
        }
        return DateFormat("dd/mm/yyyy")
            .parse(a.lastSentDate ?? "")
            .compareTo(DateFormat("dd/mm/yyyy").parse(b.lastSentDate ?? ""));
      });

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void sortByDateAdded() {
    try {
      uiProfileList.sort((a, b) {
        if ((a.dateAdded).isEmpty || (b.dateAdded).isEmpty) {
          return 0;
        }
        return DateFormat("dd/mm/yyyy")
            .parse(a.dateAdded)
            .compareTo(DateFormat("dd/mm/yyyy").parse(b.dateAdded));
      });

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
