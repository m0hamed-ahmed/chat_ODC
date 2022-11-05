import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String name;
  final String text;
  final DateTime time;

  MessageModel({
    required this.name,
    required this.text,
    required this.time,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      name: json['name'],
      text: json['text'],
      time: (json['time'] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> toMap(MessageModel messageModel) {
    return {
      'name': messageModel.name,
      'text': messageModel.text,
      'time': messageModel.time,
    };
  }
}