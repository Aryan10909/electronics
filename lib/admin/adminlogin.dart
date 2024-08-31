// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronicsshop/admin/homeadmin.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    "images/logo.jpg",
                    width: 350,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "The Admin Panel.",
                  style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   "Enter your details.",
                //   style: TextStyle(
                //     color: Colors.red[600],
                //     fontSize: 30,
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Username:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 196, 236, 243)
                            //border: Border.all(color: Colors.yellow, width: 3)
                            ),
                    child: TextFormField(
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your name';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: usernamecontroller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter user's name!",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w400),
                          hoverColor: Colors.green),
                    )),
                SizedBox(
                  height: 25,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 196, 236, 243)
                            //border: Border.all(color: Colors.yellow, width: 3)
                            ),
                    child: TextFormField(
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return "Please enter user's password!";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: userpasswordcontroller,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Password!",
                          hintStyle: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w400),
                          hoverColor: Colors.green),
                    )),
                SizedBox(
                  height: 15,
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(193, 216, 195, 5),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        loginAdmin();
                      },
                      child: Text("LogIn",
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                  ),
                ),
                // SizedBox(height: 30),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(width: 20),
                //     Text(
                //       "Already have an account?",
                //       style: TextStyle(fontSize: 20),
                //     ),
                //     SizedBox(width: 8),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) => LogIn()));
                //       },
                //       child: Text(
                //         "LogIn here",
                //         style: TextStyle(
                //             color: Colors.green,
                //             decoration: TextDecoration.underline,
                //             decorationColor: Colors.blueAccent,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Your Id is not correct!",
                style: TextStyle(fontSize: 23, color: Colors.white),
              )));
        } else if (result.data()['password'] !=
            userpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Your password is not correct!",
                style: TextStyle(fontSize: 23, color: Colors.white),
              )));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeAdmin()));
        }
      });
    });
  }
}
