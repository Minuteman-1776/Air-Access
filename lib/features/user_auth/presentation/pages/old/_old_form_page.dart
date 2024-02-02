import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../common/toast.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  //Convert dari state statis ke dinamis :)
  @override
  DynamicFormPage createState() => DynamicFormPage();
}

class DynamicFormPage extends State<FormPage>{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Form Page",
                style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                //Cek apakah formulir kosong?
                if (nameController.text.isEmpty || addressController.text.isEmpty || ageController.text.isEmpty){
                  showToast(message: 'Please fill all required data');
                }
                else {
                  _createData(UserModel(
                    username : nameController.text,
                    address : addressController.text,
                    age : int.tryParse(ageController.text) ?? 0,
                  )
                  );
                  showToast(message: 'Thank you! Data succesfully submited');
                }
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Submit",
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

  void _createData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    String id = userCollection.doc().id;

    final newUser = UserModel(
      id: id,
      username: userModel.username,
      address: userModel.address,
      age: userModel.age,
    ).toJson();

    userCollection.doc(id).set(newUser);

    nameController.clear();
    addressController.clear();
    ageController.clear();
  }
}


class UserModel{
  final String? id;
  final String? username;
  final String? address;
  final int? age;

  UserModel({this.id, this.username, this.address, this.age});

  static UserModel formSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return UserModel(
        id: snapshot['id'],
        username: snapshot['username'],
        address: snapshot['address'],
        age: snapshot['age']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "username" : username,
      "address" : address,
      "age" : age,
    };
  }
}
