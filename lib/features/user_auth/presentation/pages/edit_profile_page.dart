import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../common/toast.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  DynamicProfilePageState createState() => DynamicProfilePageState();
}

class DynamicProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ambil data profil dari Firestore dan isi controller
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection("user_data").doc(uid).get();

    Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

    if (userData != null) {
      setState(() {
        _nameController.text = userData['name'] ?? '';
        _phoneController.text = userData['phone_number'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _addressController.text = userData['address'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              enabled: false,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                UpdateProfile();
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> UpdateProfile() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection("user_data");

    await usersCollection.doc(uid).update({
      'name': _nameController.text,
      'phone_number': _phoneController.text,
      'email': _emailController.text,
      'address': _addressController.text,
    });

    showToast(message: "Edit successfully");
    Navigator.pushNamed(context, "/landing_page", arguments: '/profile_page');
  }
}
