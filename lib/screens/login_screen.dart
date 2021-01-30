import 'package:asaani_driver/components/CommonButton.dart';
import 'package:asaani_driver/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool validNumber = true;
  FirebaseAuth _firebaseAuth;
  TextEditingController numberController = TextEditingController();
  DatabaseReference driver = FirebaseDatabase.instance.reference();

  void registerUser(BuildContext context) async {
    String number = numberController.text;
    print(number);
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
      email: "Musharaf$number@gmail.com",
      password: "1233456",
    )
            .catchError((errMsg) {
      print(errMsg.toString());
    }))
        .user;
  }

  double test = 19;
  void availableDriver() async {
    // test += 0.01;
    // driver.child("availableDriver").child("1234").update({
    //   'lat': "$test",
    //   'lng': "$test",
    // });
    // Geofire.initialize("availableDriver");
    // Geofire.setLocation("12345", test, test);
    // print("called");
    Map<String, dynamic> response = await Geofire.getLocation("12345");
    print(response);
  }

  void availableDriverDetails() {
    driver
        .child("availableDriver")
        .once()
        .then((DataSnapshot snapshot) => {print(snapshot.value)});
    // df =driver.child("").onChildChanged;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("Firebase completed");
      _firebaseAuth = FirebaseAuth.instance;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: validNumber
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Image(
                          height: 300,
                          image: new AssetImage(
                            'img/car.png',
                          ),
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Login as Driver"),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: numberController,
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                            // FilteringTextInputFormatter.digitsOnly
                          ),
                        ],
                        // controller: searchOrderController,
                        decoration: InputDecoration(
                          // icon: Icon(Icons.dialer_sip),
                          filled: true,
                          hintText: "Enter Number",
                          fillColor: secondaryColor,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      CommonButtom(
                        title: "Continue",
                        color: secondaryColor,
                        onpress: () {
                          setState(() {
                            // registerUser(context);
                            // availableDriver();
                            validNumber = false;
                          });
                        },
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        // height: 200,
                        // width: 200,
                        child: Image(
                          height: 300,
                          image: new AssetImage(
                            'img/car.png',
                          ),
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 35,
                        // color: secondaryColor,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(30),
                          // border: Border.all(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "03113699616",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        validNumber = true;
                                      });
                                    },
                                    child: Icon(Icons.edit))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                            // FilteringTextInputFormatter.digitsOnly
                          ),
                        ],
                        // controller: searchOrderController,
                        decoration: InputDecoration(
                          // icon: Icon(Icons.dialer_sip),
                          filled: true,
                          hintText: "Enter Four digit code",
                          fillColor: secondaryColor,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      CommonButtom(
                        title: "Continue",
                        color: secondaryColor,
                        onpress: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Didn't recieve code?"),
                          Text(
                            "Resend",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
