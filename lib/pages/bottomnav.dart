// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:electronicsshop/pages/home.dart';
import 'package:electronicsshop/pages/order.dart';
import 'package:electronicsshop/pages/profile.dart';
import 'package:flutter/material.dart';

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  late List<Widget> pages;
  late Home Homepage;
  late Order Orderpage;
  late Profile Profilepage;
  int currentTabIndex = 0;

  @override
  void initState() {
    Homepage = Home();
    Orderpage = Order();
    Profilepage = Profile();
    pages = [Homepage, Orderpage, Profilepage];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 70,
          backgroundColor: Colors.green,
          color: Colors.blue,
          animationCurve: Curves.easeInOutExpo,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_basket_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_2_outlined,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}
