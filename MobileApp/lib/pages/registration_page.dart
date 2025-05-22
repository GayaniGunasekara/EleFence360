import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

String? validateNIC(String? value) {
  if (value == null || value.isEmpty) return 'NIC is required';
  final pattern = r'^(?:\d{12}|[0-9]{9}[vVxX])$';
  final regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) return 'Enter a valid NIC';
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

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child(
    'users',
  );
  final _formKey = GlobalKey<FormState>();

  Future<void> saveUserData(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        bool exists = await userExists(
          nicController.text.trim(),
          phoneController.text.trim(),
        );

        if (exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('NIC or Phone already registered')),
          );
          return;
        }

        final userRef = FirebaseDatabase.instance.ref('users').push();
        await userRef.set({
          'name': nameController.text.trim(),
          'nic': nicController.text.trim(),
          'phone': phoneController.text.trim(),
          'address': addressController.text.trim(),
          'timestamp': ServerValue.timestamp,
        });

        nameController.clear();
        nicController.clear();
        phoneController.clear();
        addressController.clear();

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registration Successful!')));
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<bool> userExists(String nic, String phone) async {
    final snapshot = await FirebaseDatabase.instance.ref('users').get();
    if (!snapshot.exists) return false;

    final users = snapshot.value as Map<dynamic, dynamic>;

    for (final userEntry in users.entries) {
      final userData = Map<String, dynamic>.from(userEntry.value);

      final existingNIC = userData['nic']?.toString().trim();
      final existingPhone = userData['phone']?.toString().trim();

      if (existingNIC == nic || existingPhone == phone) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth =
        screenWidth * 0.8 > 400 ? 400 : screenWidth * 0.8;
    final double fieldWidth = containerWidth * 0.8;
    final double labelPadding = fieldWidth - 30;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height:
                        constraints.maxHeight * 0.20 > 170
                            ? 170
                            : constraints.maxHeight * 0.20,
                  ),
                  Text(
                    'Create Your Account!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: containerWidth,
                    height:
                        constraints.maxHeight * 0.55 > 500
                            ? 500
                            : constraints.maxHeight * 0.55,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF4E8BD4).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: labelPadding),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: fieldWidth,
                            height: 40,
                            margin: EdgeInsets.only(bottom: 20, top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: labelPadding - 42),
                            child: Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: fieldWidth,
                            height: 40,
                            margin: EdgeInsets.only(bottom: 20, top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: phoneController,
                              validator: validateMobile,
                              decoration: InputDecoration(
                                hintText: 'Enter your phone number',
                                hintStyle: TextStyle(fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: labelPadding + 10),
                            child: Text(
                              'NIC',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: fieldWidth,
                            height: 40,
                            margin: EdgeInsets.only(bottom: 20, top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: nicController,
                              validator: validateNIC,
                              decoration: InputDecoration(
                                hintText: 'Enter National Id number',
                                hintStyle: TextStyle(fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: labelPadding - 10),
                            child: Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: fieldWidth,
                            height: 40,
                            margin: EdgeInsets.only(bottom: 15, top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                hintText: 'Enter your address',
                                hintStyle: TextStyle(fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height:
                                constraints.maxHeight * 0.02 > 20
                                    ? 20
                                    : constraints.maxHeight * 0.02,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                bool exists = await userExists(
                                  nicController.text.trim(),
                                  phoneController.text.trim(),
                                );
                                if (exists) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('User already exists!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  await saveUserData(context);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(fieldWidth * 0.75, 30),
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
