import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/ticket/ticket_step_three.dart';

class TicketStepTwo extends StatefulWidget {
  final String? selectedFrom;
  final String? selectedTo;
  final DateTime? selectedDate;

  const TicketStepTwo({
    Key? key,
    required this.selectedFrom,
    required this.selectedTo,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _TicketStepTwoState createState() => _TicketStepTwoState();
}

class _TicketStepTwoState extends State<TicketStepTwo> {
  Map<String, String> _planePrices = {};

  @override
  void initState() {
    super.initState();
    _fetchPlanePrices().then((planePrices) {
      setState(() {
        _planePrices = planePrices;
      });
    });
  }

  Future<Map<String, String>> _fetchPlanePrices() async {
    String route = '${widget.selectedFrom}_${widget.selectedTo}';
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('price').doc(route).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      Map<String, String> planePrices = {};
      data.forEach((key, value) {
        planePrices[key] = value.toString();
      });

      return planePrices;
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step Two - Choose a Airline",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Plane from ${widget.selectedFrom} to ${widget.selectedTo}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _planePrices.length,
                  itemBuilder: (context, index) {
                    String planeName = _planePrices.keys.elementAt(index);
                    String planePrice = _planePrices[planeName]!;

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.black12),
                      ),
                      child: ListTile(
                        title: Text('$planeName - Rp. $planePrice'),
                        onTap: () => _onPlaneSelected(planeName),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPlaneSelected(String selectedPlane) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketStepThree(
          selectedFrom: widget.selectedFrom,
          selectedTo: widget.selectedTo,
          selectedDate: widget.selectedDate,
          selectedPlane: selectedPlane,
          planePrice: _planePrices[selectedPlane]!,
        ),
      ),
    );
  }
}
