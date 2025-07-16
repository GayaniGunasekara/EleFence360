import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'registration_page.dart';

String? validateNIC(String? value) {
  if (value == null || value.isEmpty) return 'NIC is required';
  final pattern = r'^(?:\d{12}|[0-9]{9}[vVxX])$';
  final regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Enter a valid NIC';
  }
  return null;
}

String? validateMobile(String? value) {
  if (value == null || value.isEmpty) return 'Mobile number is required';
  if (value.length != 10) return 'Mobile number must be 10 digits';
  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
    return 'Enter a valid mobile number';
  }
  return null;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nicController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

    if (!mounted) return;
    if (found) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login Successful!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid NIC or Mobile Number!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _welcomeText(width, height),
            SizedBox(height: height * 0.03),
            _loginBox(context, width, height),
          ],
        ),
      ),
    );
  }

  Container _loginBox(BuildContext context, double width, double height) {
    // Responsive width and height
    final boxWidth = width < 350 ? width * 0.9 : 300.0;
    final boxHeight = height < 600 ? height * 0.45 : 340.0;
    final fieldWidth = boxWidth * 0.8;
    final fieldHeight = boxHeight * 0.13;


    return Container(
      width: boxWidth,
      height: boxHeight,
      decoration: BoxDecoration(
        color: Color(0xFF4E8BD4).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: width * 0.075,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
                height: width < 350 ? 0.8 : 0.7,
              ),
            ),
            SizedBox(height: boxHeight * 0.07),
            Padding(
              padding: EdgeInsets.only(right: fieldWidth * 0.9),
              child: Text(
                'NIC',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            Container(
              width: fieldWidth,
              height: fieldHeight,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: nicController,
                validator: validateNIC,
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
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.only(right: fieldWidth * 0.6),
              child: Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            Container(
              width: fieldWidth,
              height: fieldHeight,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: phoneController,
                validator: validateMobile,
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
                if (_formKey.currentState!.validate()) {
                  await loginUser();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(fieldWidth * 0.6, 30),
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
                    fontSize: width * 0.031,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: ' Register!',
                    style: TextStyle(
                      fontSize: width * 0.031,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF000000),
                      decoration: TextDecoration.underline,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                            );
                            if (result == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Registration successful! Please login.',
                                  ),
                                ),
                              );
                            }
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _welcomeText(double width, double height) {
    final bgHeight = height * 0.42;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: bgHeight,
          child: Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset('assets/bg_picture.svg', fit: BoxFit.fill),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: bgHeight * 0.35,
            left: width * 0.05,
            right: width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: width * 0.11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              Text(
                'to the EleGuardian!',
                style: TextStyle(
                  fontSize: width * 0.08,
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
