import 'package:flutter/material.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/ticket/ticket_step_one.dart';

import '../../../../common/toast.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent, Color(0xFFF2F2F2)],
            stops: [0.0, 0.3, 0.3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            height: 400,
            width: 500,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.black12, width: 1.5),
              borderRadius: BorderRadius.circular(25.0),
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFF2F2F2), Color(0xFFF2F2F2)],
                stops: [0.0, 0.3, 0.3],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding : const EdgeInsets.only(top: 15, bottom: 15, right: 55, left: 55),
                  margin : const EdgeInsets.only(top: 25, bottom: 15, right: 10, left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Alfatah Wibisono - 1001210005",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        "Sistem Informasi",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin : const EdgeInsets.only(top: 25, bottom: 15, right: 15, left: 15),
                  child: Divider(),
                ),
                SizedBox(height: 25),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TicketStepOne()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              fixedSize: Size(70, 70),
                              primary: Colors.blueAccent,
                            ),
                            child: Icon(Icons.airplane_ticket_outlined, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Domestic",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showToast(message: "Work in Progress :)");
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              fixedSize: Size(70, 70),
                              primary: Colors.blueAccent,
                            ),
                            child: Icon(Icons.airplane_ticket, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "International",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showToast(message: "Work in Progress :)");
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              fixedSize: Size(70, 70),
                              primary: Colors.blueAccent,
                            ),
                            child: Icon(Icons.backpack, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Cargo",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showToast(message: "Work in Progress :)");
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              fixedSize: Size(70, 70),
                              primary: Colors.blueAccent,
                            ),
                            child: Icon(Icons.star, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "VIP",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}