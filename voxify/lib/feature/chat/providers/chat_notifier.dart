// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../product/models/messages.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get current user info
  String get currentUserId => _auth.currentUser!.uid;
  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // construct chat room id from sender and receiver id
    List<String> userIds = [currentUserId, receiverId];
    userIds.sort();
    String chatRoomId = userIds.join('_');

    // add message to firestore
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(Messages(
          senderId: currentUserId,
          senderEmail: currentUserEmail,
          message: message,
          receiverId: receiverId,
          timestamp: timestamp,
        ).toJson());
  }

// get messages
  Future<void> getMessages(String userId, String otherUserId) async {
    List<String> userIds = [userId, otherUserId];
    userIds.sort();
    String chatRoomId = userIds.join('_');
    final chatDocument = _firestore.collection('chat_rooms').doc(chatRoomId);
    final chatCollection = chatDocument
        .collection('messages').orderBy("timestamp",descending: false);
    final QuerySnapshot querySnapshot = await chatCollection.get();

    if (querySnapshot.docs.isNotEmpty) {
      List<Messages>? messageList = querySnapshot.docs.map((e) {
        final data = e.data() as Map<String, dynamic>;
        return Messages().fromJson(data);
      }).toList();
      state = state.copyWith(message: messageList);
    }
    return;
  }
}

class ChatState extends Equatable {
  const ChatState({this.message});

  final List<Messages>? message;

  @override
  List<Object?> get props => [message];

  ChatState copyWith({
    List<Messages>? message,
  }) {
    return ChatState(
      message: message ?? this.message,
    );
  }
}
