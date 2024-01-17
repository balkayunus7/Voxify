import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../chat_view.dart';

mixin ChatViewMixin on ConsumerState<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> sendAndThenGetMessages() {
    return sendMessage().then((value) => getMessages());
  }

  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      ref
          .read(chatNotifier.notifier)
          .sendMessage(widget.receiverId, messageController.text);
      messageController.clear();
    }
  }

  Future<void> getMessages() async {
    ref.read(chatNotifier.notifier).getMessages(
        ref.read(chatNotifier.notifier).currentUserId, widget.receiverId);
  }
}
