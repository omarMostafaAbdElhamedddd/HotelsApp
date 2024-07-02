
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../models/hotel.dart';
import '../screen/book_screen.dart';
import '../screen/home_page.dart';


class HotelCard extends StatelessWidget {
  final Hotel hotel;
  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingScreen(hotel: hotel),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child:Container(
                    width: double.infinity,
                    height: 130, // Provide height if required
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
                            // Although asset images load quickly, this loadingBuilder structure can be kept for consistency
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
                  )

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
                // Row(
                //   children: [
                //     const Icon(
                //       Iconsax.flash_1,
                //       size: 18,
                //       color: Colors.grey,
                //     ),
                //     Text(
                //       "${food.cal} Cal",
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
                //       "${food.time} Min",
                //       style: const TextStyle(
                //         fontSize: 12,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Icon(Iconsax.star5,
                        color: Colors.yellow.shade700, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      "rating : 2/5",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 5),

                  ],
                )
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
            //     icon: food.isLiked!
            //         ? const Icon(
            //       Iconsax.heart5,
            //       color: Colors.red,
            //     )
            //         : const Icon(Iconsax.heart),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
