
import 'package:flutter/material.dart';
import 'package:hotels/constants.dart';
import 'package:hotels/screen/home_page.dart';

import '../models/hotel.dart';
import '../screen/book_screen.dart';
import '../screen/hotel_list.dart';
// import 'package:iconsax/iconsax.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  @override
  Widget build(BuildContext context) {

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Hotels",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
         FutureBuilder(future: GetAllHotels.getallHotels(), builder: (context, sn){
           if(sn.hasData){
             return     TextButton(
               onPressed: () => Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) =>  HotelList(hotels: sn.data!,),
                 ),
               ),
               child: const Text("View all"),
             );
           }else{
             return SizedBox();
           }
         })
        ],
      ),
      const SizedBox(height: 20),
      FutureBuilder(future: GetAllHotels.getallHotels(), builder: (context , sn){

        if(sn.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: kprimaryColor,),);
        }else if(sn.hasData){
          print(sn.data);
          return SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: sn.data!.length,
                itemBuilder: (context , index){
              return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return BookingScreen(hotel: sn.data![index]);
                    }));
                  },
                  child: HotelItem(hotel: sn.data![index]));
            }),
          );
        }else{
          return Center(child: Text('Something went wrong'),);
        }
      })
    ]);
  }
}

class HotelItem extends StatelessWidget {
  const HotelItem({
    super.key, required this.hotel,
  });
final Hotel hotel ;
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 200,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade200, // Placeholder background color
                      ),
                      child: Center(
                        child: CircularProgressIndicator(), // Placeholder loading indicator
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        hotel.photo1URL,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 130,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Center(
                            child: Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Text(
               hotel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Row(
              //   children: [
              //     const Icon(
              //       Iconsax.flash_1,
              //       size: 18,
              //       color: Colors.grey,
              //     ),
              //     Text(
              //       "${foods[index].cal} Cal",
              //       style: const TextStyle(
              //         fontSize: 12,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     const Text(
              //       " · ",
              //       style: TextStyle(color: Colors.grey),
              //     ),
              //     const Icon(
              //       Iconsax.clock,
              //       size: 18,
              //       color: Colors.grey,
              //     ),
              //     Text(
              //       "${foods[index].time} Min",
              //       style: const TextStyle(
              //         fontSize: 12,
              //         color: Colors.grey,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
          // Positioned(
          //   top: 1,
          //   right: 1,
          //   child: IconButton(
          //     onPressed: () {},
          //     style: IconButton.styleFrom(
          //       backgroundColor: Colors.white,
          //       fixedSize: const Size(30, 30),
          //     ),
          //     iconSize: 20,
          //     icon: const Icon(Iconsax.heart),
          //   ),
          // )
        ],
      ),
    );
  }
}
