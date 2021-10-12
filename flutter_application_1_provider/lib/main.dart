// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: changements(),
          ),
        ],
        child: MaterialApp(
          title: 'Questions/Réponses',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: MyHomePage(title: 'Questions-Réponses'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({required this.title});

  final String title;

  String option1 = "2";
  String option2 = "3";
  String next = "";
  String question = "combien fait 1 + 1 ?";

  var listquestion = [
    "combien fait 1 + 1 ?",
    "combien fait 2 + 2 ?",
    "combien fait 3 + 3 ?",
    "combien fait 4 + 4 ?",
    "combien fait 5 + 5 ?",
    "combien fait 6 + 6 ?",
    "combien fait 7 + 7 ?",
    "combien fait 8 + 8 ?",
    "combien fait 9 + 9 ?",
    "combien fait 10 + 10 ?"
  ];

  var listoption1 = [2, 8, 6, 8, 89, 12, 16, 16, 63, 25];
  var listoption2 = [5, 4, 7, 21, 10, 13, 14, 19, 18, 20];
  var listcorrectans = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20];

  void ifCorrectAnswer(String ans, context) {
    Provider.of<changements>(context, listen: false)
        .ifCorrectAnswer(ans, context);
  }

  void incrementIndex(context) {
    Provider.of<changements>(context, listen: false).incrementindex();
  }

  int getIndex(context) {
    return Provider.of<changements>(context, listen: true).getIndex;
  }

  int getElementList1(context, i) {
    return Provider.of<changements>(context, listen: false).getelementList1(i);
  }

  int getElementList2(context, i) {
    return Provider.of<changements>(context, listen: false).getelementList2(i);
  }

  @override
  Widget build(BuildContext context) {
    int index = getIndex(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
                width: 450.0,
                height: 250.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            "https://cdn.radiofrance.fr/s3/cruiser-production/2021/09/12ba2919-6cdc-42e6-9899-549065ca7bbc/1280x680_maths-gettyimages-525848845.jpg")))),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              width: 300,
              height: 200,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                  color: Colors.blue,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      topRight: const Radius.circular(30.0),
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0))),
              child: Text(
                listquestion[index],
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text(listoption1[index].toString()),
                  onPressed: () {
                    ifCorrectAnswer(
                        getElementList1(context, index).toString(), context);
                  },
                ),
                ElevatedButton(
                  child: Text(listoption2[index].toString()),
                  onPressed: () {
                    ifCorrectAnswer(
                        getElementList2(context, index).toString(), context);
                  },
                ),
                ElevatedButton(
                    child: Text('Suivante'),
                    onPressed: () {
                      incrementIndex(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class changements extends ChangeNotifier {
  String option1 = "2";
  String option2 = "3";
  String next = "";
  String question = "combien fait 1 + 1 ?";
  int index = 0;

  var listquestion = [
    "combien fait 1 + 1 ?",
    "combien fait 2 + 2 ?",
    "combien fait 3 + 3 ?",
    "combien fait 4 + 4 ?",
    "combien fait 5 + 5 ?",
    "combien fait 6 + 6 ?",
    "combien fait 7 + 7 ?",
    "combien fait 8 + 8 ?",
    "combien fait 9 + 9 ?",
    "combien fait 10 + 10 ?"
  ];

  var listoption1 = [2, 8, 6, 8, 89, 12, 16, 16, 63, 25];
  var listoption2 = [5, 4, 7, 21, 10, 13, 14, 19, 18, 20];
  var listcorrectans = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20];

  int get getIndex {
    return index;
  }

  int getelementList1(int i) {
    return listoption1[i];
  }

  int getelementList2(int i) {
    return listoption2[i];
  }

  void ifCorrectAnswer(String ans, context) {
    if (int.parse(ans) == listcorrectans[index]) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Réponse correcte !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Réponse incorrecte !"),
        ),
      );
    }

    if (index == listquestion.length - 1) {
      index = 0;
    } else {
      index++;
    }
    notifyListeners();
  }

  void incrementindex() {
    if (index == listquestion.length - 1) {
      index = 0;
    } else {
      index++;
    }
    notifyListeners();
  }
}
