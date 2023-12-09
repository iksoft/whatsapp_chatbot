import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_chatbot/src/chat_bubble.dart';
import 'package:whatsapp_chatbot/src/config.dart';

class WhatsappChatBot extends StatefulWidget {
  final Config settings;

  const WhatsappChatBot({Key? key, required this.settings}) : super(key: key);

  @override
  State<WhatsappChatBot> createState() => _WhatsappChatBotState();
}

class _WhatsappChatBotState extends State<WhatsappChatBot> {
  late TextEditingController userText = TextEditingController();
  late bool isVisible = false;
  late bool isChat = true;
  late bool isChat2 = false;
  late bool _isWaitingForUserResponse = true;

  final List<ChatMessage> _message = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _message.add(ChatMessage(
      isUser: false,
      messageText: widget.settings.greetings,
      messageTime: DateTime.now(),
    ));

    // Add buttons as a separate list of messages
    _addButtonsMessages();
  }

  void _sendMessage() async {
    final url =
        'https://wa.me/${widget.settings.phoneNumber}/?text=${Uri.encodeFull(widget.settings.message)}';

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  void _addButtonsMessages() {
    // Add each button as a separate message in the list
    _message.add(ChatMessage(
      isUser: false,
      messageText: "Quick Actions",
      messageTime: DateTime.now(),
      additionalWidget: SizedBox(
        height: 50,
        width: 200,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  _sendMessage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.settings.buttonColor,
                      borderRadius: BorderRadius.circular(30.0)),
                  width: 100,
                  height: 50,
                  child: const Center(
                      child: Text(
                    "Live Chat",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _startTypingAnimation(String reply) {
    final typingMessage = ChatMessage(
      isUser: false,
      messageText: widget.settings.waitText,
      messageTime: DateTime.now(),
    );

    setState(() {
      _message.add(typingMessage);
      widget.settings.subHeaderText = "Typing...";
    });

    Future.delayed(Duration(seconds: widget.settings.botDelay), () {
      _message.remove(typingMessage);
      widget.settings.subHeaderText = "Online";
      _addBotMessage(reply);
    });
  }

  void _addBotMessage(String text) {
    final botMessage = ChatMessage(
      isUser: false,
      messageText: text,
      messageTime: DateTime.now(),
    );

    setState(() {
      _message.add(botMessage);
    });
  }

  int _findMatchingKeyword(String response) {
    for (int i = 0; i < widget.settings.keywords.length; i++) {
      if (response.contains(widget.settings.keywords[i])) {
        return i;
      }
    }
    return -1;
  }

  void _handleSubmitted(String text) {
    _handleUserResponse(text);
  }

  void _handleUserResponse(String response) {
    final lowerCaseResponse = response.trim().toLowerCase();

    late String reply;
    late String userSelectedOption;
    final int index = _findMatchingKeyword(lowerCaseResponse);

    if (index != -1) {
      userSelectedOption = response;
      reply = widget.settings.response[index];
    } else {
      userSelectedOption = response;
      reply = widget.settings.defaultResponseMessage;
    }

    setState(() {
      _message.add(ChatMessage(
        isUser: true,
        messageText: userSelectedOption,
        messageTime: DateTime.now(),
      ));
      userText.clear();
    });
    if (reply.isNotEmpty) {
      _isWaitingForUserResponse = false;
      _startTypingAnimation(reply);
    }
  }

  void _addSuggestions(List<String> suggestions) {
    List<Widget> suggestionButtons = [];
    suggestions.forEach((suggestion) {
      suggestionButtons.add(
        ElevatedButton(
          onPressed: () {
            setState(() {
              _handleSubmitted(suggestion);
            });
          },
          child: Text(suggestion),
        ),
      );
    });

    setState(() {
      _message.add(
        ChatMessage(
          isUser: false,
          messageText: 'Please select an option:',
          messageTime: DateTime.now(),
        ),
      );
      _message.add(
        ChatMessage(
          isUser: false,
          messageText: '',
          messageTime: DateTime.now(),
          additionalWidget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: suggestionButtons,
          ),
        ),
      );
    });
  }

  void _makePhoneCall(String phoneNumber) async {
    String number = 'tel:$phoneNumber';
    var uri = Uri.parse(number);
    try {
      if (await canLaunchUrl(uri)) {
        await launch(uri.toString());
      } else {
        throw 'Could not Launch the call number $number';
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Widget positioned at the bottom right
        Positioned(
          bottom: 100,
          right: 20,
          child: Visibility(
            visible: isVisible,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              width: 350,
              height: 500,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: widget.settings.headerColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Center(
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.robot,
                              color: Colors.white,
                              size: 40,
                            ),
                           
                          ),
                          title: Text(
                            widget.settings.headerText,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  color: widget.settings.onlineIndicator,
                                ),
                              ),
                              Text(
                                widget.settings.subHeaderText,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _makePhoneCall(widget.settings.phoneNumber);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                          color: widget.settings.chatBackgroundColor,
                          child: ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            itemCount: _message.length,
                            itemBuilder: (_, int index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _message.reversed.toList()[index],
                            ),
                          ))),
                  Visibility(
                    visible: isChat,
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: FloatingActionButton.extended(
                                elevation: 0,
                                backgroundColor: widget.settings.buttonColor,
                                onPressed: () {
                                  setState(() {
                                    isChat = !isChat;
                                    isChat2 = !isChat2;
                                  });
                                },
                                label: Text(
                                  widget.settings.buttonText,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isChat2,
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                children: [
                                  TextField(
                                    onChanged: (text) {
                                      if (!_isWaitingForUserResponse) {
                                        _isWaitingForUserResponse = true;
                                      }
                                    },
                                    controller: userText,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Message',
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.send),
                                          onPressed: () {
                                            setState(() {
                                              _handleSubmitted(userText.text);
                                            });
                                          },
                                        ),
                                        border: InputBorder.none),
                                  ),
                                  const Center(
                                    child: Text(
                                      'Powered by afrilen.com',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Widget for FloatingActionButton
        Positioned(
          bottom: 30,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: isVisible
                ? const Color.fromARGB(255, 107, 3, 3)
                : const Color.fromARGB(255, 37, 211, 102),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: isVisible
                ? const Icon(
                    Icons.close,
                    color: Colors.white,
                  )
                : const Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }
}
