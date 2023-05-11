import 'package:flutter/material.dart';

import '../Auth/login/login.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/img.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 270.0,
            left: 0.0,
            right: 180.0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // set background color
                  minimumSize: const Size(120, 50), // set button size
                ),
                child: const Text(
                  'Get started',
                  style: TextStyle(
                    color: Color(0xff123CCF),
                  ),
                  // set text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
