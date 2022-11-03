import 'dart:convert';

import 'package:bmi_app/model/model.dart';
import 'package:bmi_app/second_page.dart';
import 'package:bmi_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExercisesModel> allData = [];

  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";
  bool isLoading = false;
  fatchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var resposce = await http.get(Uri.parse(link));
      print("status code is ${resposce.statusCode}");
      //print("${resposce.body}");
      if (resposce.statusCode == 200) {
        final item = jsonDecode(resposce.body);
        for (var data in item["exercises"]) {
          ExercisesModel exercisesModel = ExercisesModel(
              id: data["id"],
              title: data["title"],
              thumbnail: data["thumbnail"],
              gif: data["gif"],
              seconds: data["seconds"]);
          setState(() {
            allData.add(exercisesModel);
          });
        }
        print("total length in ${allData.length}");
      } else {
        Fluttertoast.showToast(
            msg: "Something Is Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Something is Wrong $e");
    }
  }

  @override
  void initState() {
    fatchData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          // allData.isEmpty
          //     ? spinkit
          //     :
          ModalProgressHUD(
        inAsyncCall: isLoading == true,
        progressIndicator: spnkit,
        child: Container(
          width: double.infinity,
          child: ListView.builder(
              itemCount: allData.length,
              shrinkWrap: true,
              itemBuilder: (contex, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (contex) => SecondPage(
                              exercisesModel: allData[index],
                            )));
                  },
                  child: Container(
                    height: 170,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(children: [
                        Image.network(
                          "${allData[index].thumbnail}",
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              child: Text(
                                "${allData[index].title}",
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.all(20),
                              height: 65,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.black12,
                                    Colors.black38,
                                    Colors.black54,
                                    Colors.black87
                                  ])),
                            ))
                      ]),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
