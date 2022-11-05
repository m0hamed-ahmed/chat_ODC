import 'package:chatodc/message_item.dart';
import 'package:chatodc/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  TextEditingController textEditingControllerMessage = TextEditingController();
  final String myName = 'Mohamed Ahmed';

  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.green),
        backgroundColor: Colors.green,
        title: const Text('Chat ODC'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection('chat').orderBy('time', descending: false).snapshots(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map = snapshot.data!.docs[index].data();
                      if(map['name'] != null &&
                          map['text'] != null &&
                          map['time'] != null &&
                          map['name'] != '' &&
                          map['text'] != '' &&
                          map['time'] != '' &&
                          map['time'].runtimeType == Timestamp
                      ) {
                        return MessageItem(messageModel: MessageModel.fromJson(map));
                      }
                      else {
                        return const SizedBox();
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                    itemCount: snapshot.data!.docs.length // messageModelList.length,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textEditingControllerMessage,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message here ...',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10)
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.mic),
                      ),
                      Container(
                        color: Colors.green,
                        child: MaterialButton(
                          onPressed:  () async {
                            addDocument();
                            textEditingControllerMessage.clear();
                          },
                          minWidth: 1,
                          child: const Icon(Icons.send, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  addDocument() async {
    Map<String, dynamic> map = {
      'name': myName,
      'text': textEditingControllerMessage.text,
      'time': Timestamp.fromDate(DateTime.now()),
    };
    await FirebaseFirestore.instance.collection('chat').add(map);
  }
}