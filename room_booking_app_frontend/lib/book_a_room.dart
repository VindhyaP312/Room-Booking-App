import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookaRoomPage extends StatefulWidget {
  const BookaRoomPage({super.key});

  @override
  State<BookaRoomPage> createState() => _BookaRoomPageState();
}

class _BookaRoomPageState extends State<BookaRoomPage> {
  final _formKey = GlobalKey<FormState>();
  String _roomNumber = '';
  String _purpose = '';
  String _clubName = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var data = {
        'roomNumber': _roomNumber,
        'purpose': _purpose,
        'clubName': _clubName,
      };
      try {
        var response = await http.post(
          Uri.parse('http://192.168.0.121:2000/room-booking/book-a-room'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data),
        );

        if (response.statusCode == 200) {
          log('Room booked successfully');
          _formKey.currentState!.reset();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Room booked successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          log('Failed to book room: ${response.statusCode}');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Failed to book room. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        log('Error: $error');
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('An error occurred. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Book a Room",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          // crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Room Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the room number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _roomNumber = value!;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(hintText: 'Purpose of Booking'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the purpose of booking.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _purpose = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Club Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the club name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _clubName = value!;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: _submitForm, child: const Text('Book Room'))
            ],
          ),
        ),
      ),
    );
  }
}
