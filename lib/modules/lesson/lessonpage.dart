import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_progect/modules/video/videoviewmodel.dart';
import '../video/videosurvices/videoprovider.dart';
import '../video/videoveiw.dart';

class TitleDropdown extends StatefulWidget {
  const TitleDropdown();

  @override
  State<TitleDropdown> createState() => _TitleDropdownState();
}

class _TitleDropdownState extends State<TitleDropdown> {

  List<String> _titles = [];
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

  void _onTitleSelected(String? title) {

    if (title == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) {
            final provider = VideoProvider();
            provider.setSelectedTitle(title);
            return provider;
          },
          child: const Videoveiw(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("choose your video"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : DropdownButtonFormField<String>(
          hint: const Text('اختر عنوان'),
          isExpanded: true,
          items: _titles
              .map((title) => DropdownMenuItem(
            value: title,
            child: Text(title),
          ))
              .toList(),
          onChanged: _onTitleSelected,
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:graduation_progect/modules/video/videoviewmodel.dart';
// import 'package:provider/provider.dart';
// import '../video/videosurvices/videoprovider.dart';
// import '../video/videoveiw.dart';
//
// class TitleDropdown extends StatefulWidget {
//   const TitleDropdown();
//
//   @override
//   State<TitleDropdown> createState() => _TitleDropdownState();
// }
//
// class _TitleDropdownState extends State<TitleDropdown> {
//
//   final VideoProvider videoProvider = VideoProvider();
//
//   List<String> _titles = [];
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadTitles();
//   }
//
//   Future<void> _loadTitles() async {
//     final titles = await videoviewModel.getAllTitles();
//
//     setState(() {
//       _titles = titles;
//       _loading = false;
//     });
//   }
//
//   Future<void> _onTitleSelected(String? title) async {
//     if (title == null) return;
//
//     videoProvider.setSelectedTitle(title);
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ChangeNotifierProvider.value(
//           value: videoProvider,
//           child: const Videoveiw(),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("choose your video")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: _loading
//             ? const Center(child: CircularProgressIndicator())
//             : DropdownButtonFormField<String>(
//           value: videoProvider.selectedTitle,
//           hint: const Text('اختر عنوان'),
//           isExpanded: true,
//           items: _titles.map((title) {
//             return DropdownMenuItem(
//               value: title,
//               child: Text(title),
//             );
//           }).toList(),
//           onChanged: _onTitleSelected,
//           decoration: const InputDecoration(
//             labelText: 'العنوان',
//           ),
//         ),
//       ),
//     );
//   }
// }











// import 'package:flutter/material.dart';
// import 'package:graduation_progect/modules/video/videoviewmodel.dart';
// import 'package:provider/provider.dart';
//
// import '../video/videosurvices/titleprovider.dart';
// import '../video/videosurvices/videoprovider.dart';
// import '../video/videoveiw.dart';
//
//
// class TitleDropdown extends StatefulWidget {
//   const TitleDropdown();
//
//   @override
//   State<TitleDropdown> createState() => _TitleDropdownState();
// }
//
// class _TitleDropdownState extends State<TitleDropdown> {
//   // final videoProvider = widget.context.watch<VideoProvider>();
//   VideoProvider videoProvider = VideoProvider();
//   List<String> _titles = [];
//   // String? selectedTitle;
//   Map<String, dynamic>? _selectedData;
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadTitles();
//   }
//
//   Future<void> _loadTitles() async {
//     await videoProvider.fetchvideodata();
//     final titles = await videoviewModel.getAllTitles();
//     setState(() {
//       _titles = titles;
//       _loading = false;
//     });
//   }
//
//   Future<void> _onTitleSelected(String? title) async {
//     if (title == null) return;
//
//        videoProvider .setSelectedTitle(title);
//
//     setState(() {
//       videoProvider. selectedTitle = title;
//        _selectedData = null; // reset أثناء التحميل
//     });
//     Navigator.push(context, MaterialPageRoute(builder: (_)=>   Videoveiw()));
//
//     // final data = await JsonLoader.getFileByTitle(title);
//     // setState(() {
//     //   _selectedData = data;
//     // });
//   }
//   @override
//   Widget build(BuildContext context) {
//     // final videoProvider = context.watch<VideoProvider>();
//
//      return ChangeNotifierProvider(
//        create: (_) => VideoProvider(),
//        child: Consumer(
//         builder: (context, videoProvider, child){
//         return Scaffold(
//           appBar: AppBar(title: const Text("choose your video")),
//           body: Padding(
//             padding: const EdgeInsets.all(16),
//             child: _loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // الـ Dropdown
//                 DropdownButtonFormField<String>(
//                   value:
//                   hint:  const Text('اختر عنوان'),
//                   isExpanded: true,
//                   items: _titles
//                       .map((title) => DropdownMenuItem(
//                     value: title,
//                     child: Text(title),
//                   ))
//                       .toList(),
//                   onChanged: _onTitleSelected,
//                   decoration: const InputDecoration(
//                     // border: OutlineInputBorder(),
//                     labelText: 'العنوان',
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // عرض البيانات
//                 if (_selectedData != null)
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Text(
//                         _selectedData.toString(),
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//         }
//            ),
//      );
//   }
// }