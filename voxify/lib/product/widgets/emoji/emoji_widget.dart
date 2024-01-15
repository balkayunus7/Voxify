import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:voxify/product/enums/widget_sizes.dart';
import '../../constants/color_constants.dart';

class EmojiWidget extends StatefulWidget {
  final Function addEmojiController;
  const EmojiWidget({super.key, required this.addEmojiController});
  @override
  State<EmojiWidget> createState() => _EmojiWidgetState();
}

@override
class _EmojiWidgetState extends State<EmojiWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Container(
          height: context.general.mediaQuery.size.height * 0.4,
          decoration: BoxDecoration(
              color: ColorConstants.primaryGreenDark.withOpacity(0.2),
              borderRadius: WidgetSizeConstants.borderRadiusNormal),
          child: EmojiPicker(
            onEmojiSelected: (Category? category, Emoji emoji) {
              widget.addEmojiController(emoji.emoji);
            },
            onBackspacePressed: () {},
            config: Config(
              columns: 7,
              emojiSizeMax: 32 *
                  (foundation.defaultTargetPlatform != TargetPlatform.iOS
                      ? 1.30
                      : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.SMILEYS,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ), // Needs to be const Widget
              loadingIndicator:
                  const SizedBox.shrink(), // Needs to be const Widget
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
            ),
          )),
    );
  }
}
