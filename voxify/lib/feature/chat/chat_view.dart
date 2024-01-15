import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:voxify/feature/chat/providers/chat_notifier.dart';
import 'package:voxify/product/constants/color_constants.dart';
import 'package:voxify/product/constants/string_constants.dart';
import 'package:voxify/product/enums/widget_sizes.dart';
import 'package:voxify/product/widgets/appbar/custom_appbar.dart';
import 'package:voxify/product/widgets/texts/subtitle_text.dart';
import '../../product/widgets/appbar/custom_icon.dart';
import '../../product/widgets/emoji/emoji_widget.dart';

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
  bool isEmojiVisible = true;
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
            child: Column(
              children: [
                Row(
                  children: [
                    _MessageTextform(
                      messageController: _messageController,
                      isEmojiVisible: isEmojiVisible,
                      toggleEmojiVisibility: () {
                        setState(() {
                          isEmojiVisible = !isEmojiVisible;
                        });
                      },
                    ),
                    IconButtons(
                        icon: Icons.send,
                        onPressed: () {
                          sendMessage().then((value) => getMessages());
                        }),
                  ],
                ),
                if (isEmojiVisible)
                  EmojiWidget(addEmojiController: (emoji) {
                    _messageController.text += emoji;
                  }),
              ],
            ),
          )
        ],
      ),
    );
  }
}



// ignore: must_be_immutable
class _MessageTextform extends StatefulWidget {
  _MessageTextform({
    required TextEditingController messageController,
    required this.isEmojiVisible,
    required this.toggleEmojiVisibility,
  }) : _messageController = messageController;

  bool isEmojiVisible;
  final TextEditingController _messageController;
  final VoidCallback toggleEmojiVisibility;

  @override
  State<_MessageTextform> createState() => _MessageTextformState();
}

class _MessageTextformState extends State<_MessageTextform> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sized.dynamicWidth(0.8),
      decoration: BoxDecoration(
          color: ColorConstants.primaryGreenDark.withOpacity(0.2),
          borderRadius: WidgetSizeConstants.borderRadiusNormal),
      child: TextFormField(
        controller: widget._messageController,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: StringConstants.chatMessage,
          prefixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  widget.toggleEmojiVisibility();
                });
              },
              child: Icon(widget.isEmojiVisible
                  ? Icons.keyboard
                  : Icons.emoji_emotions_outlined)),
          border: InputBorder.none,
          suffixIcon: const Icon(Icons.attach_file),
        ),
      ),
    );
  }
}

class _MessageUserList extends ConsumerStatefulWidget {
  const _MessageUserList();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __MessageUserListState();
}

class __MessageUserListState extends ConsumerState<_MessageUserList> {
  String formatTimestamp(DateTime timestamp) {
    String formattedDateTime = DateFormat('HH:mm').format(timestamp);
    return formattedDateTime;
  }

  final ItemScrollController scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final messageList = ref.watch(chatNotifier).message;
    String? previousSenderEmail;
    if (messageList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Expanded(
      child: ScrollablePositionedList.builder(
          itemScrollController: scrollController,
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            final state = messageList[index];
            bool isCurrentUser = state.senderId ==
                ref.watch(chatNotifier.notifier).currentUserId;
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
                    // Email Text
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: SubtitleText(
                          subtitle: state.senderEmail.toString(),
                          color: isCurrentUser
                              ? ColorConstants.primaryGreenDark.withOpacity(0.8)
                              : ColorConstants.primaryGrey),
                    ),
                  Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      // Message Text
                      Container(
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? ColorConstants.primaryGreenDark.withOpacity(0.2)
                              : ColorConstants.primaryGrey.withOpacity(0.2),
                          borderRadius: WidgetSizeConstants.borderRadiusNormal,
                        ),
                        child: Padding(
                          padding: context.padding.horizontalNormal
                              .copyWith(top: 7, bottom: 7),
                          child: SubtitleText(
                              subtitle: state.message.toString(),
                              color: ColorConstants.primaryDark),
                        ),
                      ),
                      // Time Text
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
