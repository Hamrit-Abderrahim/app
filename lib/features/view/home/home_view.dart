import 'package:body_part_selector/body_part_selector.dart';
import 'package:flutter/material.dart';
import 'package:wissal/features/view/home/widget/log_out_dialog.dart';

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

  void getCurrentUser() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: const Icon(Icons.logout))
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
                  onSelectionUpdated: (p) => setState(() => _bodyParts = p),
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
                        builder: (context) => const PicturePage(),
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
