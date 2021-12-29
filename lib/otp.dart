import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifeasy_login/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "assets/three.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        'Verify Phone',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Center(
                      child: Text(
                        'Code is sent to +91-${widget.phone}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(54, 24, 54, 0),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 40,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          inactiveColor: Color.fromRGBO(14, 102, 174, 1.0)),
                      animationDuration: Duration(milliseconds: 300),
                      onCompleted: (v) async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode,
                                      smsCode: v))
                              .then((value) async {
                            if (value.user != null) {
                              navigateAway(value.user!.uid);
                            }
                          });
                        } catch (e) {
                          FocusScope.of(context).unfocus();
                          _scaffoldkey.currentState!.showSnackBar(
                              SnackBar(content: Text('Invalid OTP')));
                        }
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    width: double.infinity,
                    child: MaterialButton(
                      color: const Color.fromRGBO(46, 59, 98, 1.0),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: Text(
                          'VERIFY OTP',
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
        ));
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              navigateAway(value.user!.uid);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  navigateAway(uid) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home(widget.phone, uid)),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
