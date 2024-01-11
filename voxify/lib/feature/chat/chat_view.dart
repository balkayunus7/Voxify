import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/chat/cubits/chat_cubit.dart';
import 'package:voxify/product/widgets/appbar/custom_appbar.dart';
import '../../product/models/messages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.receiverEmail, required this.receiverId});
  final String receiverEmail;
  final String receiverId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatCubit _chatCubit = ChatCubit();

  Future<void> sendMessages() async {
    if (_messageController.text.isNotEmpty) {
      await _chatCubit.sendMessage(widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.receiverEmail,
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: const SizedBox.shrink(), onPressed: () {
        context.route.pop();
      }),
      body: BlocProvider(
        create: (context) => ChatCubit(),
        child: Column(
          children: [
            MessageUserList(
              receiverEmail: widget.receiverEmail,
              receiverId: widget.receiverId,
            ),
            Padding(
              padding: context.padding.normal,
              child: Column(
                children: [
                  TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Message',
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        sendMessages();
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageUserList extends ChatPage {
  // ignore: prefer_const_constructors_in_immutables
  MessageUserList({
    super.key,
    required super.receiverEmail,
    required super.receiverId,
  });

  @override
  State<MessageUserList> createState() => _MessageUserListState();
}

class _MessageUserListState extends State<MessageUserList> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getMessages(
        context.read<ChatCubit>().currentUserId, widget.receiverId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ChatCubit>().getMessages(
        context.read<ChatCubit>().currentUserId, widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatCubit, ChatState, List<Messages>?>(
      selector: (state) {
        return state.message ?? [];
      },
      builder: (context, state) {
        if (state!.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Expanded(
          child: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state[index].senderEmail.toString()),
                  subtitle: Text(state[index].message.toString()),
                );
              }),
        );
      },
    );
  }
}
