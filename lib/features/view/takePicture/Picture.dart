import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import '../result/result.dart';

// URL de l'API à utiliser pour envoyer les images et recevoir les résultats.
const String url = "http://192.168.100.13:5000";

class PicturePage extends StatefulWidget {
  const PicturePage({super.key});

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  bool _isButtonDisabled = false;

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _isButtonDisabled = true;
        _image = File(pickedFile.path);
      });
    }
  }

  Future takePicture() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _isButtonDisabled = true;
        _image = File(pickedFile.path);
      });
    }
  }

  void _goToNextPage() {}

  void _retryImage() {
    setState(() {
      _image = null;
      _isButtonDisabled = false;
    });
  }

  Future<void> sendImage(String path) async {
    try {
      http.MultipartRequest req =
          http.MultipartRequest("POST", Uri.parse("$url/predict"));
      req.files.add(await http.MultipartFile.fromPath('image', path));

      http.StreamedResponse res = await req.send();

      String responseString = await res.stream.transform(utf8.decoder).join();
      print(responseString);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CancerDiagnosis(result: responseString)),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Take Photo"),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff123CCF),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _image == null
                    ? const Text("Take a picture of your skin ")
                    : Image.file(_image!),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isButtonDisabled ? null : getImage,
                      icon: const Icon(Icons.image),
                      label: const Text("Select from gallery"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: _isButtonDisabled ? null : takePicture,
                      icon: const Icon(Icons.camera),
                      label: const Text("Take a picture"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _image == null
                        ? null
                        : () async {
                            if (_image != null) {
                              await sendImage(_image!.path);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                        title: Text("You must take an image"));
                                  });
                            }
                          },
                    child: const Text('predict'))
              ],
            ),
            Positioned(
              bottom: 20,
              right: 290,
              child: Visibility(
                visible: _image != null,
                child: FloatingActionButton(
                  onPressed: _retryImage,
                  child: const Icon(Icons.refresh),
                ),
              ),
            ),
          ],
        ));
  }
}
