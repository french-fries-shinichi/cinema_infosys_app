import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// ===== MOVIE DATABASE =====
class MovieDatabase {
  static final List<Map<String, dynamic>> movies = [
    // ACTION MOVIES
    {
      'title': 'The Dark Knight',
      'year': 2008,
      'genre': 'Action, Crime, Drama',
      'rating': 9.0,
      'description': 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      'director': 'Christopher Nolan',
      'cast': ['Christian Bale', 'Heath Ledger', 'Aaron Eckhart'],
    },
    {
      'title': 'John Wick',
      'year': 2014,
      'genre': 'Action, Crime, Thriller',
      'rating': 7.4,
      'description': 'An ex-hitman comes out of retirement to track down the gangsters who killed his dog and stole his car.',
      'director': 'Chad Stahelski',
      'cast': ['Keanu Reeves', 'Michael Nyqvist', 'Alfie Allen'],
    },
    {
      'title': 'Die Hard',
      'year': 1988,
      'genre': 'Action, Thriller',
      'rating': 8.2,
      'description': 'A New York City police officer tries to save his estranged wife and several others taken hostage by terrorists during a Christmas party at the Nakatomi Plaza in Los Angeles.',
      'director': 'John McTiernan',
      'cast': ['Bruce Willis', 'Alan Rickman', 'Bonnie Bedelia'],
    },
    // COMEDY MOVIES
    {
      'title': 'The Hangover',
      'year': 2009,
      'genre': 'Comedy',
      'rating': 7.7,
      'description': 'Three buddies wake up from a bachelor party in Las Vegas with no memory of the previous night and the bachelor missing. They must retrace their steps to find him.',
      'director': 'Todd Phillips',
      'cast': ['Bradley Cooper', 'Ed Helms', 'Zach Galifianakis'],
    },
    {
      'title': 'Superbad',
      'year': 2007,
      'genre': 'Comedy',
      'rating': 7.6,
      'description': 'Two co-dependent high school seniors are forced to deal with separation anxiety after their plan to stage a booze-soaked party goes awry.',
      'director': 'Greg Mottola',
      'cast': ['Jonah Hill', 'Michael Cera', 'Christopher Mintz-Plasse'],
    },
    {
      'title': 'Step Brothers',
      'year': 2008,
      'genre': 'Comedy',
      'rating': 6.9,
      'description': 'Two aimless middle-aged losers still living at home are forced against their will to become roommates when their parents marry.',
      'director': 'Adam McKay',
      'cast': ['Will Ferrell', 'John C. Reilly', 'Mary Steenburgen'],
    },
    // ROMANCE MOVIES
    {
      'title': 'The Notebook',
      'year': 2004,
      'genre': 'Romance, Drama',
      'rating': 7.8,
      'description': 'A poor yet passionate young man falls in love with a rich young woman, giving her a sense of freedom, but they are soon separated because of their social differences.',
      'director': 'Nick Cassavetes',
      'cast': ['Ryan Gosling', 'Rachel McAdams', 'James Garner'],
    },
    {
      'title': 'Crazy Rich Asians',
      'year': 2018,
      'genre': 'Romance, Comedy',
      'rating': 6.9,
      'description': 'This contemporary romantic comedy follows native New Yorker Rachel Chu to Singapore to meet her boyfriend\'s family.',
      'director': 'Jon M. Chu',
      'cast': ['Constance Wu', 'Henry Golding', 'Michelle Yeoh'],
    },
    {
      'title': 'La La Land',
      'year': 2016,
      'genre': 'Romance, Musical, Drama',
      'rating': 8.0,
      'description': 'A pianist and an actress fall in love while navigating their careers in Los Angeles.',
      'director': 'Damien Chazelle',
      'cast': ['Ryan Gosling', 'Emma Stone', 'John Legend'],
    },
    // SCI-FI MOVIES
    {
      'title': 'Inception',
      'year': 2010,
      'genre': 'Sci-Fi, Action, Thriller',
      'rating': 8.8,
      'description': 'A thief who steals secrets through dream-sharing technology is given the task of planting an idea into the mind of a CEO.',
      'director': 'Christopher Nolan',
      'cast': ['Leonardo DiCaprio', 'Joseph Gordon-Levitt', 'Elliot Page'],
    },
    {
      'title': 'The Matrix',
      'year': 1999,
      'genre': 'Sci-Fi, Action',
      'rating': 8.7,
      'description': 'A computer hacker discovers the shocking truth - the life he knows is the elaborate deception of an evil cyber-intelligence.',
      'director': 'Lana Wachowski, Lilly Wachowski',
      'cast': ['Keanu Reeves', 'Laurence Fishburne', 'Carrie-Anne Moss'],
    },
    {
      'title': 'Interstellar',
      'year': 2014,
      'genre': 'Sci-Fi, Adventure, Drama',
      'rating': 8.6,
      'description': 'A team of explorers travel through a wormhole in space to ensure humanity\'s survival.',
      'director': 'Christopher Nolan',
      'cast': ['Matthew McConaughey', 'Anne Hathaway', 'Jessica Chastain'],
    },
  ];

  static List<Map<String, dynamic>> searchMovies(String query) {
    final lowerQuery = query.toLowerCase();
    return movies.where((movie) {
      return movie['title'].toLowerCase().contains(lowerQuery) ||
          movie['genre'].toLowerCase().contains(lowerQuery) ||
          movie['director'].toLowerCase().contains(lowerQuery) ||
          movie['description'].toLowerCase().contains(lowerQuery);
    }).toList();
  }

