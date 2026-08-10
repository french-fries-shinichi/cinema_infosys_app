import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

}

// this is for bakas like me ///////////////////////////
// 0%   251B1B
// 50%  470707
// 100% 000000

class NavigationBar extends StatelessWidget {}
class ChatbotPage extends StatelessWidget {}
class ViewPostPage extends StatelessWidget {}
class NewPostPage extends StatelessWidget {}
class UserPage extends StatelessWidget {}