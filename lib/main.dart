import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert; // Read JSON
import 'dart:developer' as developer; // Log errors;
import 'package:intl/intl.dart';

import 'Model/my_currency.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Online Currencies Equality Rate App',
        theme: ThemeData(
            textTheme: const TextTheme(
                headline1: TextStyle(
                    fontFamily: 'MyLeaguegothic',
                    fontSize: 24,
                    fontWeight: FontWeight.normal),
                bodyText1: TextStyle(
                    fontFamily: 'MyQuestrial',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                headline2: TextStyle(
                    fontFamily: 'MyLeaguegothic',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                headline3: TextStyle(
                    fontFamily: 'MyLeaguegothic',
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w400),
                headline4: TextStyle(
                    fontFamily: 'MyLeaguegothic',
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.w400))),
        debugShowCheckedModeBanner: false, // remove the debug banner
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future getResponse(BuildContext context) async {
    developer.log("getResponse", name: "widgetLifeCycle");
    var url = "http://rubikidea.com/flutter/prices.json";
    var value = await http.get(Uri.parse(url));

    if (currency.isEmpty) {
      // Check if connection established
      if (value.statusCode == 200) {
        _showSnackBar(context, "Successful Update");
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]['id'],
                  title: jsonList[i]['title'],
                  price: jsonList[i]['price'],
                  changes: jsonList[i]['changes'],
                  status: jsonList[i]['status']));
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    developer.log("initState", name: "widgetLifeCycle");
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    developer.log("didUpdateWidget", name: "widgetLifeCycle");
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    developer.log("didChangeDependencies", name: "widgetLifeCycle");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    developer.log("deactivate", name: "widgetLifeCycle");
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    developer.log("dispose", name: "widgetLifeCycle");
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    developer.log("build: Home", name: "widgetLifeCycle");
    getResponse(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 243, 243, 243),
          appBar: AppBar(
            elevation: 0, // Remove menu shaddow
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Image.asset("assets/images/logo.png"),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 50, 0),
                    child: Text("Online Currencies Equality Rate",
                        style: Theme.of(context).textTheme.headline1),
                  )),
              const SizedBox(
                width: 1,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Image.asset("assets/images/menu.png"),
                      ))),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              // Set padding to the whole column:
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  Row(
                    // Setup ltr to end, direction correction!
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/question.png"),
                      // Set space between Text & Image
                      const SizedBox(width: 8),
                      Text("Markets Currencies",
                          style: Theme.of(context).textTheme.headline1),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Currency rates are representative of the Bloomberg Generic Composite rate (BGN), a representation based on indicative rates only contributed by market participants. The data is NOT based on any actual market trades. ",
                    style: Theme.of(context).textTheme.bodyText1,
                    // textDirection: TextDirection.RTL,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                    child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                        color: Color.fromARGB(255, 130, 130, 130),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "CURRENCY",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "VALUE",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "CHANGE",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    // TEST: How much of the page is:
                    // color: Colors.blue,

                    child: listFutureBuilder(context),
                  ),
                  // Reload button goes here!
                  // update button box
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 16,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: const Color.fromARGB(255, 232, 232, 232)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // update button
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 16,
                              child: TextButton.icon(
                                onPressed: () => {
                                  currency.clear(),
                                  listFutureBuilder(context)
                                }, //1
                                icon: const Icon(
                                  //2
                                  CupertinoIcons.refresh_bold,
                                  color: Colors.black,
                                ),
                                label: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: Text(
                                    //3
                                    "Update",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                style: ButtonStyle(
                                    //4
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 202, 193, 255)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(1000)))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text("Last update at ${_getTime()}"),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    // Just accept a widget as return value, then:

    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                // Effect on Scroll, mostly showable on phone, not windows!
                physics: const BouncingScrollPhysics(),
                // Number of data's
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: MyItem(position, currency),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 4 == 0) {
                    return const Ad();
                  } else {
                    // Return an empty box
                    return const SizedBox.shrink();
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
      future: getResponse(context),
    );
  }

  String _getTime() {
    developer.log("_getTime", name: "widgetLifeCycle");
    DateTime now = DateTime.now();
    return DateFormat('kk:mm').format(now);
  }
}

void _showSnackBar(BuildContext context, String msg) {
  developer.log("_showSnackBar", name: "widgetLifeCycle");
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: Theme.of(context).textTheme.headline1,
    ),
    backgroundColor: Colors.green,
  ));
}

class Ad extends StatelessWidget {
  const Ad({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    developer.log("build: Ad", name: "widgetLifeCycle");
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(boxShadow: const <BoxShadow>[
        BoxShadow(blurRadius: 1.0, color: Colors.grey)
      ], borderRadius: BorderRadius.circular(1000), color: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Advertisement",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  int position;
  List<Currency> currency;

  MyItem(
    this.position,
    this.currency, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    developer.log("build: MyItem", name: "widgetLifeCycle");
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(boxShadow: const <BoxShadow>[
        BoxShadow(blurRadius: 1.0, color: Colors.grey)
      ], borderRadius: BorderRadius.circular(1000), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            currency[position].title!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            currency[position].price.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            currency[position].changes.toString(),
            style: currency[position].status == 'n'
                ? Theme.of(context).textTheme.headline3
                : Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
