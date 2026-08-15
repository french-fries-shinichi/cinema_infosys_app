import 'package:flutter/material.dart';
import 'UserReview.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  // Use the global reviews list
  List<Map<String, dynamic>> get reviews => ReviewData.reviews;

  final Set<int> _upvotedReviews = {};

  void _addReview(String name, int rating, String review, String movie) {
    setState(() {
      ReviewData.addReview({
        'name': name,
        'rating': rating,
        'review': review,
        'date': DateTime.now().toString().substring(0, 10),
        'Movie': movie,
        'upvotes': 0,
      });
    });
  }

  void _toggleUpvote(int index) {
    setState(() {
      if (_upvotedReviews.contains(index)) {
        _upvotedReviews.remove(index);
        reviews[index]['upvotes'] = (reviews[index]['upvotes'] as int) - 1;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Upvote removed!'),
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        _upvotedReviews.add(index);
        reviews[index]['upvotes'] = (reviews[index]['upvotes'] as int) + 1;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Upvoted! 👍'),
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  bool _isUpvoted(int index) {
    return _upvotedReviews.contains(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews and Ratings'),
        backgroundColor: const Color.fromARGB(255, 199, 31, 2),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showReviewDialog(context);
            },
          ),
        ],
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
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Movie Reviews',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${reviews.length} reviews',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: reviews.isEmpty
                  ? const Center(
                      child: Text(
                        'No reviews yet',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return UserReview(
                          name: review['name'] as String,
                          rating: review['rating'] as int,
                          reviewText: review['review'] as String,
                          date: review['date'] as String,
                          movie: review['Movie'] as String,
                          upvotes: review['upvotes'] as int,
                          isUpvoted: _isUpvoted(index),
                          onUpvote: () => _toggleUpvote(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    final reviewController = TextEditingController();
    final movieController = TextEditingController();
    int selectedRating = 5;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Write a Review'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(UserData.userImage),
                          onBackgroundImageError: (error, stackTrace) {

                          },
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Reviewing as: ${UserData.userName}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),
                    TextField(
                      controller: movieController,
                      decoration: const InputDecoration(
                        labelText: 'Movie Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        const Text('Rate: '),
                        Row(
                          children: List.generate(
                            5,
                            (index) => IconButton(
                              icon: Icon(
                                index < selectedRating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedRating = index + 1;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: reviewController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Your Review',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (reviewController.text.isNotEmpty &&
                        movieController.text.isNotEmpty) {
                      _addReview(
                        UserData.userName,
                        selectedRating,
                        reviewController.text,
                        movieController.text,
                      );
                      Navigator.pop(context);
                      if (reviewController.text.length > 25) {
                        UserData.addCoins(5);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('🎉 Congrats!'),
                              content: Text(
                                'You have received 5 coins!\nTotal: ${UserData.coins} coins',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Review submitted successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Submit Review'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}