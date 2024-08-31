// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronicsshop/pages/productdetail.dart';
import 'package:electronicsshop/pages/services.dart';
import 'package:flutter/material.dart';

class Categoryproducts extends StatefulWidget {
  //const Categoryproducts({super.key});
  String category;
  Categoryproducts({required this.category});

  @override
  State<Categoryproducts> createState() => _CategoryproductsState();
}

class _CategoryproductsState extends State<Categoryproducts> {
  Stream? categorystream;
  getontheload() async {
    categorystream = await DatabaseMethods().getProducts(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allProducts() {
    return StreamBuilder(
        stream: categorystream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Image.network(
                            ds["Image"],
                            height: 180,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ds["Name"],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.blueGrey),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rs." + ds["Price"],
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 18),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                              image: ds["Image"],
                                              name: ds["Name"],
                                              detail: ds["Details"],
                                              price: ds["Price"])));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 75, 9, 228)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 240, 240),
      appBar: AppBar(
        title: Text(
          "Product collection",
          style: TextStyle(
              fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 221, 164),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 8, left: 8, top: 15),
        child: Column(
          children: [Expanded(child: allProducts())],
        ),
      ),
    );
  }
}
