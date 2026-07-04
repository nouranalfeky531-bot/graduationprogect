import 'package:flutter/material.dart';
import 'package:graduation_progect/core/theme/app_colors.dart';

import 'glossary.dart';

class GlossaryTab extends StatefulWidget {
  final List<Glossary> glossary;

  const GlossaryTab({ required this.glossary});

  @override
  State<GlossaryTab> createState() => _GlossaryTabState();
}

class _GlossaryTabState extends State<GlossaryTab> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredGlossary = widget.glossary
        .where((g) =>
        g.term.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search term...",
              // hintStyle: TextStyle(color: AppColors.secondaryColor),
              prefixIcon: const Icon(Icons.search,),
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.appBarColor),
              borderRadius: BorderRadius.circular(12),
            ),),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredGlossary.length,
            itemBuilder: (context, index) {
              final item = filteredGlossary[index];




              return ExpansionTile(
                title: Text(item.term,style: TextStyle(color: Colors.black),),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(item.definition,style: TextStyle(color: Colors.black)),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }}