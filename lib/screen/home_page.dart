
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../widgets/home_appbar.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_slider.dart';
import '../widgets/hotel_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSlide = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FF),
      // backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(),
                const SizedBox(height: 20.0),
                const HomeSearchBar(),
                const SizedBox(height: 20.0),
                HomeSlider(
                  onChange: (value) {
                    setState(() {
                      currentSlide = value;
                    });
                  },
                  currentSlide: currentSlide,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                const HotelPage(),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        // color: Colors.deepPurple.shade200,
        color: Colors.cyanAccent,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index){
          print("object");
        },
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
           Icon(
            Icons.search_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.airplane_ticket_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class GetAllHotels{

  static Future<List<Hotel>> getallHotels() async {
    final response = await http.get(
      Uri.parse('http://depolyapi.runasp.net/api/Hotels/AllHotels'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );
    print('after');
    // print(response.statusCode);print(response.body);
   Map<String , dynamic> allHotels = jsonDecode(response.body);
    print(allHotels);
    List<Hotel> hotels = [];


    for (int i = 0; i < allHotels['\$values'].length; i++) {
      hotels.add(Hotel.fromJson(allHotels['\$values'][i]));


    }

    print(hotels);



    return hotels;
  }


}

class Hotel {
  final String photo1URL;
  final String photo2URL;
  final String photo3URL;
  final int hotelId;
  final String name;
  final String address;
  final int phone;
  final String description;
  final int rate ;
  final dynamic day_Double_Cost;
  final dynamic avilable_double_Rooms ;
  final dynamic avilable_single_Rooms;
  final bool has_SeeView;


  Hotel({
  required this.photo1URL,
  required this.hotelId,
  required this.name,
  required this.address,
  required this.phone,
  required this.description,
    required this.photo2URL,
    required this.photo3URL,
    required this.rate,
    required this.day_Double_Cost,
    required this.avilable_double_Rooms,
    required this.avilable_single_Rooms,
    required this.has_SeeView
});


  factory Hotel.fromJson(json) {
  return Hotel(
  photo1URL: json['photo1URL'],
  hotelId: json['hotel_Id'],
  name: json['name'],
  address: json['address'],
  phone: json['phone'],
  description: json['description'],
    photo2URL:  json['photo2URL'],
    photo3URL: json['photot3Url'],
    rate: json['rating'],
      day_Double_Cost : json['day_Double_Cost'],
    avilable_double_Rooms: json['avilable_double_Rooms'],
    avilable_single_Rooms: json['avilable_single_Rooms'],
    has_SeeView: json['has_SeeView']

  );
  }

}

