import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:random_color/random_color.dart';
import 'my_flutter_app_icons.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: QuotesPage(),
    );
  }
}

class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

//Widget categories() {
//  return DropdownButton<String>(
//    value: 'Categories',
//    items: <String>['A', 'B', 'C', 'D'].map((String value) {
//      return new DropdownMenuItem<String>(
//        value: value,
//        child: new Text(value),
//      );
//    }).toList(),
//    onChanged: (_) {},
//  );
//}

Widget drawerRow(String text, IconData icon, Function onPress) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FlatButton(
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$text', style: TextStyle(fontSize: 26)),
          Icon(
            icon,
            size: 30,
          ),
        ],
      ),
    ),
  );
}

void showAboutMe(){
  if(showAbout){
    showAbout = false;
  }
  else{
    showAbout = true;
  }
}
void changeImage() {
  drawerImage = mode
      ? 'https://images.bewakoof.com/t540/stay-awesome-round-neck-3-4th-sleeve-t-shirt-women-s-printed-round-neck-3-4-sleeve-t-shirts-211146-1551690998.jpg'
      : 'http://edlester.com/wp-content/uploads/2017/01/take-time-to-do-what-makes-your-soul-happy-daily-300x300.jpg';
}

String drawerImage;
bool mode = true;
bool showAbout = false;
bool isLoading = true;
bool showCategories = false;

List<Widget> categories = [

];

Widget drawerItems =
  SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: <Widget>[
        Image.network(drawerImage),
        //categories(),
        drawerRow("Categories", Icons.rss_feed, null),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: Column(
            children: <Widget>[
              drawerRow("Home", Icons.home, null),
              drawerRow("Time", Icons.hourglass_empty, null),
              drawerRow("Friends", Icons.people_outline, null),
            ],
          ),
        ),
        drawerRow("Settings", Icons.settings, null),
        drawerRow("About Us", Icons.tag_faces, showAboutMe),
      ],
    ),
  );



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

  void changeImage() {
    drawerImage = mode
        ? 'https://images.bewakoof.com/t540/stay-awesome-round-neck-3-4th-sleeve-t-shirt-women-s-printed-round-neck-3-4-sleeve-t-shirts-211146-1551690998.jpg'
        : 'http://edlester.com/wp-content/uploads/2017/01/take-time-to-do-what-makes-your-soul-happy-daily-300x300.jpg';
    setState(() {});
  }

  @override
  void initState() {
    changeImage();
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _showcontent() {
      showDialog<Null>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new CircleAvatar(
              radius: 64,
              child: Image.network('https://cdn.nohat.cc/thumb/f/720/4768618252337152.jpg'),
            ),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text('About Me'),
                  Text('r/madlads')
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    Color fontColor = mode ? Colors.white : Colors.white;
    RandomColor _randomColor = RandomColor();
    var screenSize = MediaQuery.of(context).size.width;
    Color randColor = _randomColor.randomColor();
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: mode ? Color(0xffe3c7e0) : Color(0xff222732),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Image.network(drawerImage),
              //categories(),
              drawerRow("Categories", Icons.rss_feed, null),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Column(
                  children: <Widget>[
                    drawerRow("Home", Icons.home, null),
                    drawerRow("Time", Icons.hourglass_empty, null),
                    drawerRow("Friends", Icons.people_outline, null),
                  ],
                ),
              ),
              drawerRow("Settings", Icons.settings, null),
              drawerRow("About Us", Icons.tag_faces, _showcontent),
            ],
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[

            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                // Box decoration takes a gradient
                  gradient: mode
                      ? LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blue, Colors.red])
                      : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.indigo, Colors.black87])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                        child: IconButton(
                          iconSize: 46,
                          icon: mode
                              ? Icon(
                            Icons.brightness_7,
                            color: Colors.yellow,
                          )
                              : Icon(
                            Icons.brightness_3,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (mode == true) {
                              setState(() {
                                mode = false;
                              });
                            } else {
                              setState(() {
                                mode = true;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: screenSize * 0.8,
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
                          randColor,
                        ),
                        value: null,
                      )
                          : Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 21,
                      ),
                      gradient: mode
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
                          randColor = _randomColor.randomColor();
                          isLoading = true;
                          getQuotes();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Visibility(
                visible: showAbout,
                child : AlertDialog(
                  title: new Text('You clicked on'),
                  content: new SingleChildScrollView(
                    child: new ListBody(
                      children: <Widget>[
                        new Text('This is a Dialog Box. Click OK to Close.'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
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
