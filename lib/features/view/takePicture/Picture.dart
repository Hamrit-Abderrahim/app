import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:wissal/features/controller/app_cubit/app_cubit_cubit.dart';
import 'package:wissal/features/controller/app_cubit/app_cubit_state.dart';
import 'dart:convert' show utf8;
import '../result/result.dart';

// URL de l'API à utiliser pour envoyer les images et recevoir les résultats.
const String url = "http://192.168.100.13:5000";

class PicturePage extends StatefulWidget {
  final String typeBody;
  const PicturePage({super.key, required this.typeBody});

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

  var details = {'Usrname': 'tom', 'Password': 'pass@123'};

  // ignore: prefer_typing_uninitialized_variables
  var responseString;
  Future<void> sendImage(String path) async {
    try {
      http.MultipartRequest req =
          http.MultipartRequest("POST", Uri.parse("$url/predict"));
      req.files.add(await http.MultipartFile.fromPath('image', path));

      http.StreamedResponse res = await req.send();
      setState(() async {
        var response = await res.stream.transform(utf8.decoder).join();
        responseString = response;
      });

      // ignore: use_build_context_synchronously
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => CancerDiagnosis(result: responseString)),
      // );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("asdadada= ${widget.typeBody}");
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
                BlocConsumer<AppCubitCubit, AppCubitState>(
                  listener: (context, state) {
                    if (state is SaveImageSuccessState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CancerDiagnosis(
                                  result: responseString,
                                  typeBody: widget.typeBody,
                                )),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ConditionalBuilder(
                      condition: state is! SaveImageLaodingState,
                      builder: (context) => ElevatedButton(
                          onPressed: _image == null
                              ? null
                              : () async {
                                  if (_image != null) {
                                    BlocProvider.of<AppCubitCubit>(context)
                                        .saveIamge(_image);
                                    await sendImage(_image!.path);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                              title: Text(
                                                  "You must take an image"));
                                        });
                                  }
                                },
                          child: const Text('predict')),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )
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
