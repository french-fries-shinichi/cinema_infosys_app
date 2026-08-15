import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'ReviewScreen.dart';
import 'UserReview.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the top review
    final topReview = ReviewData.getTopReview();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(255, 199, 31, 2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF251B1B),
              Color(0xFF470707),
              Color(0xFF000000),
            ],
            stops: <double>[0.0, 0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: ListView(
          children: [
            // Movies Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 16.0, bottom: 8.0),
                  child: Text(
                    'Movies',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 350.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                    enableInfiniteScroll: true,
                  ),
                  items: [
                    'assets/images/Backrooms.jpg',
                    'assets/images/Obsession.jpg',
                    'assets/images/Odyssey.jpg',
                    'assets/images/ProjectHailMary.jpg',
                    'assets/images/SpidermanBrandNewDay.jpg',
                  ].map((imagePath) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Center(
                                child: Text(
                                  'Image not found',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            // Featured Review Section
            const Padding(
              padding: EdgeInsets.only(left: 12.0, top: 20.0, bottom: 8.0),
              child: Text(
                'Featured Review',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Featured Review Card
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReviewScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: topReview != null
                    ? Card(
                        color: Colors.white.withOpacity(0.95),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Movie Title
                              Text(
                                topReview['Movie'].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Divider(color: Colors.grey, thickness: 0.5),
                              const SizedBox(height: 4),
                              
                              // User Info
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                      topReview['name'][0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          topReview['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            ...List.generate(
                                              5,
                                              (index) => Icon(
                                                index < (topReview['rating'] as int)
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.amber,
                                                size: 14,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.thumb_up_alt,
                                                    color: Colors.green,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${topReview['upvotes']}',
                                                    style: const TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    topReview['date'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              
                              // Review Text
                              Text(
                                topReview['review'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              
                              // Footer
                              Row(
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    color: Colors.blue,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'Top Rated Review',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'View all →',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Card(
                        color: Colors.white.withOpacity(0.95),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Text(
                              'No reviews yet.\nBe the first to review!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}