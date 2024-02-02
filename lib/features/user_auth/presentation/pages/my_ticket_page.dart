import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyTicketPage extends StatelessWidget {
  const MyTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent, Color(0xFFF2F2F2)],
            stops: [0.0, 0.6, 0.3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("user_data").doc(uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text("No user data available");
            }

            Map<String, dynamic>? userData = snapshot.data!.data() as Map<String, dynamic>?;

            if (userData == null) {
              return Text("Invalid user data");
            }

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("user_data").doc(uid).collection("tickets").snapshots(),
              builder: (context, ticketSnapshot) {
                if (ticketSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (ticketSnapshot.hasError) {
                  return Text("Error: ${ticketSnapshot.error}");
                } else if (!ticketSnapshot.hasData || ticketSnapshot.data == null || ticketSnapshot.data!.docs.isEmpty) {
                  return Text("No ticket data available");
                }

                List<QueryDocumentSnapshot> ticketDocuments = ticketSnapshot.data!.docs;

                return ListView.builder(
                  itemCount: ticketDocuments.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? ticketData = ticketDocuments[index].data() as Map<String, dynamic>?;

                    if (ticketData == null) {
                      return Text("Invalid ticket data");
                    }

                    return TicketListTile(userData: userData, ticketData: ticketData, onDeleted: () {
                      _deleteTicket(ticketDocuments[index].id);
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _deleteTicket(String ticketId) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection("user_data")
        .doc(uid)
        .collection("tickets")
        .doc(ticketId)
        .delete()
        .then((value) {
      print("Ticket deleted successfully");
    }).catchError((error) {
      print("Failed to delete ticket: $error");
    });
  }
}

class TicketListTile extends StatelessWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> ticketData;
  final VoidCallback onDeleted;

  const TicketListTile({
    Key? key,
    required this.userData,
    required this.ticketData,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, right: 18, left: 18),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12, width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Row(
          children: [
            Icon(Icons.location_on_sharp), // Ikon Pesawat
            SizedBox(width: 8), // Jarak antara ikon dan teks
            Text("${ticketData['origin']} " " > " " ${ticketData['destination']}"),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.account_circle), // Ikon Profil
                SizedBox(width: 8), // Jarak antara ikon dan teks
                Text("${userData['name']}"),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.airplanemode_active), // Ikon Pesawat (ganti dengan ikon yang sesuai)
                SizedBox(width: 8), // Jarak antara ikon dan teks
                Text("${ticketData['plane']}"),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.attach_money), // Ikon Data (ganti dengan ikon yang sesuai)
                SizedBox(width: 8), // Jarak antara ikon dan teks
                Text("Rp. ${ticketData['price']}"),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.date_range), // Ikon Tiket (ganti dengan ikon yang sesuai)
                SizedBox(width: 8), // Jarak antara ikon dan teks
                Text("${ticketData['date']}"),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDeleted,
        ),
      ),
    );
  }
}
