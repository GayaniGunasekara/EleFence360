import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nicController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> loginUser() async {
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child(
      'users',
    );
    DataSnapshot snapshot = await dbRef.get();
    bool found = false;

    if (snapshot.exists) {
      Map<dynamic, dynamic> users = snapshot.value as Map<dynamic, dynamic>;
      users.forEach((key, value) {
        if (value['nic'] == nicController.text.trim() &&
            value['phone'] == phoneController.text.trim()) {
          found = true;
        }
      });
    }

    if (found) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login Successful!')));
      // TODO: Navigate to your main/home page
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid NIC or Mobile Number!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_welcomeText(), _loginBox(context)],
        ),
      ),
    );
  }

  Container _loginBox(BuildContext context) {
    return Container(
      width: 250,
      height: 260,
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Color(0xFF4E8BD4).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
              height: 1.0,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 183),
            child: Text(
              'NIC',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(05),
            ),
            child: TextField(
              controller: nicController,
              decoration: InputDecoration(
                hintText: 'Enter NIC number',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 129),
            child: Text(
              'Mobile Number',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(05),
            ),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Enter mobile number',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await loginUser();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(120, 30),
              padding: EdgeInsets.zero,
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text('Login', style: TextStyle(color: Colors.white)),
          ),

          SizedBox(height: 1),
          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: ' Register!',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF000000), // Optional: to highlight
                    decoration: TextDecoration.underline,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationPage(),
                            ),
                          );
                        },
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
