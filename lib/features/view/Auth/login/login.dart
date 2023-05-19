import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wissal/core/function/function.dart';
import 'package:wissal/core/network/cach_helper.dart';
import 'package:wissal/features/view/home/home_view.dart';

import '../../../models/user_model.dart';
import '../register/register_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCotroller = TextEditingController();

  final passeordCotroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  //?------------ login ------------------
  UserModel? user;

  logIngUser({
    required String email,
    required String password,
    deviceToken,
  }) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        CacheHelper.saveData(key: 'token', value: value.user!.uid);
        setState(() {
          isLoading = false;
        });
        print(value);
        navigateAndReplace(context, const MyHomePage());
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/img_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),

                // champ de texte pour l'adresse email
                TextFormField(
                  controller: emailCotroller,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your Email';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),

                // champ de texte pour le mot de passe
                TextFormField(
                  controller: passeordCotroller,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                // bouton de connexion
                isLoading == false
                    ? ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('ok');

                            logIngUser(
                                email: emailCotroller.text,
                                password: passeordCotroller.text);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff123CCF)),
                        ),
                        child: const Text('Login'))
                    : const CircularProgressIndicator(),
                const SizedBox(height: 20.0),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(
                      color: Color(0xff123CCF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
