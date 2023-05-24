import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:wissal/core/utils/contstants.dart';
import 'package:wissal/features/models/result.dart';

import 'app_cubit_state.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitInitial());

  String? imge;
  Future<void> saveIamge(File? image) async {
    emit(SaveImageLaodingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imge = value;
        if (kDebugMode) {
          print(imge);
        }

        emit(SaveImageSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(SaveImageErrorState());
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SaveImageErrorState());
    });
  }

//******** saveresult */
  Future<void> saveResukt({
    required String result,
    required String typeBody,
    required String image,
  }) async {
    ResultModel model =
        ResultModel(image: image, result: result, typeBody: typeBody);
    emit(SaveDataLaodingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection('result')
        .doc()
        .set(model.toJson())
        .then((value) {
      emit(SaveDataSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SaveDataErrorState());
    });
  }
}
