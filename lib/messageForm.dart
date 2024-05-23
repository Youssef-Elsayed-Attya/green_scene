import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_scene/resources/app_colors.dart';

class MessageForm extends StatefulWidget {
  MessageForm({this.sender, required this.text, required this.currentUser});

  final String? sender;
  final String text;
  final bool currentUser;

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  bool play = false;

  // speak() async {
  //   //this.widget.piece.summary;
  //   flutterTts.setLanguage('en');
  //   flutterTts.setPitch(1); // 0.5:1.5
  //   flutterTts.setSpeechRate(0.4);
  //   play ? flutterTts.speak(widget.text) : flutterTts.pause();
  //
  // }
  // final FlutterTts flutterTts = FlutterTts();
  //
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   flutterTts.stop();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: widget.currentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Material(
              elevation: 5,
              borderRadius: widget.currentUser
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: widget.currentUser ? AppColors.green : Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  '${widget.text} ',
                  style: TextStyle(
                      fontSize: 16,
                      color: widget.currentUser ? Colors.white : Colors.black),
                ),
              )),
          widget.currentUser
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                )
        ],
      ),
    );
  }
}
