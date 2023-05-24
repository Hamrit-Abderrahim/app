import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wissal/features/view/home/controller/result_cubit/result_state.dart';

import '../../../../../core/utils/contstants.dart';
import '../../../../models/result.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());

  //!------ getAllResult ---------
  List<ResultModel> result = [];
  Future<void> getAllResult() async {
    emit(GetAllResultLaodingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection('result')
        .snapshots()
        .listen((event) {
      result = [];
      for (var element in event.docs) {
        result.add(ResultModel.fromJson(element.data()));
        print("sdffffffff=${result[0]}");

        emit(GetAllResultSuccessState());
      }
    });
  }
}
