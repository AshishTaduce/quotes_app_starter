import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:random_color/random_color.dart';

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(),
    home: QuotesPage(),
  ));
}

class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

Widget drawerRow(String text, IconData icon) {
  return Row(

    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text('$text', style: TextStyle(fontSize: 26)),
      Icon(icon, size: 30,),
    ],
  );
}

List<Widget> drawerItems = [
  drawerRow("Categories", Icons.rss_feed),
  drawerRow("Settings", Icons.settings)
];

bool isLoading = false;

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
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    Color fontColor =
        brightness == Brightness.light ? Colors.white : Colors.white;
    RandomColor _randomColor = RandomColor();
    var screenSize = MediaQuery.of(context).size.width;
    Color darkMode = Colors.yellow;
    IconData darkmode = Icons.brightness_7;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(darkmode, color: darkMode),
              onPressed: (){
                if (MediaQuery.of(context).platformBrightness == Brightness.light){
                  setState(() {
                    brightness = Brightness.dark;
                    darkMode = Colors.white;
                    darkmode = Icons.brightness_3;
                  });
                }
                else{
                  setState(() {
                    brightness = Brightness.light;
                    darkMode = Colors.yellow;
                    darkmode = Icons.brightness_7;
                  });
                }

              },
            )
          ],
        ),
        drawer: Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("John Doe"), accountEmail: null),
              new Column(children: drawerItems)
            ],
          ),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                // Box decoration takes a gradient
                gradient: brightness == Brightness.light
                    ? LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                            0.1,
                            0.4,
                            0.6,
                            0.9
                          ],
                        colors: [
                            Colors.yellow,
                            Colors.red,
                            Colors.indigo,
                            Colors.teal
                          ])
                    : LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.indigo, Colors.black87])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenSize * 0.1,
                ),
                Container(
                  height: screenSize * 0.7,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 32),
                        child: isLoading
                            ? Text(
                                'Loading Secrets for Success.',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: fontColor),
                                textAlign: TextAlign.left,
                              )
                            : Text(
                                '$quote',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: fontColor),
                                textAlign: TextAlign.left,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 32),
                        child: isLoading
                            ? Text(
                                'You are Amazing!!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: fontColor,
                                ),
                                textAlign: TextAlign.left,
                              )
                            : Text(
                                '$author',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: fontColor,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                              ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
                  child: ActionGradientButton(
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 3.0,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              brightness == Brightness.light
                                  ? _randomColor.randomColor(
                                      colorBrightness: ColorBrightness.light)
                                  : _randomColor.randomColor(
                                      colorBrightness: ColorBrightness.dark),
                            ),
                            value: null,
                          )
                        : Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 21,
                          ),
                    gradient: brightness == Brightness.dark
                        ? LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.45, 0.90],
                            colors: [Colors.blueAccent, Colors.greenAccent])
                        : LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [
                                0.0,
                                0.35,
                                0.65
                              ],
                            colors: [
                                Colors.yellow,
                                Colors.orange,
                                Colors.redAccent
                              ]),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        getQuotes();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ActionGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const ActionGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = 60,
    this.height = 60.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60.0,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(Radius.circular(72)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withAlpha(0),
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

