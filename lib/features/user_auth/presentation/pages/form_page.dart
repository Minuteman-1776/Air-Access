import 'package:flutter/material.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/ticket/ticket_step_one.dart';
import '../../../../common/toast.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key});

  @override
  DynamicFormPage createState() => DynamicFormPage();
}

class DynamicFormPage extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Layanan Penerbangan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Row(
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
              SizedBox(height: 40),
              Text(
                "Popular Destination",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/images/Denpasar.jpg',
                      height: 150,
                      width: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Text(
                      "Denpasar",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/images/Jakarta.jpg',
                      height: 150,
                      width: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Text(
                      "Jakarta",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
