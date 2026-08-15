import 'package:flutter/material.dart';
import 'UserReview.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 60,
                  backgroundImage: const AssetImage('assets/profile/spiderman.jpg'),
                  backgroundColor: Colors.grey[300],
                  onBackgroundImageError: (error, stackTrace) {
                  },
                ),
                const SizedBox(height: 16),
                
                // User Name
                Text(
                  UserData.userName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                
                // User Email
                const Text(
                  'movie.fan@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Coin Count
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.amber.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${UserData.coins} Coins',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}