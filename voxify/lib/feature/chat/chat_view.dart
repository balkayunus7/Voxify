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
import 'package:voxify/product/models/messages.dart';
import 'package:voxify/product/widgets/appbar/custom_appbar.dart';
import 'package:voxify/product/widgets/appbar/custom_sizedbox_shrink.dart';
import 'package:voxify/product/widgets/texts/subtitle_text.dart';
import '../../product/widgets/appbar/custom_icon.dart';
import 'mixin/chat_view_mixin.dart';

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

class _ChatPageState extends ConsumerState<ChatPage> with ChatViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.receiverEmail,
          icon: Icons.arrow_back_ios,
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: const SizedBoxShrink(), onPressed: () {
        context.route.pop();
      }),
      body: Column(
        children: [
          _MessageUserList(getMessages),
          Padding(
            padding: context.padding.onlyBottomNormal.copyWith(left: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    _MessageTextform(
                      messageController: messageController,
                    ),
                    IconButtons(
                      icon: Icons.send,
                      onPressed: sendAndThenGetMessages,
                    ),
                  ],
                ),
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
  const _MessageTextform({
    required TextEditingController messageController,
  }) : _messageController = messageController;

  final TextEditingController _messageController;

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
        decoration: const InputDecoration(
          hintText: StringConstants.chatMessage,
          border: InputBorder.none,
          suffixIcon: Icon(Icons.attach_file),
        ),
      ),
    );
  }
}

class _MessageUserList extends ConsumerStatefulWidget {
  final VoidCallback getMessages;
  const _MessageUserList(this.getMessages);

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
          shrinkWrap: true,
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
              padding: context.padding.horizontalNormal.copyWith(bottom: 3),
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
                      GestureDetector(
                        onLongPress: () {
                          showDialogDelete(context, state);
                        },
                        child: messageContainer(isCurrentUser, context, state),
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

  Container messageContainer(
      bool isCurrentUser, BuildContext context, Messages state) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? ColorConstants.primaryGreenDark.withOpacity(0.2)
            : ColorConstants.primaryGrey.withOpacity(0.2),
        borderRadius: WidgetSizeConstants.borderRadiusNormal,
      ),
      child: Padding(
        padding: context.padding.horizontalNormal.copyWith(top: 7, bottom: 7),
        child: SubtitleText(
            subtitle: state.message.toString(),
            color: ColorConstants.primaryDark),
      ),
    );
  }

  Future<dynamic> showDialogDelete(BuildContext context, Messages state) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Message'),
            content:
                const Text('Are you sure you want to delete this message?'),
            actions: [
              TextButton(
                  onPressed: () {
                    context.route.pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    ref
                        .watch(chatNotifier.notifier)
                        .deleteMessageFromFirestore(state, state.receiverId!)
                        .then((value) => context.route
                            .pop()
                            .then((value) => widget.getMessages()));
                  },
                  child: const Text('Delete')),
            ],
          );
        });
  }
}
