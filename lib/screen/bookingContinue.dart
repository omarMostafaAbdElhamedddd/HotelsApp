import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'book_screen.dart';


class BookingFormScreen extends StatefulWidget {
  final BookingService bookingService;

  BookingFormScreen({required this.bookingService});

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  double _price = 0;
  DateTime _bookTime = DateTime.now();
  int _duration = 0;
  bool _isBooked = true;
  bool _isSingle = true;
  int _rooms = 0;
  int _tripId = 0;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await widget.bookingService.createBooking(
          price: _price,
          bookTime: _bookTime.toIso8601String(),
          duration: _duration,
          isBooked: _isBooked,
          isSingle: _isSingle,
          rooms: _rooms,
          tripId: _tripId,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking created successfully!')),
        );
        await Future.delayed(Duration(seconds:4 ));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create booking: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Time'),
                initialValue: DateFormat('yyyy-MM-ddTHH:mm:ss').format(_bookTime),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _bookTime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _bookTime) {
                    setState(() {
                      _bookTime = picked;
                    });
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duration'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  _duration = int.parse(value!);
                },
              ),
              SwitchListTile(
                title: Text('Is Booked'),
                value: _isBooked,
                onChanged: (bool value) {
                  setState(() {
                    _isBooked = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Is Single'),
                value: _isSingle,
                onChanged: (bool value) {
                  setState(() {
                    _isSingle = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rooms'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of rooms';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rooms = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Trip ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the trip ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tripId = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
