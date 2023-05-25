import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/contstants.dart';
import '../../../../models/user_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  //****** getCurrentUser ******//
  UserModel? model;
  getMe() async {
    emit(GetCurrentUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data()!);
      print("user===========${model!.skinColor.toString()}");

      emit(GetCurrentUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCurrentUserErrorState());
    });
  }
}
