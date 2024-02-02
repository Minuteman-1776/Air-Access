import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/old/_old_read_page.dart';

import '../form_page.dart';

class EditFormPage extends StatefulWidget {
  final UserModel user;

  const EditFormPage({Key? key, required this.user}) : super(key: key);

  // Convert ke halaman diamis :)
  @override
  DynamicEditFormPage createState() => DynamicEditFormPage();
}

class DynamicEditFormPage extends State<EditFormPage> {
  late TextEditingController _usernameController;
  late TextEditingController _addressController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _addressController = TextEditingController(text: widget.user.address);
    _ageController = TextEditingController(text: widget.user.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Your Data",
                style: TextStyle(fontSize: 20)),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _updateUser();
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUser() {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final newData = UserModel(
      id: widget.user.id,
      username: _usernameController.text,
      address: _addressController.text,
      age: int.tryParse(_ageController.text) ?? 0,
    ).toJson();

    userCollection.doc(widget.user.id).update(newData);

    Navigator.pop(context);
  }
}
