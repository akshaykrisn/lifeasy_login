import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifeasy_login/main.dart';

class Home extends StatefulWidget {
  String uid;
  String name;
  Home(this.uid, this.name);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int val = -1, val2 = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (route) => false);
            },
          )
        ],
      ),
      body: Center(
          child: Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.red,
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        child: Center(
                          child: Text(
                            'Welcome +91-${widget.uid}',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Center(
                          child: Text(
                            'Please select your profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: Color.fromRGBO(46, 59, 98, 1.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(46, 59, 98, 1.0),
                                width: 1),
                            borderRadius: BorderRadius.zero),
                        child: RadioListTile(
                          activeColor: Color.fromRGBO(46, 59, 98, 1.0),
                          value: 1,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = 1;
                              val2 = 0;
                            });
                          },
                          title: Text("Shipper"),
                          subtitle: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing"),
                          secondary: Icon(Icons.business),
                          toggleable: true,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(46, 59, 98, 1.0),
                                  width: 1),
                              borderRadius: BorderRadius.zero),
                          child: RadioListTile(
                            value: 1,
                            activeColor: Color.fromRGBO(46, 59, 98, 1.0),
                            groupValue: val2,
                            onChanged: (value) {
                              setState(() {
                                val2 = 1;
                                val = 0;
                              });
                            },
                            title: Text("Transporter"),
                            subtitle: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing"),
                            secondary: Icon(Icons.local_shipping_rounded),
                            toggleable: true,
                            controlAffinity: ListTileControlAffinity.leading,
                          )),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
                        width: double.infinity,
                        child: MaterialButton(
                          color: const Color.fromRGBO(46, 59, 98, 1.0),
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: Text(
                              'CONTINUE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
