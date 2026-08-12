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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF251B1B),
            Color(0xFF470707),
            Color(0xFF000000)
          ],
          stops: <double>[0.0, 0.5, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
    );
  }
}

// this is standard values for bakas like me ///////////////////////////
//    Gradient:
// 0%   251B1B
// 50%  470707
// 100% 000000
//
//    Screen Resolution:
// W 375 | H 812

// class NavigationBar extends StatelessWidget {
//   const NavigationBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return x;
//   }
// }
// class ChatbotPage extends StatelessWidget {}
// class ViewPostPage extends StatelessWidget {}
// class NewPostPage extends StatelessWidget {}
// class UserPage extends StatelessWidget {}
