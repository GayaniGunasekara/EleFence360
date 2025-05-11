import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _welcomeText(),
          Container(
            child: Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            width: 250,
            height: 260,
            decoration: BoxDecoration(
              color: Color(0xFF4E8BD4).withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Username'),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 180, 198, 220),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(height: 20),
                Text('Password'),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 180, 198, 220),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack _welcomeText() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset('assets/bg_picture.svg', fit: BoxFit.fill),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),

              Text(
                'to the EleGuardian!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
