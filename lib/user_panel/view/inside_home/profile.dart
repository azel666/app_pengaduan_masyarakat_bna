import 'dart:io';

import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String? uName = "";
  String? uEmail = "";
  String? uPhone = "";
  String? uImage = "";
  String imgUrl = "";

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          uName = snapshot.data()!['username'];
          uEmail = snapshot.data()!['email'];
          uPhone = snapshot.data()!['nomor telepon'];
          uImage = snapshot.data()!['image'];
        });
      }
    });
  }

  Future<void> uploadImg() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance.ref().child("profiles");
    Reference imgUpload = ref.child(fileName);

    try {
      await imgUpload.putFile(File(img!.path));

      imgUrl = await imgUpload.getDownloadURL();
    } catch (error) {}

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"image": imgUrl});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: "#1ABC9C".toColor(),
      ),
      body: Container(
        color: "#117864".toColor(),
        child: Center(
          child: content(),
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Column(children: [
              Container(
                child: CircleAvatar(
                  radius: 85.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: uImage == null
                      ? Image.asset("assets/images/test.jpg").image
                      : Image.network(uImage!).image,
                ),
              ),
              Container(
                  child: ElevatedButton(
                      onPressed: uploadImg, child: Icon(Icons.photo_camera)))
            ]),
          ),
          PhysicalModel(
            color: Colors.white,
            elevation: 3,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: "#40E0D0".toColor(),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        uName!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: "#40E0D0".toColor(),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        uEmail!,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: "#40E0D0".toColor(),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        uPhone!,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
