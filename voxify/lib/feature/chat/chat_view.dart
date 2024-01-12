import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/chat/providers/chat_notifier.dart';
import 'package:voxify/product/constants/string_constants.dart';
import 'package:voxify/product/widgets/appbar/custom_appbar.dart';

final _chatNotifier = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage(
      {required this.receiverEmail, required this.receiverId, super.key});
  final String receiverEmail;
  final String receiverId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatNotifier chatNotifier = ChatNotifier();
  @override
  void initState() {
    super.initState();
    getMessages();
  }

  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      ref
          .read(_chatNotifier.notifier)
          .sendMessage(widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  Future<void> getMessages() async {
    ref.read(_chatNotifier.notifier).getMessages(
        chatNotifier.currentUserId, widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.receiverEmail,
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: const SizedBox.shrink(), onPressed: () {
        context.route.pop();
      }),
      body: Column(
        children: [
          const _MessageUserList(),
          Padding(
            padding: context.padding.normal,
            child: Column(
              children: [
                TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: StringConstants.chatMessage,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage().then((value) => getMessages());
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _MessageUserList extends ConsumerWidget {
  const _MessageUserList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(_chatNotifier).message;
    if (message == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Expanded(
      child: ListView.builder(
          itemCount: message.length,
          itemBuilder: (context, index) {
            final state = message[index];
            return Padding(
              padding: context.padding.normal,
              child: ListTile(
                title: Text(state.message.toString()),
                subtitle: Text(state.senderEmail.toString()),
              ),
            );
          }),
    );
  }
}
