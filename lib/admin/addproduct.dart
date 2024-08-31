// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:electronicsshop/pages/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController detailscontroller = new TextEditingController();
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null && namecontroller != "") {
      String addId = randomAlphaNumeric(10);
      Reference firebasestorageref =
          FirebaseStorage.instance.ref().child("MyImage").child(addId);
      final UploadTask task = firebasestorageref.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addProduct = {
        "Name": namecontroller.text,
        "Image": downloadUrl,
        "Price": pricecontroller.text,
        "Details": detailscontroller.text,
      };
      await DatabaseMethods().addProduct(addProduct, value!).then((value) {
        selectedImage = null;
        namecontroller.text = "";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Product added successfully!",
              style: TextStyle(fontSize: 23, color: Colors.white),
            )));
      });
    }
  }

  String? value;
  final List<String> categoryitem = [
    "Watch",
    "Headspeakers",
    "Mouse",
    "Earbuds",
    "Mobile",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 17, 7, 155), shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back_outlined,
              size: 35,
              color: Color.fromARGB(192, 206, 187, 14),
            ),
          ),
        ),
        backgroundColor: Colors.cyanAccent,
        title: Center(
            child: Text(
          "ADD PRODUCT",
          style: TextStyle(
              fontSize: 40, color: Colors.red, fontWeight: FontWeight.bold),
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 254, 255, 240),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload the product image!",
                    style: TextStyle(fontSize: 30, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                          child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.camera_enhance_rounded,
                          size: 100,
                          color: Colors.blueGrey,
                        ),
                      )),
                    )
                  : Center(
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Text(
                      "Product name",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 47, 14, 124)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(192, 221, 213, 213),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Product category",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 47, 14, 124)),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 203, 233, 245),
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      items: categoryitem
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 23,
                                    color:
                                        const Color.fromARGB(255, 1, 42, 63)),
                              )))
                          .toList(),
                      onChanged: ((value) => setState(() {
                            this.value = value;
                          })),
                      dropdownColor: Colors.white,
                      hint: Text("Select category"),
                      iconSize: 35,
                      value: value,
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Text(
                      "Product price",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 47, 14, 124)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(192, 221, 213, 213),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "In rupees",
                    hintStyle: TextStyle(fontSize: 20, color: Colors.black45),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Text(
                      "Product details",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 47, 14, 124)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(192, 221, 213, 213),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  maxLines: 7,
                  controller: detailscontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        uploadItem();
                      },
                      child: Text(
                        "Add Product",
                        style: TextStyle(fontSize: 25, color: Colors.black54),
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
