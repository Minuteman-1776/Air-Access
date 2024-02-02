import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/ticket/ticket_step_two.dart';
import '../../../../../common/toast.dart';

class TicketStepOne extends StatefulWidget {
  const TicketStepOne({Key? key}) : super(key: key);

  @override
  _TicketStepOneState createState() => _TicketStepOneState();
}

class _TicketStepOneState extends State<TicketStepOne> {
  String? _selectedFrom;
  String? _selectedTo;
  DateTime? _selectedDate;
  Map<String, String> _cities = {}; // Variabel buat simpen daftar kota

  @override
  void initState() {
    super.initState();
    _fetchLocations().then((cities) {
      setState(() {
        _cities = cities;
      });
    });
  }

  Future<Map<String, String>> _fetchLocations() async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('location').doc('city').get();
    Map<String, String> cities = {
      'city1': snapshot['city1'],
      'city2': snapshot['city2'],
      'city3': snapshot['city3'],
      'city4': snapshot['city4'],
    };
    return cities;
  }

  bool _validateForm() {
    return _selectedFrom != null && _selectedTo != null && _selectedDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step One - Enter Departure and Destination",
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
          height: 420,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedFrom,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFrom = newValue;
                  });
                },
                items: _cities.keys.map<DropdownMenuItem<String>>((String key) {
                  return DropdownMenuItem<String>(
                    value: _cities[key],
                    child: Text(_cities[key]!),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Departure'),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedTo,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTo = newValue;
                  });
                },
                items: _cities.keys.map<DropdownMenuItem<String>>((String key) {
                  return DropdownMenuItem<String>(
                    value: _cities[key],
                    child: Text(_cities[key]!),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Destination'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8),
                    Text("Select Date"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: false,
                controller: TextEditingController(
                  text: _selectedDate != null
                      ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                      : "",
                ),
                decoration: InputDecoration(labelText: 'Selected Date'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_validateForm()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketStepTwo(
                          selectedFrom: _selectedFrom,
                          selectedTo: _selectedTo,
                          selectedDate: _selectedDate,
                        ),
                      ),
                    );
                  } else {
                    showToast(message: "Please fill all required data");
                  }
                },
                child: Container(
                  height: 45,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Find Ticket",
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
      ),
    );
  }
}
