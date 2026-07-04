import 'package:flutter/material.dart';

import '../../exercise/exercise/file/views/question_webview.dart';

class ExerciseTitleDropdown extends StatefulWidget {
  final Map<String, dynamic> lesson; // بنبعتله الـ lesson اللي فيها children

  const ExerciseTitleDropdown({Key? key, required this.lesson}) : super(key: key);

  @override
  State<ExerciseTitleDropdown> createState() => _ExerciseTitleDropdownState();
}

class _ExerciseTitleDropdownState extends State<ExerciseTitleDropdown> {
  String? selectedTitle;
  List<Map<String, dynamic>> exerciseItems = [];

  @override
  void initState() {
    super.initState();
    exerciseItems = _extractExercises(widget.lesson);
  }

  // بتدور جوه children بتاعة الـ lesson وتجيب أي aimObject نوعه html
  List<Map<String, dynamic>> _extractExercises(Map<String, dynamic> lesson) {
    List<Map<String, dynamic>> result = [];

    List children = lesson["children"] ?? [];
    for (var child in children) {
      var aims = child["aims"];
      if (aims == null) continue;

      List aimObjects = aims["aimObjects"] ?? [];
      for (var obj in aimObjects) {
        if (obj["type"] == "html") {
          result.add({
            "title": obj["title"] ?? obj["nameInLesson"] ?? "Exercise",
            "url": obj["url"],
          });
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (exerciseItems.isEmpty) {
      return const SizedBox.shrink(); // مفيش exercises خالص
    }

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: "Exercise",
        border: OutlineInputBorder(),
      ),
      value: selectedTitle,
      items: exerciseItems.map((item) {
        return DropdownMenuItem<String>(
          value: item["title"],
          child: Text(item["title"]),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedTitle = value;
        });

        var selectedItem = exerciseItems.firstWhere(
              (item) => item["title"] == value,
        );

        // هنا تروحي لصفحة الـ Exercise (WebView مثلاً)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  QuestionWebView(
              url: selectedItem["url"],
              //title: selectedItem["title"],
            ),
          ),
        );
      },
    );
  }
}