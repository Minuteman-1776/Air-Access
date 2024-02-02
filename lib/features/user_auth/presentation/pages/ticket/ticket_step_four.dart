import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/landing_page.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/ticket/ticket_step_three.dart';

import '../../../../../common/toast.dart';

class TicketStepFour extends StatelessWidget {
  final TicketData ticketData;

  const TicketStepFour({Key? key, required this.ticketData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ambil UID pengguna yang sekarang di State atau sudah login
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text("Step Four - Summary",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 92, right: 92, top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Ticket Summary',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 300,
                      height: 250,
                      padding: EdgeInsets.all(22.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("user_data")
                            .doc(uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            return Text("No data available");
                          }
                          Map<String, dynamic>? userData =
                              snapshot.data!.data() as Map<String, dynamic>?;
                          if (userData == null) {
                            return Text("No user data available");
                          }
                          String name = userData['name'] as String? ?? "";
                          String phoneNumber =
                              userData['phone_number'] as String? ?? "";
                          String email = userData['email'] as String? ?? "";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: $name'),
                              Text('Phone : $phoneNumber'),
                              Text('Email: $email'),
                              SizedBox(height: 20),
                              Text('From: ${ticketData.selectedFrom}'),
                              Text('To: ${ticketData.selectedTo}'),
                              Text(
                                  'Date: ${ticketData.selectedDate?.day}/${ticketData.selectedDate?.month}/${ticketData.selectedDate?.year}'),
                              Text(
                                  'Plane: ${ticketData.selectedPlane} - Rp. ${ticketData.planePrice}'),
                              Text('Seat: ${ticketData.selectedSeat}'),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        // Ambil referensi koleksi user_ticket untuk UID pengguna yang login
                        CollectionReference userTicketCollection =
                            FirebaseFirestore.instance
                                .collection('user_data')
                                .doc(uid)
                                .collection('tickets');

                        // Menyiapkan data tiket yang mau disimpan ke firestore
                        Map<String, dynamic> ticketDataFirestore = {
                          'origin': ticketData.selectedFrom,
                          'destination': ticketData.selectedTo,
                          'date':
                              '${ticketData.selectedDate?.day}/${ticketData.selectedDate?.month}/${ticketData.selectedDate?.year}',
                          'plane': ticketData.selectedPlane,
                          'price' : ticketData.planePrice,
                          'seat': ticketData.selectedSeat,
                        };

                        try {
                          // Tambahkan data tiket ke subkoleksi tiket di dokumen pengguna
                          await userTicketCollection.add(ticketDataFirestore);

                          // Pindah ke halaman landing setelah selesai menyimpan data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()),
                          );
                          showToast(message: "Transaction Successfuly");
                        } catch (e) {
                          print("Error saving ticket data: $e");
                          // Handle
                        }
                      },
                      child: Container(
                        height: 38,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Buy a Ticket Now",
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
            ],
          ),
        ),
      ),
    );
  }
}
