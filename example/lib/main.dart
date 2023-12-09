import 'package:flutter/material.dart';
import 'package:whatsapp_chatbot/whatsapp_chatbot.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> keywords = [];

  final config = Config(
    botDelay: 3,
    waitText: 'Bot Thinking...',
    defaultResponseMessage: "Sorry! I didn't catch that!\nPlease try again!",
    keywords: ['hello', 'hi', 'how are you',],
    response: [
      'Hi\nHow can I assist you today?',
      'Hello!\nHow can I be of help?',
      'I am doing great!',

    ],
    greetings: "Hi there👋🏾\nHow can I help you?",
    headerText: 'Iksoft Technologies',
    subHeaderText: 'Online',
    profileImage: 'profileImage',
    buttonText: 'Start Chat',
    buttonColor: const Color.fromARGB(255, 73, 4, 4),
    chatIcon: const Icon(Icons.person),
    headerColor: const Color.fromARGB(255, 73, 4, 4),
    message: 'Hello! This is a direct WhatsApp message.',
    phoneNumber: '+233550138086',
    chatBackgroundColor: const Color.fromARGB(255, 238, 231, 223),
    onlineIndicator: const Color.fromARGB(255, 37, 211, 102),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: [
            WhatsappChatBot(
              settings: config,
            )
          ],
        ));
  }
}
