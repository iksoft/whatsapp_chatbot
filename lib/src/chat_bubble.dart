import 'package:flutter/material.dart';
import 'package:whatsapp_chatbot/whatsapp_chatbot.dart';

class ChatMessage extends StatefulWidget {
  final Config? settings;
  final String messageText;
  final bool isUser;
  final DateTime messageTime;
  final Widget? additionalWidget; // Added additionalWidget

  ChatMessage({
    this.settings,
    required this.isUser,
    required this.messageText,
    required this.messageTime,
    this.additionalWidget, // Made additionalWidget nullable
  });

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                widget.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!widget.isUser)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: widget.settings?.headerColor,
                    radius: 20.0,
                    child: const Icon(Icons.person),
                  ),
                ),
              Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: widget.isUser
                          ? const Color.fromARGB(255, 222, 246, 202)
                          : const Color.fromARGB(255, 252, 250, 250),
                      borderRadius: widget.isUser
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                    ),
                    child: Column(
                      crossAxisAlignment: widget.isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisAlignment: widget.isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.messageText,
                            style: widget.isUser
                                ? const TextStyle(color: Colors.black)
                                : const TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${widget.messageTime.hour}:${widget.messageTime.minute}:${widget.messageTime.second}",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10.0),
                          ),
                        ),
                        if (widget.additionalWidget !=
                            null) // Display additional widget if available
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: widget.additionalWidget,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.isUser)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 7, 94, 84),
                    radius: 20.0,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
