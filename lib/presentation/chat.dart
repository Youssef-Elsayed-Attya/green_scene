import 'package:flutter/material.dart';
import 'package:green_scene/chatGpt.dart';
import 'package:green_scene/messageForm.dart';
import 'package:green_scene/resources/app_colors.dart';
import 'package:lottie/lottie.dart';


bool play = false;
bool chatting = false;
bool waiting=false;

List allMessages = [

];

class ChatGpt extends StatefulWidget {
  ChatGpt({super.key});

  @override
  State<ChatGpt> createState() => _ChatGptState();
}

class _ChatGptState extends State<ChatGpt> {
  TextEditingController Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          MessageStreamBuilder(),
          waiting? Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Material(
                    elevation: 5,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Lottie.asset('assets/icons/threeDots.json',repeat: true,height: 30),
                    )),
              ],
            ),
          ):Container(
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            width: double.infinity,
            color: Colors.transparent,
            child: TextFormField(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      String msg=Controller.text;
                      Controller.clear();
                      allMessages.add({
                        'sender': 'user',
                        'content': msg
                      });
                      waiting=true;
                      setState(() {});
                      var aiResponse = await GPT(
                          text: msg,)
                          .chatGpt();
                      allMessages.add({
                        'sender': 'ai',
                        'content': aiResponse
                      });
                      setState(() {
                        waiting =false;
                      });
                    },
                    icon: Icon(
                      Icons.send,
                      color: AppColors.lightGreen,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey.shade600,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(25))),
              controller: Controller,
            ),
          ),
        ],
      ),
    );
  }
}


class MessageStreamBuilder extends StatelessWidget {
  List<Widget> messageWidgets = [];

  @override
  Widget build(BuildContext context) {
    for (var m in allMessages.reversed) {
      final messageSender = m['sender'];
      final messageContent = m['content'];
      final mesasgeWidget = MessageForm(
        sender: messageSender,
        text: messageContent,
        currentUser: messageSender == 'user',
      );
      messageWidgets.add(mesasgeWidget);
    }
    return Expanded(
      child: ListView(
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: messageWidgets,
      ),
    );
  }
}
