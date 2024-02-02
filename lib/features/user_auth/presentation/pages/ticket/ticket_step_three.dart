import 'package:flutter/material.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/ticket/ticket_step_four.dart';
import '../../../../../common/toast.dart';

class TicketStepThree extends StatefulWidget {
  final String? selectedFrom;
  final String? selectedTo;
  final DateTime? selectedDate;
  final String? selectedPlane;
  final String? planePrice;

  const TicketStepThree({
    Key? key,
    this.selectedFrom,
    this.selectedTo,
    this.selectedDate,
    this.selectedPlane,
    this.planePrice,
  }) : super(key: key);

  @override
  _TicketStepThreeState createState() => _TicketStepThreeState();
}

class _TicketStepThreeState extends State<TicketStepThree> {
  String? _selectedSeat;

  void submitData() {
    if (_selectedSeat == null) {
      showToast(message: "Please choose your seat before proceeding", center: true);
      return;
    }

    final ticketData = TicketData(
      selectedFrom: widget.selectedFrom,
      selectedTo: widget.selectedTo,
      selectedDate: widget.selectedDate,
      selectedPlane: widget.selectedPlane,
      planePrice: widget.planePrice,
      selectedSeat: _selectedSeat,
    );

    print('Ticket Data: $ticketData');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketStepFour(ticketData: ticketData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step Three - Choose a Seat",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.black),
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Ticket Information',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text('From: ${widget.selectedFrom}'),
                      Text('To: ${widget.selectedTo}'),
                      Text('Date: ${widget.selectedDate?.day}/${widget.selectedDate?.month}/${widget.selectedDate?.year}'),
                      Text('Plane: ${widget.selectedPlane} - Rp. ${widget.planePrice}'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Choose Your Seat',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      SeatGrid(
                        selectedSeat: _selectedSeat,
                        onSeatSelected: setSelectedSeat,
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: submitData,
                        child: Container(
                          height: 45,
                          width: 320,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
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
      ),
    );
  }

  void setSelectedSeat(String? seatLabel) {
    setState(() {
      _selectedSeat = seatLabel;
    });
  }
}

class SeatGrid extends StatelessWidget {
  final String? selectedSeat;
  final Function(String?) onSeatSelected;

  const SeatGrid({
    Key? key,
    required this.selectedSeat,
    required this.onSeatSelected,
  }) : super(key: key);

  String getSeatLabel(int seatNumber) {
    String row = String.fromCharCode('A'.codeUnitAt(0) + (seatNumber - 1) % 6);
    int col = (seatNumber - 1) ~/ 6 + 1;
    return '$row$col';
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 36,
      itemBuilder: (context, index) {
        String seatLabel = getSeatLabel(index + 1);
        bool isSeatSelected = selectedSeat == seatLabel;

        return Container(
          width: 50.0,
          height: 50.0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onSeatSelected(seatLabel);
              },
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isSeatSelected ? Colors.blue : Colors.grey[400],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    seatLabel,
                    style: TextStyle(
                      color: isSeatSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TicketData {
  final String? selectedFrom;
  final String? selectedTo;
  final DateTime? selectedDate;
  final String? selectedPlane;
  final String? planePrice;
  final String? selectedSeat;

  TicketData({
    this.selectedFrom,
    this.selectedTo,
    this.selectedDate,
    this.selectedPlane,
    this.planePrice,
    this.selectedSeat,
  });
}
