// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voxify/product/utilites/firebase/firebase_collections.dart';
import '../../../product/models/messages.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get currentUserId => _auth.currentUser!.uid;

  Future<void> deleteMessageFromFirestore(
      Messages message, String receiverId) async {
    List<String> userIds = [currentUserId, receiverId];
    userIds.sort();
    String chatRoomId = userIds.join('_');

    // Reference to the message in Firestore
    final messageReference = _firestore
        .collection(FirebaseCollections.chat_rooms.name)
        .doc(chatRoomId)
        .collection(FirebaseCollections.messages.name)
        .where('messageId', isEqualTo: message.messageId);

    // Get the document reference
    final documentSnapshot = await messageReference.get();

    // Check if the document exists
    if (documentSnapshot.docs.isNotEmpty) {
      // Delete the message
      await _firestore
          .collection(FirebaseCollections.chat_rooms.name)
          .doc(chatRoomId)
          .collection(FirebaseCollections.messages.name)
          .doc(documentSnapshot.docs.first.id)
          .delete();
    }
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // construct chat room id from sender and receiver id
    List<String> userIds = [currentUserId, receiverId];
    userIds.sort();
    String chatRoomId = userIds.join('_');

    // add message to firestore
    await _firestore
        .collection(FirebaseCollections.chat_rooms.name)
        .doc(chatRoomId)
        .collection(FirebaseCollections.messages.name)
        .add(Messages(
          senderId: currentUserId,
          senderEmail: currentUserEmail,
          message: message,
          receiverId: receiverId,
          timestamp: timestamp,
        ).toJson());
  }

  Future<void> getMessages(String userId, String otherUserId) async {
    // construct chat room id from sender and receiver id
    List<String> userIds = [userId, otherUserId];
    userIds.sort();
    String chatRoomId = userIds.join('_');
    // get chat room
    final chatDocument = _firestore
        .collection(FirebaseCollections.chat_rooms.name)
        .doc(chatRoomId);
    // get messages order by timestamp
    final chatCollection = chatDocument
        .collection(FirebaseCollections.messages.name)
        .orderBy(FirebaseCollections.timestamp.name, descending: false);
    // get ChatRoom query snapshot
    final QuerySnapshot querySnapshot = await chatCollection.get();
    // if query snapshot is not empty then get messages and convert to list
    if (querySnapshot.docs.isNotEmpty) {
      List<Messages>? messageList = querySnapshot.docs.map((e) {
        final data = e.data() as Map<String, dynamic>;
        return Messages().fromJson(data);
      }).toList();
      // update state
      state = state.copyWith(message: messageList);
    }
    return;
  }
}

class ChatState extends Equatable {
  const ChatState({this.message, this.selectedMessage});

  final List<Messages>? message;
  final Messages? selectedMessage;

  @override
  List<Object?> get props => [message, selectedMessage];

  ChatState copyWith({
    List<Messages>? message,
    Messages? selectedMessage,
  }) {
    return ChatState(
      message: message ?? this.message,
      selectedMessage: selectedMessage ?? this.selectedMessage,
    );
  }
}
