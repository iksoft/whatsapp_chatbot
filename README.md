<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

ikChatBot Flutter Package

The ikChatBot Flutter package provides an easy way to integrate a customizable chatbot into your Flutter applications. This package allows you to quickly add a chat interface with interactive responses and user-friendly configuration options. With ikChatBot, you can enhance user engagement and provide automated assistance through a chat-based interface.


## Features
![thumbnail](https://github.com/iksoft/whatsapp_chatbot/assets/62053085/c4410320-3c44-4a7b-9404-7ef9a03e2410)

[//]: # (<div align="center">)

[//]: # (    <img src="https://github.com/iksoft/ikchatbot/assets/62053085/3651c184-d70b-432a-a387-25a87b7128cd" alt="Screenshot 1" width="200"/>)

[//]: # (    <img src="https://github.com/iksoft/ikchatbot/assets/62053085/62039c04-c9ec-4264-b9ef-97d2aac7d502" alt="Screenshot 2" width="200"/>)

[//]: # (    <img src="https://github.com/iksoft/ikchatbot/assets/62053085/8d675799-4fe0-4ff0-b6f6-7dadf64e0502" alt="Screenshot 2" width="200"/>)

[//]: # (    <img src="https://github.com/iksoft/ikchatbot/assets/62053085/6a598e63-091d-433e-982e-42cb8561c9ee" alt="Screenshot 2" width="200"/>)

[//]: # (   )
[//]: # (</div>)


## Getting started

# whatsapp_chatbot Package

The `whatsapp_chatbot` package provides a customizable chatbot widget for Flutter applications. This widget allows you to easily integrate a chatbot into your app with various customization options.

## Features

- Customizable chatbot appearance
- Customizable chat bubble colors
- Initial greeting and default responses
- Placeholder for user input
- Easy integration into Flutter apps
- Use Bot typing.. features
- Make direct calls
- Chat directly on whatsapp


Whether you're building a customer support app or just looking to add some interactivity to your application, ikChatBot can help you create a dynamic chatbot experience tailored to your needs.

## Getting Started

To use this package, add `whatsapp_chatbot` to your `pubspec.yaml` file:

```yaml
dependencies:
  ikchatbot: ^0.0.1
```
Import the package to your screen
```yaml
import 'package:whatsapp_chatbot/whatsapp_chatbot.dart';
```
Copy and Paste this function to use the features of the plugin
```yaml
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
```

Full Example on how to use this plugin
```yaml
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

```

## Additional information

To find more information, check out the package documentation.

Contributions are welcome! If you'd like to contribute to this package, please submit issues or pull requests on GitHub.


If you encounter any issues or need support, feel free to file issues on GitHub or contact us at aduamahdaniel16@gmail.com.

Our team will do their best to respond promptly to issues and inquiries.
