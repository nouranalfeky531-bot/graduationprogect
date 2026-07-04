import 'package:flutter/material.dart';
import '../../cotent/content choice.dart';

import 'package:provider/provider.dart';

import '../models/Pdfresponse.dart';
import '../pdfprovider.dart';
import '../pdfview.dart';
import '../pdfviewmodel.dart';

class pdfTitleDropdown extends StatefulWidget {
  const pdfTitleDropdown({super.key});

  @override
  State<pdfTitleDropdown> createState() => _pdfTitleDropdownState();
}

class _pdfTitleDropdownState extends State<pdfTitleDropdown> {
  List<String> _pdftitles = [];
  String? _pdfselectedTitle;
  bool _pdfloading = true;

  @override
  void initState() {
    super.initState();
    _loadTitles();
  }

  Future<void> _loadTitles() async {
    final titles = await PdfViewModel.getAllTitles();
    setState(() {
      _pdftitles = titles;
      _pdfloading = false;
    });
  }

  Future<void> _onTitleSelected(String title) async {
    try {
      final navigator = Navigator.of(context);
      final pdfProvider = context.read<PdfProvider>();
      var result = await ContentChoice.openContentByTitle(title);

      pdfProvider.setSelectedTitle(title);

      if (result is Pdfresponse) {
        navigator.push(
          MaterialPageRoute(builder: (_) => const PdfView()),
        );
      }
    } catch (e) {
      print("onTap error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pdfloading) return const CircularProgressIndicator();

    return DropdownButton<String>(
      hint: const Text("اختار عنوان"),
      value: _pdfselectedTitle,
      items: _pdftitles.map((title) {
        return DropdownMenuItem<String>(
          value: title,
          child: Text(title),
        );


      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() => _pdfselectedTitle = value);
        _onTitleSelected(value);
      },
    );
  }
}