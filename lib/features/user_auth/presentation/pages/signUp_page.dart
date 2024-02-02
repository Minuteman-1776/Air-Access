import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siakmhs_1001210005_2/common/toast.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/login_page.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/widgets/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool isSigningUp = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  //Save ke Autentikasi
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  //Save ke Firestore
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    //Save ke Autentikasi
    _emailController.dispose();
    _passwordController.dispose();
    //Save ke Firestore
    _nameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Sign-Up"),
        // ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign-Up",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: _nameController,
                  hintText: "Name",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                FormContainerWidget(
                  controller: _phoneNumberController,
                  hintText: "Phone Number",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(height: 10),
                FormContainerWidget(
                  controller: _addressController,
                  hintText: "Address",
                  isPasswordField: false,
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: (){
                    _signUp();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: isSigningUp ? CircularProgressIndicator(color: Colors.white):
                      Text(
                        "Sign-Up",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
  void _signUp() async {

    setState(() {
      isSigningUp = true;
    });

    // Validasi jika ada form yang kosong
    if (_nameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _addressController.text.isEmpty) {
      showToast(message: "All fields must be filled");
      setState(() {
        isSigningUp = false;
      });
      return;
    }

    //Save ke Autentikasi
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    //Save ke Firestore
    String phoneNumber = _phoneNumberController.text;
    String name = _nameController.text;
    String address = _addressController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });

    if (user != null){
      await _saveUserDataToFirestore(user.uid, email, name, phoneNumber, address);

      showToast(message: "User is successfully created", center: true);
      Navigator.pushNamed(context, "/landing_page");
    }else{
      // showToast(message: "An error occurred");
    }
  }

  //Save UID ke Firestore
  Future<void> _saveUserDataToFirestore(
      String uid, String email, String name, String phoneNumber, String address) async {
    try {
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("user_data");

      await usersCollection.doc(uid).set({
        'name': name,
        'phone_number': phoneNumber,
        'email': email,
        'address': address,
      });
    } catch (e) {
      print("Error saving user data to Firestore: $e");
    }
  }
}
