import 'package:flutter/material.dart';

class Config {
  final List<String> keywords;
  final List<String> response;
  final greetings;
  final headerText;
  String subHeaderText;
  final profileImage;
  final buttonText;
  final chatIcon;
  final headerColor;
  final buttonColor;
  final phoneNumber;
  final message;
  final defaultResponseMessage;
  final waitText;
  final int botDelay;
  final onlineIndicator;
  final chatBackgroundColor;

  Config({
    required this.chatBackgroundColor,
    required this.onlineIndicator,
    required this.botDelay,
    required this.waitText,
    required this.defaultResponseMessage,
    required this.keywords,
    required this.response,
    required this.greetings,
    required this.headerText,
    required this.subHeaderText,
    required this.profileImage,
    required this.buttonText,
    required this.buttonColor,
    required this.chatIcon,
    required this.headerColor,
    required this.message,
    required this.phoneNumber,
  });
}
