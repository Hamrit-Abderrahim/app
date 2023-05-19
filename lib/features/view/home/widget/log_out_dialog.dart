import 'package:flutter/material.dart';
import 'package:wissal/core/function/function.dart';
import 'package:wissal/core/network/cach_helper.dart';
import 'package:wissal/features/view/get_started/get_started.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFF8F8F8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: const Text(
        "تسجيل الخروج",
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF126E82)),
      ),
      content: const Text(
        '''هل أنت متأكد أنك تريد
               الخروج من التطبيق؟''',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF126E82)),
      ),
      actionsPadding: EdgeInsets.zero,
      actions: <Widget>[
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black38, width: 1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    border: Border(
                        left: BorderSide(color: Colors.black38, width: 2)),
                  ),
                  child: TextButton(
                    child: const Text(
                      'نعم',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      CacheHelper.removeData(key: 'token').then((value) {
                        navigateAndReplace(context, const GetStarted());
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: TextButton(
                    child: const Text(
                      'إالغاء',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
