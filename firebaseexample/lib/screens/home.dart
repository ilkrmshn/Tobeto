import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseexample/models/message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

final firebaseAuthInstance = FirebaseAuth.instance;
final firebaseStorageInstance = FirebaseStorage.instance;
final firebaseFireStore = FirebaseFirestore.instance;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _pickedFile;
  String _imageUrl = '';
  DateTime? date;
  final messageController = TextEditingController();
  final DateFormat formatter = DateFormat('hh:mm dd/MM/yyyy');
  @override
  void initState() {
    _getUserImage();
    super.initState();
  }

  void _getUserImage() async {
    final user = firebaseAuthInstance.currentUser;
    final document = firebaseFireStore.collection("users").doc(user!.uid);
    final documentSnapshot =
        await document.get(); // document.get => dökümanın okunmasını sağlar.
    // documentSnapshot => dökümanın tamamı
    print("documentSnapshot");
    setState(() {
      _imageUrl = documentSnapshot.get(
          "imageUrl"); // documentSnapshot.get => dökümanın içindeki field'ı okur
    });
  }

  Future<List<Message>> _getMessages() async {
    final document = await firebaseFireStore.collection("messages").get();

    final messagesList =
        document.docs.map((e) => Message.fromJson(e.data())).toList();

    // mesajları tarihe göre sıralıyor
    messagesList.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    return messagesList;
  }

  Future<String> _getUserEmail(String userId) async {
    final document = firebaseFireStore.collection("users").doc(userId);
    final docSnapshot = await document.get();

    print(docSnapshot.get('email'));

    return docSnapshot.get('email');
  }

  void _submitMessage() async {
    final user = firebaseAuthInstance.currentUser;
    date = DateTime.now();

    try {
      firebaseFireStore.collection("messages").doc().set({
        'message': messageController.text,
        'date': date,
        'userId': user!.uid
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }

    messageController.clear();
  }

  void _pickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (image != null) {
      setState(() {
        _pickedFile = File(image.path);
      });
    }
  }

  void _upload() async {
    final user = firebaseAuthInstance.currentUser;
    final storageRef =
        firebaseStorageInstance.ref().child("images").child("${user!.uid}.jpg");

    await storageRef.putFile(_pickedFile!);

    final url = await storageRef.getDownloadURL();

    final document = firebaseFireStore.collection("users").doc(user!.uid);

    await document.update({
      'imageUrl': url
    }); // document.update => verilen değeri ilgili dökümanda günceller!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Application"),
        actions: [
          IconButton(
              onPressed: () {
                firebaseAuthInstance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    foregroundImage:
                        // ignore: unnecessary_null_comparison
                        _imageUrl == null ? null : NetworkImage(_imageUrl),
                  ),
                  TextButton(
                      onPressed: () {
                        _pickImage();
                      },
                      child: const Text("Resim Seç")),
                  _pickedFile != null
                      ? ElevatedButton(
                          onPressed: () {
                            _upload();
                          },
                          child: const Text("Resim Yükle"))
                      : Container(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0)),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FutureBuilder(
                    future: _getMessages(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data![index].userId ==
                                firebaseAuthInstance.currentUser!.uid) {
                              return Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  margin: const EdgeInsets.all(4.0),
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      color: Colors.cyanAccent,
                                      border: Border.all(
                                          width: 1, color: Colors.cyan),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8.0),
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0))),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].message,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              style:
                                                  const TextStyle(fontSize: 10),
                                              formatter
                                                  .format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          snapshot
                                                              .data![index]
                                                              .date
                                                              .millisecondsSinceEpoch))
                                                  .toString()),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  margin: const EdgeInsets.all(4.0),
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      border: Border.all(
                                          width: 1, color: Colors.green),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8.0),
                                          topLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          FutureBuilder(
                                            future: _getUserEmail(
                                                snapshot.data![index].userId),
                                            builder: (context, value) {
                                              if (value.hasData) {
                                                return Text(
                                                  value.data!,
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                );
                                              } else if (value.hasError) {
                                                return const Text(
                                                  "Hata oluştu.",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                );
                                              }
                                              return const Text(
                                                "Yükleniyor",
                                                style: TextStyle(fontSize: 10),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            snapshot.data![index].message,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              style:
                                                  const TextStyle(fontSize: 10),
                                              formatter
                                                  .format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          snapshot
                                                              .data![index]
                                                              .date
                                                              .millisecondsSinceEpoch))
                                                  .toString()),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Text("Hata oluştu.");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                            hintText: 'Mesaj gönder.',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)))),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    const Icon(Icons.send),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
