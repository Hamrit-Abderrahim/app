import 'package:flutter/material.dart';
import 'package:wissal/features/models/result.dart';
import 'package:wissal/features/models/user_model.dart';

class ResultDetails extends StatelessWidget {
  final UserModel user;
  final ResultModel result;

  const ResultDetails({super.key, required this.user, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${result.result}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            //!------ name ----------
            Row(
              children: [
                const Text(
                  'name:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${user.name}',
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            //!------ age ----------

            Row(
              children: [
                const Text(
                  'age:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${user.age}',
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            //!------ gender ----------

            Row(
              children: [
                const Text(
                  'gender:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${user.gender}',
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            //!--------- skinColor  ----------------
            Row(
              children: [
                const Text(
                  'skinColor :',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                CircleAvatar(
                  radius: 16.0,
                  backgroundColor: Color(user.skinColor!),
                ),
                // Text(
                //   '${user.skinColor} ', // White

                //   //"$Color('${user.skinColor}')",
                //   style: const TextStyle(
                //       fontSize: 20.0,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.red),
                // ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            //!------- skinType ------------- */
            Row(
              children: [
                const Text(
                  'skinType:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${user.skinType}',
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            //!------ result -------
            Row(
              children: [
                const Text(
                  'result:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${result.result}',
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            //********** image ************/
            AspectRatio(
              aspectRatio: 4 / 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.fill, //الصورة تاحذ طول وعرض container
                    image: NetworkImage('${result.image}'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
