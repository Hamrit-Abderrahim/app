import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wissal/core/utils/contstants.dart';
import 'package:wissal/features/view/home/home_view.dart';
import 'core/network/cach_helper.dart';
import 'features/view/get_started/get_started.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'token');
  print('token main =$uId');

  late Widget widget;
  if (uId != null) {
    widget = const MyHomePage();
  } else {
    widget = const GetStarted();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: widget,
    );
  }
}
