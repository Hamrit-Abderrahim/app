import 'package:body_part_selector/body_part_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wissal/core/function/function.dart';
import 'package:wissal/features/models/user_model.dart';
import 'package:wissal/features/view/home/all_result.dart';
import 'package:wissal/features/view/home/widget/log_out_dialog.dart';

import '../../../core/network/cach_helper.dart';
import '../../../core/utils/contstants.dart';
import '../takePicture/Picture.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyParts _bodyParts = const BodyParts();
  //******** getcurrentUser **************/
  String name = '';
  //****** getCurrentUser ******//
  UserModel? model;
  getMe() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      setState(() {
        model = UserModel.fromJson(value.data()!);
      });
      print("user===========${model!.email}");
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  void initState() {
    getMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    uId = CacheHelper.getData(key: 'token');
    print("homeUID======$uId");

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(context, AllResult(model: model!));
        },
        child: const Center(
            child: Text(
          'Result',
          textAlign: TextAlign.center,
        )),
      ),
      appBar: AppBar(
        title: const Text(
          'body part selector',
          style: TextStyle(color: Color(0xffffffff)),
        ),
        backgroundColor: const Color(0xff123CCF),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const LogoutDialog();
                    });
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Transform.scale(
                scale: 0.8,
                child: BodyPartSelectorTurnable(
                  bodyParts: _bodyParts,
                  onSelectionUpdated: (p) {
                    setState(() {
                      _bodyParts = p;

                      String expression = '$p';
                      Map<String, bool> bodyParts = {};
                      RegExp exp = RegExp(r'(\w+):\s*(\w+)');
                      Iterable<Match> matches = exp.allMatches(expression);
                      for (Match match in matches) {
                        String? key = match.group(1);
                        String? valueString = match.group(2);
                        bool value = valueString == 'true';

                        bodyParts[key!] = value;
                      }

                      // print(bodyParts);

                      Map<String, bool> selectedParts = Map.fromEntries(
                          bodyParts.entries
                              .where((entry) => entry.value == true));
                      name = selectedParts.keys.toString();
                      print('asdadsa=$name');

                      //!--------
                    });
                  },
                  labelData: const RotationStageLabelData(
                    front: 'front',
                    left: 'left',
                    right: 'Right',
                    back: 'back',
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 10, 100),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PicturePage(
                          typeBody: name,
                        ),
                      ),
                    );
                  },
                  child: const Text('Next Page'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
