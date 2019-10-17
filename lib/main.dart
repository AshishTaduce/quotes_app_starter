import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: QuotesPage(),
    )
  );
}

class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  String quote = 'Fetching quote';
  String author = "Mark";
  Future <void> getQuotes() async {
    Map jsonMap;
    Response response = await get('https://favqs.com/api/qotd');
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonMap = await jsonDecode(response.body);
      setState(() {
        author = jsonMap['quote']['author'];
        quote = jsonMap['quote']['body'];
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuotes();
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: screenSize * 0.5,
                ),
                Container(
                  height: screenSize * 0.7,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '$quote',style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                        ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '$author',style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        child: Icon(Icons.arrow_forward, color: Colors.red,),
                        onPressed: getQuotes,
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
}

