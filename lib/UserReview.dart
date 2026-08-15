import 'package:flutter/material.dart';

// User Data Class
class UserData {
  static String userName = 'Movie Fan';
  static String userImage = 'assets/profile/blob.jpg';
  static int coins = 0;
  
  static void updateUser(String name, {String? image}) {
    userName = name.isNotEmpty ? name : 'Movie Fan';
    if (image != null) userImage = image;
  }
  
  static void addCoins(int amount) {
    coins += amount;
  }
  
  static void resetCoins() {
    coins = 0;
  }
}

// Global Reviews Data Class
class ReviewData {
  static List<Map<String, dynamic>> reviews = [
    {
      'name': 'John Doe',
      'rating': 5,
      'review': 'I love this movie it changed my life.',
      'date': '01 Jan, 2026',
      'Movie': 'Odyssey',
      'upvotes': 12,
    },
    {
      'name': 'Jane Smith',
      'rating': 4,
      'review': 'This movie made me cry it was so beautifully shot.',
      'date': '15 Feb, 2026',
      'Movie': 'Spiderman Brand New Day',
      'upvotes': 8,
    },
    {
      'name': 'Bob Waterson',
      'rating': 5,
      'review': 'I was doubtful at first but it really blew it out of the ball park with this one',
      'date': '20 Mar, 2026',
      'Movie': 'Obsession',
      'upvotes': 25,
    },
  ];
  
  static Map<String, dynamic>? getTopReview() {
    if (reviews.isEmpty) return null;
    return reviews.reduce((a, b) => 
      (a['upvotes'] as int) > (b['upvotes'] as int) ? a : b
    );
  }
  
  static void addReview(Map<String, dynamic> review) {
    reviews.add(review);
  }
}

class UserReview extends StatelessWidget {
  final String name;
  final int rating;
  final String reviewText;
  final String date;
  final String movie;
  final int upvotes;
  final bool isUpvoted;
  final VoidCallback onUpvote;

  const UserReview({
    super.key,
    required this.name,
    required this.rating,
    required this.reviewText,
    required this.date,
    required this.movie,
    this.upvotes = 0,
    this.isUpvoted = false,
    required this.onUpvote,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> avatarPfp = [
      'assets/profile/blob.jpg',
      'assets/profile/car.jpg',
      'assets/profile/Smitski.jpg',
    ];
    
    final String selectedImage = avatarPfp[name.length % avatarPfp.length];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
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
              movie.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            
            // Divider
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            const SizedBox(height: 6),
            
            // User Info Row
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(selectedImage),
                  onBackgroundImageError: (error, stackTrace) {
                    // Fallback if image fails
                  },
                ),
                const SizedBox(width: 10.0),
                
                // Name and Rating
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Date
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            
            // Review Text
            Text(
              reviewText,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12.0),
            
            // Upvote Button
            GestureDetector(
              onTap: onUpvote,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isUpvoted 
                      ? Colors.green.withOpacity(0.3)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isUpvoted 
                        ? Colors.green
                        : Colors.green.withOpacity(0.3),
                    width: isUpvoted ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isUpvoted 
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up_alt_outlined,
                      color: Colors.green,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$upvotes',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isUpvoted ? 'Upvoted' : 'Upvote',
                      style: TextStyle(
                        color: isUpvoted ? Colors.green : Colors.green.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: isUpvoted ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}