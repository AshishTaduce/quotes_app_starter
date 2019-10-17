import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: QuotesPage(),
  ));
}

class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

bool isLoading = false;

//double loadTime = 0;
class _QuotesPageState extends State<QuotesPage> {
  String quote = 'Fetching Secrets to Greatness';
  String author = "You're Awesome";

  Future<void> getQuotes() async {
    Map jsonMap;
    Response response = await get('https://favqs.com/api/qotd');
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonMap = await jsonDecode(response.body);
      setState(() {
        author = jsonMap['quote']['author'];
        quote = jsonMap['quote']['body'];
        isLoading = false;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenSize * 0.5,
            ),
            Container(
              height: screenSize * 0.6,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
                    child: isLoading
                        ? Text(
                            'Loading Secrets for Success.',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          )
                        : Text(
                            '$quote',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: isLoading
                        ? Text(
                            'You are Amazing!!',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.left,
                          )
                        : Text(
                            '$author',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.left,
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 8),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: isLoading
                    ? CircularProgressIndicator(
                        strokeWidth: 3.0,
                        backgroundColor: Colors.blue,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        value: null,
                      )
                    : Icon(
                        Icons.arrow_forward,
                        color: Colors.red,
                        size: 21,
                      ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    //sleep(const Duration(seconds:1));
                    getQuotes();
                  });
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
