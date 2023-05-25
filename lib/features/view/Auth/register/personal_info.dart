import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wissal/core/network/cach_helper.dart';
import 'package:wissal/features/view/home/home_view.dart';

import '../../../../core/utils/contstants.dart';
import '../../../models/user_model.dart';

// ignore: must_be_immutable
class PersonalInfoView extends StatefulWidget {
  PersonalInfoView({super.key, required this.email, required this.password});
  late String email;
  late String password;
  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  String sex = "";

  String skinType = "";
  Color skinColor = const Color(0x0fffffff);
  List<Color> skinColors = [
    const Color(0xFFEDD3B3),
    const Color(0xFFE7BB98),
    const Color(0xFFB89166),
    const Color(0xFF8E522F),
    const Color(0xFF523F38),
  ];
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Personal Information"),
          backgroundColor: const Color(0xff123CCF),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your name",
                      labelText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      hintText: "Enter your age",
                      labelText: "Age",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your age";
                      }
                      int age = int.tryParse(value)!;
                      if (age < 1 || age > 120) {
                        return "Please enter a valid age";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text("Gender", style: TextStyle(fontSize: 16.0)),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sex = "male";
                          });
                        },
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor:
                              sex == "male" ? Colors.blue : Colors.grey[200],
                          child: Icon(Icons.male,
                              size: 40.0,
                              color:
                                  sex == "male" ? Colors.white : Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sex = "female";
                          });
                        },
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor:
                              sex == "female" ? Colors.pink : Colors.grey[200],
                          child: Icon(Icons.female,
                              size: 40.0,
                              color:
                                  sex == "female" ? Colors.white : Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Skin type", style: TextStyle(fontSize: 16.0)),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: const Text("Oily"),
                              value: "oily",
                              groupValue: skinType,
                              onChanged: (value) {
                                setState(() {
                                  skinType = value.toString();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text("Combined"),
                              value: "combined",
                              groupValue: skinType,
                              onChanged: (value) {
                                setState(() {
                                  skinType = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: const Text("Dry"),
                              value: "dry",
                              groupValue: skinType,
                              onChanged: (value) {
                                setState(() {
                                  skinType = value.toString();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text("Normal"),
                              value: "normal",
                              groupValue: skinType,
                              onChanged: (value) {
                                setState(() {
                                  skinType = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: const Text("Skin color",
                        style: TextStyle(fontSize: 16.0)),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: skinColors.map((color) {
                      return Container(
                        margin: const EdgeInsets.only(right: 17),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              skinColor = color;
                              print("aaaaa=$skinColor");
                            });
                          },
                          child: CircleAvatar(
                            radius: 23.0,
                            backgroundColor: color,
                            child: skinColor == color
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          registerUser(
                              email: widget.email,
                              name: nameController.text,
                              password: widget.password,
                              age: int.parse(ageController.text),
                              gender: sex,
                              skinType: skinType,
                              skinColor: skinColor.value);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff123CCF)),
                      ),
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void registerUser(
      {required String email,
      required String name,
      required String password,
      required int age,
      required String gender,
      required String skinType,
      required int skinColor}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      addFirebase(
          email: email,
          name: name,
          password: password,
          uId: value.user!.uid,
          age: age,
          gender: gender,
          skinType: skinType,
          skinColor: skinColor);
      CacheHelper.saveData(key: 'token', value: value.user!.uid).then((value) {
        uId = CacheHelper.getData(key: 'token');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  //*********addUserinDb ************//
  void addFirebase(
      {required String email,
      required String name,
      required String uId,
      required String password,
      required int age,
      required String gender,
      required String skinType,
      required int skinColor}) {
    UserModel model = UserModel(
        email: email,
        password: password,
        name: name,
        gender: gender,
        skinType: skinType,
        skinColor: skinColor,
        uId: uId,
        age: age);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      print(model);
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
