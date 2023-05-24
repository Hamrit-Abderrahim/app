import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wissal/features/models/user_model.dart';
import 'package:wissal/features/view/home/controller/result_cubit/result_cubit.dart';
import 'package:wissal/features/view/home/controller/result_cubit/result_state.dart';
import 'package:wissal/features/view/home/widget/card_comp.dart';

class AllResult extends StatelessWidget {
  final UserModel model;
  const AllResult({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultCubit()..getAllResult(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("ALL result"),
          ),
          body: BlocConsumer<ResultCubit, ResultState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition:
                    BlocProvider.of<ResultCubit>(context).result.isNotEmpty,
                builder: (context) => ListView.separated(
                  itemCount:
                      BlocProvider.of<ResultCubit>(context).result.length,
                  itemBuilder: (conext, index) => CardComponents(
                    user: model,
                    result: BlocProvider.of<ResultCubit>(context).result,
                    index: index,
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
                fallback: (context) => const Center(
                  child: Text('NO Result'),
                ),
              );
            },
          )),
    );
  }
}
