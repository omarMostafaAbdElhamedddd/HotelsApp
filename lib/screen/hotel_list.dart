
import 'package:flutter/material.dart';

import '../models/hotel.dart';
import '../widgets/hotel_card.dart';
import '../widgets/hotel_screen_appbar.dart';
import 'home_page.dart';
class HotelList extends StatefulWidget {
  const HotelList({super.key, required this.hotels});
 final List<Hotel> hotels ;
  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HotelScreenAppbar(),
                const SizedBox(height: 20),
                GridView.builder(

                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => HotelCard(
                    hotel: widget.hotels[index],
                  ),
                  itemCount: widget.hotels.length,
                )
              ],
            ),
          ),
        ),
      ),
    );  }
}
