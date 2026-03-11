import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_progect/modules/coursescrean/widgets/pdfpage.dart';
import 'package:graduation_progect/modules/coursescrean/widgets/vediopage.dart';



class ContentPage extends StatefulWidget {


  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  List lessons = [];

  Future loadJson() async {

    String data = await rootBundle.loadString('assets/LessonSample.json');
    var jsonResult = json.decode(data);

    setState(() {
      lessons = jsonResult["ontology"][0]["children"];
    });

  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Content")),

      body: ListView.builder(
        itemCount: lessons.length,

        itemBuilder: (context,index){

          var lesson = lessons[index];
          var objects = lesson["aims"]["aimObjects"];

          return Card(

            margin: const EdgeInsets.all(10),

            child: ExpansionTile(

              title: Text(
                lesson["name"],
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),

              children: List.generate(objects.length, (i){

                var obj = objects[i];

                return ListTile(

                  leading: Icon(
                    obj["type"] == "pdf"
                        ? Icons.picture_as_pdf
                        : Icons.play_circle,
                    color: Colors.blue,
                  ),

                  title: Text(obj["title"]),

                  onTap: (){

                    if(obj["type"] == "pdf"){

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>PdfPage(
                            url: obj["url"],
                            title: obj["title"],
                          ),
                        ),
                      );

                    }else{

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>VideoPage(
                            url: obj["url"],
                            title: obj["title"],
                          ),
                        ),
                      );

                    }

                  },

                );

              }),

            ),

          );

        },

      ),

    );

  }

}