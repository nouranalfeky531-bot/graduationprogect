import 'package:flutter/material.dart';
import '../../cotent/content choice.dart';
import '../models/Videoresponse.dart';
import '../videosurvices/videoprovider.dart';
import '../videoveiw.dart';
import '../videoviewmodel.dart';
import 'package:provider/provider.dart';

class TitleDropdown extends StatefulWidget {
  const TitleDropdown({super.key});

  @override
  State<TitleDropdown> createState() => _TitleDropdownState();
}

class _TitleDropdownState extends State<TitleDropdown> {
  List<String> _titles = [];
  String? _selectedTitle;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTitles();
  }

  Future<void> _loadTitles() async {
    final titles = await videoviewModel.getAllTitles();
    setState(() {
      _titles = titles;
      _loading = false;
    });
  }

  Future<void> _onTitleSelected(String title) async {
    try {
      final navigator = Navigator.of(context);
      final videoProvider = context.read<VideoProvider>();

      var result = await ContentChoice.openContentByTitle(title);

      videoProvider.setSelectedTitle(title);

      if (result is Videoresponse) {
        navigator.push(
          MaterialPageRoute(builder: (_) => const Videoveiw()),
        );
      }
    } catch (e) {
      print("onTap error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const CircularProgressIndicator();

    return DropdownButton<String>(
      hint: const Text("اختار عنوان"),
      value: _selectedTitle,
      items: _titles.map((title) {
        return DropdownMenuItem<String>(
          value: title,
          child: Text(title),
        );


      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() => _selectedTitle = value);
        _onTitleSelected(value);
      },
    );
  }
}