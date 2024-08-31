// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.green[50],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset('images/headspeakers.jpg',
                    height: 400, fit: BoxFit.cover),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 58),
                  child: Text(
                    "Browse our collection",
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10, right: 10),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 49, 85, 247),
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Click here..",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
