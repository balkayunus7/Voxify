import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/feature/chat/providers/chat_notifier.dart';
import 'package:voxify/product/constants/color_constants.dart';
import 'package:voxify/product/constants/string_constants.dart';
import 'package:voxify/product/widgets/appbar/custom_appbar.dart';
import 'package:voxify/product/widgets/texts/subtitle_text.dart';

final chatNotifier = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
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

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      ref
          .read(chatNotifier.notifier)
          .sendMessage(widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  Future<void> getMessages() async {
    ref.read(chatNotifier.notifier).getMessages(
        ref.read(chatNotifier.notifier).currentUserId, widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.receiverEmail,
          icon: Icons.arrow_back_ios,
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: const SizedBox.shrink(), onPressed: () {
        context.route.pop();
      }),
      body: Column(
        children: [
          const _MessageUserList(),
          Padding(
            padding: context.padding.onlyBottomNormal.copyWith(left: 15),
            child: Row(
              children: [
                _MessageTextform(messageController: _messageController),
                IconButtons(
                    icon: Icons.send,
                    onPressed: () {
                      sendMessage().then((value) => getMessages());
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IconButtons extends StatelessWidget {
  const IconButtons({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: ColorConstants.primaryGreenDark,
        onPressed: onPressed,
        icon: Icon(icon));
  }
}

class _MessageTextform extends StatelessWidget {
  const _MessageTextform({
    required TextEditingController messageController,
  }) : _messageController = messageController;

  final TextEditingController _messageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sized.dynamicWidth(0.8),
      decoration: BoxDecoration(
          color: ColorConstants.primaryGreenDark.withOpacity(0.2),
          borderRadius: BorderRadius.circular(17)),
      child: TextFormField(
        controller: _messageController,
        autocorrect: true,
        decoration: const InputDecoration(
          hintText: StringConstants.chatMessage,
          prefixIcon: Icon(Icons.emoji_emotions_outlined),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.attach_file),
        ),
      ),
    );
  }
}

class _MessageUserList extends ConsumerWidget {
  const _MessageUserList();
  String formatTimestamp(DateTime timestamp) {
    String formattedDateTime = DateFormat('HH:mm').format(timestamp);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageList = ref.watch(chatNotifier).message;
    String? previousSenderEmail; // Yeni eklenen satır
    if (messageList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Expanded(
      child: ListView.builder(
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            final state = messageList[index];
            bool isCurrentUser =
                state.senderId == ref.read(chatNotifier.notifier).currentUserId;
            String formattedDateTime =
                formatTimestamp(state.timestamp!.toDate());
            bool showEmail = previousSenderEmail != state.senderEmail;
            if (showEmail) {
              previousSenderEmail = state.senderEmail;
            }
            return Padding(
              padding: context.padding.horizontalNormal.copyWith(bottom: 10),
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (showEmail)
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: SubtitleText(
                          subtitle: messageList[index].senderEmail.toString(),
                          color: isCurrentUser
                              ? ColorConstants.primaryGreenDark.withOpacity(0.8)
                              : ColorConstants.primaryGrey),
                    ),
                  Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? ColorConstants.primaryGreenDark.withOpacity(0.2)
                              : ColorConstants.primaryGrey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: context.padding.horizontalNormal
                              .copyWith(top: 7, bottom: 7),
                          child: SubtitleText(
                              subtitle: state.message.toString(),
                              color: ColorConstants.primaryDark),
                        ),
                      ),
                      Padding(
                        padding: context.padding.onlyLeftHigh,
                        child: Text(
                          formattedDateTime,
                          style: GoogleFonts.lato(
                              color: ColorConstants.primaryGrey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
