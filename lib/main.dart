import 'package:flutter/material.dart';
import 'package:lifeasy_login/registration.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _dropDownValue = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            "assets/one.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomLeft,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.portrait_rounded,
                color: Colors.black,
                size: 56.0,
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    "Please select your Language",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(72, 0, 72, 0),
                child: Center(
                  child: Text(
                    'You can change the language at any time.',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton(
                  hint: _dropDownValue == " "
                      ? Text('English')
                      : Text(
                          _dropDownValue,
                          style: TextStyle(color: Colors.black),
                        ),
                  items: ['English', 'Hindi'].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownValue = val.toString();
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: double.infinity,
                child: MaterialButton(
                  color: const Color.fromRGBO(46, 59, 98, 1.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registartion()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    )));
  }
}
