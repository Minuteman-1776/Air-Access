import 'package:flutter/material.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/form_page.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/home_page.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/my_ticket_page.dart';
import 'package:siakmhs_1001210005_2/features/user_auth/presentation/pages/profile_page.dart';


class LandingPage extends StatefulWidget{
  const LandingPage({Key?key,}) : super(key: key);

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage>{

  int selectedPage = 0;

  final List<Widget> pages = [
    HomePage(),
    FormPage(),
    MyTicketPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(
      //   leading: SizedBox(),
      //   centerTitle: false,
      //   title: Text("Airline Ticketing App"),
      // ),

      //Bottom Navbar Section :)
      body: pages[selectedPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          currentIndex: selectedPage,
          onTap: (page){
            setState(() {
              selectedPage = page;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.travel_explore),
                label: 'Travel'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'My Ticket'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile'
            ),
          ],
        ),
      ),
    );
  }
}