import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/old/_old_edit_form_page.dart';

class MyTicketPage extends StatelessWidget {
  const MyTicketPage({Key?key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("My Ticket Page"),
      // ),
      body: Center(
          child: Column(
            children: [
              Text("My Ticket",
                style: TextStyle(fontSize: 20),
              ),
              StreamBuilder<List<UserModel>>(
                  stream: _readData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(child: Text("No Data Yet")
                      );
                    }
                    final users = snapshot.data;

                    return Padding(padding: EdgeInsets.all(8),
                      child: Column(
                          children: users!.map((user) {
                            return ListTile(
                                leading: GestureDetector(
                                  onTap: (){
                                    _deleteData(user.id!);
                                  },
                                  child: Icon(Icons.delete),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditFormPage(user: user),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.update),
                                ),
                                title: Text(user.username!),
                                subtitle: Text(user.address!)
                            );
                          }).toList()
                      ),
                    );
                  }
              ),
            ],
          )
      ),
    );
  }
  Stream<List<UserModel>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("users");

    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.formSnapshot(e)).toList());
  }

  void _deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    userCollection.doc(id).delete();
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