  static List<Map<String, dynamic>> getMoviesByGenre(String genre) {
    final lowerGenre = genre.toLowerCase();
    return movies.where((movie) {
      return movie['genre'].toLowerCase().contains(lowerGenre);
    }).toList();
  }
}

// ===== MAIN CHATBOT =====
class Aichatbot extends StatefulWidget {
  const Aichatbot({super.key});

  @override
  State<Aichatbot> createState() => _AichatbotState();
}

class _AichatbotState extends State<Aichatbot> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  File? jsonFile;
  Directory? dir;
  String fileName = "chat_history.json";
  bool fileExists = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    if (_messages.isEmpty) {
      setState(() {
        _messages.add({
          'sender': 'ai',
          'message': '🎬 Welcome to CineBot!\n\nI can recommend movies based on genre, mood, or specific titles.\n\nTry asking me:\n• "Recommend action movies"\n• "Show me comedies"\n• "Movies like The Dark Knight"\n• "Romance movies"\n\nWhat are you in the mood for?',
        });
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadChatHistory() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      dir = directory;
      jsonFile = File('${directory.path}/$fileName');
      fileExists = await jsonFile!.exists();

      if (fileExists) {
        String content = await jsonFile!.readAsString();
        List<dynamic> decoded = json.decode(content);
        setState(() {
          _messages.clear();
          for (var item in decoded) {
            _messages.add(Map<String, String>.from(item));
          }
        });
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('Error loading chat history: $e');
    }
  }

  Future<void> _saveChatHistory() async {
    try {
      if (jsonFile == null) {
        final directory = await getApplicationDocumentsDirectory();
        jsonFile = File('${directory.path}/$fileName');
      }
      String jsonString = json.encode(_messages);
      await jsonFile!.writeAsString(jsonString);
    } catch (e) {
      debugPrint('Error saving chat history: $e');
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add({
        'sender': 'user',
        'message': text,
      });
      _messageController.clear();
      _isLoading = true;
    });

    _saveChatHistory();
    _scrollToBottom();

    try {
      final responseText = await _getLocalResponse(text);

      if (!mounted) return;

      setState(() {
        _messages.add({
          'sender': 'ai',
          'message': responseText,
        });
      });

      _saveChatHistory();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'sender': 'ai',
          'message': 'Sorry, I encountered an error. Please try again. 🎬',
        });
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _scrollToBottom();
      }
    }
  }

  Future<String> _getLocalResponse(String userMessage) async {
    final lowerMessage = userMessage.toLowerCase();
    
    // Check for genre keywords
    List<String> genres = ['action', 'comedy', 'romance', 'sci-fi', 'horror', 'animation', 'drama', 'thriller'];
    String detectedGenre = '';
    
    for (var genre in genres) {
      if (lowerMessage.contains(genre)) {
        detectedGenre = genre;
        break;
      }
    }
    
    // If genre is detected, recommend movies from that genre
    if (detectedGenre.isNotEmpty) {
      final recommendations = MovieDatabase.getMoviesByGenre(detectedGenre);
      if (recommendations.isNotEmpty) {
        String response = '🎬 I found these ${detectedGenre.toUpperCase()} movies for you:\n\n';
        for (var movie in recommendations.take(3)) {
          response += '**${movie['title']}** (${movie['year']})\n';
          response += '📝 ${movie['description']}\n';
          response += '⭐ ${movie['rating']}/10\n';
          response += '🎭 ${movie['genre']}\n\n';
        }
        response += 'Would you like more details about any of these?';
        return response;
      }
    }
    
    // Check for specific movie title
    final movies = MovieDatabase.searchMovies(userMessage);
    if (movies.isNotEmpty) {
      String response = '🎥 I found these movies matching your search:\n\n';
      for (var movie in movies.take(3)) {
        response += '**${movie['title']}** (${movie['year']})\n';
        response += '📝 ${movie['description']}\n';
        response += '⭐ ${movie['rating']}/10\n';
        response += '🎭 ${movie['genre']}\n\n';
      }
      return response;
    }
    
    // Fallback response
    return '''
🎬 I can recommend movies based on:

• **Genre**: Action, Comedy, Romance, Sci-Fi, Horror
• **Mood**: Feel-good, Thrilling, Heartwarming
• **Specific movies**: "Movies like The Dark Knight"

Try asking:
• "Recommend action movies"
• "Show me comedy films"
• "Romance movies to watch"

What kind of movies are you looking for today?
''';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineBot'),
        backgroundColor: const Color.fromARGB(255, 199, 31, 2),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _messages.clear();
                _addWelcomeMessage();
                _saveChatHistory();
              });
            },
            tooltip: 'Clear chat',
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
            stops: <double>[0.0, 0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _messages.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.movie_filter_outlined,
                            color: Colors.white54,
                            size: 60,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Ask for movie recommendations!',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'e.g. "Action movies" or\n"Movies like Inception"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final bool isUser = message['sender'] == 'user';

                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? Colors.redAccent
                                  : Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(18),
                                topRight: const Radius.circular(18),
                                bottomLeft: Radius.circular(isUser ? 18 : 2),
                                bottomRight: Radius.circular(isUser ? 2 : 18),
                              ),
                            ),
                            child: Text(
                              message['message'] ?? '',
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Searching movies...',
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                  ],
                ),
              ),

            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      enabled: !_isLoading,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Ask about movies, actors, genres...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.redAccent,
                    ),
                    onPressed: _isLoading ? null : _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}