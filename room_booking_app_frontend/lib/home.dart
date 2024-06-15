import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:room_booking_app/book_a_room.dart';
import 'package:room_booking_app/view_bookings.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List bookings = [];

  void viewbookings() async {
    var response = await http
        .get(Uri.parse('http://192.168.0.121:2000/room-booking/view-bookings'));

    if (response.statusCode == 200) {
      bookings = json.decode(response.body);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ViewBookingsPage(bookings: bookings),
        ),
      );
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Room Booking App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const BookaRoomPage(),
                  ),
                );
              },
              child: const Text("Book a Room"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: viewbookings,
              child: const Text("View Bookings"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
