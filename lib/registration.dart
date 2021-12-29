import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'otp.dart';

class Registartion extends StatefulWidget {
  @override
  _RegistartionState createState() => _RegistartionState();
}

class _RegistartionState extends State<Registartion> {
  TextEditingController _controller = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            "assets/two.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomLeft,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(children: [
                  Container(
                    child: Center(
                      child: Text(
                        'Please enter your mobile number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'You’ll receive a 4 digit code to verify next.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _controller,
                      formatInput: false,
                      inputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
                    width: double.infinity,
                    child: MaterialButton(
                      color: const Color.fromRGBO(46, 59, 98, 1.0),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OTPScreen(_controller.text)));
                      },
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
                ]),
              )
            ],
          ),
        )
      ],
    ));
  }
}
