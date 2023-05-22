import 'package:flutter/material.dart';
import 'package:wissal/features/models/result.dart';
import 'package:wissal/features/view/home/widget/result_details.dart';

import '../../../../core/function/function.dart';
import '../../../models/user_model.dart';

class CardComponents extends StatelessWidget {
  final UserModel user;
  final List<ResultModel> result;
  final int index;

  const CardComponents(
      {Key? key, required this.user, required this.result, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            ResultDetails(
              result: result[index],
              user: user,
            ));
      },
      child: Card(
        elevation: 5.0,
        shadowColor: Colors.lightBlue,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage('${result[index].image}'),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${result[index].result}',
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
