import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wissal/core/function/function.dart';
import 'package:wissal/features/controller/app_cubit/app_cubit_cubit.dart';
import 'package:wissal/features/controller/app_cubit/app_cubit_state.dart';
import 'package:wissal/features/view/home/home_view.dart';

class CancerDiagnosis extends StatelessWidget {
  final String result;
  final String typeBody;

  const CancerDiagnosis(
      {super.key, required this.result, required this.typeBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prediction Result: $result'),
            BlocConsumer<AppCubitCubit, AppCubitState>(
              listener: (context, state) {
                if (state is SaveDataSuccessState) {
                  navigateAndReplace(context, const MyHomePage());
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AppCubitCubit>(context).saveResukt(
                        result: result,
                        typeBody: typeBody,
                        image: BlocProvider.of<AppCubitCubit>(context).imge!,
                      );
                    },
                    child: const Text('save'));
              },
            )
          ],
        ),
      ),
    );
  }
}
