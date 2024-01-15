import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../utilites/firebase/base_firebase_model.dart';

class Messages with EquatableMixin, BaseFirebaseModel<Messages>, IDModel {
  Messages({
    this.senderId,
    this.senderEmail,
    this.message,
    this.receiverId,
    this.timestamp,
    this.messageId,
  });

  final String? messageId;
  final String? senderId;
  final String? senderEmail;
  final String? message;
  final String? receiverId;
  final Timestamp? timestamp;

  @override
  List<Object?> get props =>
      [timestamp, senderEmail, senderId, message, receiverId, messageId];

  Messages copyWith({
    String? messageId,
    Timestamp? timestamp,
    String? senderEmail,
    String? senderId,
    String? message,
    String? receiverId,
  }) {
    return Messages(
      timestamp: timestamp ?? this.timestamp,
      messageId: messageId ?? this.messageId,
      receiverId: receiverId ?? this.receiverId,
      senderEmail: senderEmail ?? this.senderEmail,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'messageId': messageId,
      'senderEmail': senderEmail,
      'senderId': senderId,
      'message': message,
      'receiverId': receiverId,
    };
  }

  @override
  Messages fromJson(Map<String, dynamic> json) {
    return Messages(
      messageId: json['messageId'] as String?,
      timestamp: json['timestamp'] as Timestamp?,
      message: json['message'] as String?,
      receiverId: json['receiverId'] as String?,
      senderEmail: json['senderEmail'] as String?,
      senderId: json['senderId'] as String?,
    );
  }
}
