import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../common/toast.dart';
import 'debug/debug.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Step 1. Tangkep UID user yang sekarnag sudah login
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        // Step 2. Pake UID yang udah ditangkep buat ambil data di Firestore
        future: FirebaseFirestore.instance.collection("user_data").doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No data available"));
          }
          Map<String, dynamic>? userData = snapshot.data!.data() as Map<String, dynamic>?;

          if (userData == null) {
            return Center(child: Text("No user data available"));
          }

          // Step 4. Extract data yang diambil
          String name = userData['name'] as String? ?? "";
          String phoneNumber = userData['phone_number'] as String? ?? "";
          String email = userData['email'] as String? ?? "";
          String address = userData['address'] as String? ?? "";

          // Step 5. Tampilkan data yang udah di extract ke halaman profil
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent, Color(0xFFF2F2F2)],
                stops: [0.0, 0.4, 0.3],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12, width: 1.5),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 25),
                        CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage("assets/images/Profile.png"),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          name,
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          phoneNumber,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          email,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          address,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfilePage()),
                            );
                          },
                          child: Container(
                            height: 45,
                            width: 125,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Edit Profile",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DebugMode()),
                          );
                        },
                        child: Container(
                          height: 45,
                          width: 125,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Debug Mode",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, "/login_page");
                          showToast(message: "Successfully signed out");
                        },
                        child: Container(
                          height: 45,
                          width: 125,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Sign out",
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
