import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class NontechFormPage extends StatefulWidget {
  @override
  _NontechFormPageState createState() => _NontechFormPageState();
}

class _NontechFormPageState extends State<NontechFormPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _eventCategories = [
    "ACM",
    "IEEE",
    "ART CIRCLE",
    "CSI",
    "DEBSOC",
    "NSS",
    "PICTOREAL",
    "ROBOTICS CLUB",
    "TEDx",
  ];

  // Form fields values
  String _eventName = '';
  String? _eventCategory;
  String _eventInfo = '';
  String _eventLink = '';
  String _dateTime = '';
  DateTime _eventStartDateTime = DateTime.now();
  DateTime? _eventEndDateTime;
  int? _eventDuration;
  int? _eventFees;
  String _eventVenue = '';
  File? _eventImage; // File for Event Image

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _eventImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        shadowColor: Colors.grey[600],
        elevation: 1,
        title: const Text('Non-Technical Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventName = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Event Category',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                dropdownColor: Colors.grey[800],
                style: const TextStyle(color: Colors.white),
                value: _eventCategory,
                items: _eventCategories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select event category';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _eventCategory = value!;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Event Info',
                    labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event info';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                onSaved: (value) {
                  _eventInfo = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Event Link',
                    labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event link';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                onSaved: (value) {
                  _eventLink = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Event Venue',
                    labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event venue';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                onSaved: (value) {
                  _eventVenue = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Event Start Date and Time',
                    labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event start date and time';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                onSaved: (value) {
                  // Parse and save start date time here
                  _dateTime = value!;
                },
              ),
              Text(
                'Event Image',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 10), // Add some spacing
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 100, // Reduced height
                  color: Colors.grey[800],
                  child: _eventImage == null
                      ? Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 30, // Reduced size
                            color: Colors.white,
                          ),
                        )
                      : Image.file(
                          _eventImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //       labelText: 'Event End Date and Time (Optional)',
              //       labelStyle: TextStyle(color: Colors.white)),
              //   style: const TextStyle(color: Colors.white),
              //   onSaved: (value) {
              //     // Parse and save end date time here
              //   },
              // ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Event Duration (Optional)',
                    labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                onSaved: (value) {
                  // Parse and save event duration here
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Event Fees (Optional)',
                    labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                onSaved: (value) {
                  // Parse and save event fees here
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitForm();
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    String imageUrl = '';

    if (_eventImage != null) {
      imageUrl = _eventImage!.path.split('/').last;
    }

    var requestBody = {
      "title": _eventName,
      "description": _eventInfo,
      "datetime": _dateTime,
      "location": _eventVenue,
      "imageUrl": imageUrl,
      "link": _eventLink,
    };

    print('Request Body: $requestBody');

    var response = await http.post(
      Uri.parse(createEvent),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    print('Response: ${response.body}');

    Navigator.pop(context);
  }
}
