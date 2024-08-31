// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  String image, name, detail, price;
  ProductDetail(
      {required this.image,
      required this.name,
      required this.detail,
      required this.price});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(color: Colors.green)),
                  child: Icon(
                    Icons.arrow_back_outlined,
                    size: 45,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 300,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            "Rs." + widget.price,
                            style: TextStyle(fontSize: 30, color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Details",
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.detail,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 140,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.amberAccent),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Buy now",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 2, 116, 6),
                                fontSize: 30),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
