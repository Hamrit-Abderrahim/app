import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wissal/features/controller/app_cubit/app_cubit_cubit.dart';
import 'package:wissal/features/controller/app_cubit/app_cubit_state.dart';
import 'package:wissal/features/models/user_model.dart';
import 'package:wissal/features/view/home/widget/card_comp.dart';

class AllResult extends StatefulWidget {
  final UserModel model;
  const AllResult({super.key, required this.model});

  @override
  State<AllResult> createState() => _AllResultState();
}

class _AllResultState extends State<AllResult> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubitCubit>(context).getAllResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ALL result"),
        ),
        body: BlocConsumer<AppCubitCubit, AppCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ConditionalBuilder(
              condition:
                  BlocProvider.of<AppCubitCubit>(context).result.isNotEmpty,
              builder: (context) => ListView.separated(
                itemCount:
                    BlocProvider.of<AppCubitCubit>(context).result.length,
                itemBuilder: (conext, index) => CardComponents(
                  user: widget.model,
                  result: BlocProvider.of<AppCubitCubit>(context).result,
                  index: index,
                ),
                separatorBuilder: (context, index) => const Divider(),
              ),
              fallback: (context) => const Center(
                child: Text('NO Result'),
              ),
            );
          },
        ));
  }
}
