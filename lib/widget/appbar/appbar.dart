import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class CostumeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? costumeTitle;
  final String? profileTitle;
  final Function? onDelete;
  final bool? back, dense, isDelete;
  final Icon? icon;
  final Function? onBack;

  const CostumeAppBar({
    Key? key,
    required this.title,
    this.back,
    this.icon,
    this.dense = false,
    this.profileTitle,
    this.onDelete,
    this.costumeTitle,
    this.onBack,
    this.isDelete = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      leading: back != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: ColorSty.primary),
              onPressed: () {
                if (onBack != null) {
                  onBack!();
                }
                Navigator.of(context).pop();
              },
            )
          : null,
      actions: [
        if (isDelete!)
          Padding(
            padding:
                const EdgeInsets.only(right: SpaceDims.sp2, top: SpaceDims.sp4),
            child: IconButton(
              onPressed: () {
                onDelete!();
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
          )
      ],
      title: costumeTitle ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: SpaceDims.sp8),
                if (dense ?? false) const SizedBox(width: SpaceDims.sp12),
              ],
              // if (icon != null) const SizedBox(width: SpaceDims.sp46 + 3),
              if (title!.isNotEmpty)
                AutoSizeText(
                  ' $title',
                  maxLines: 1,
                  style: TypoSty.title,
                  textAlign: TextAlign.center,
                  minFontSize: 0,
                  stepGranularity: 0.1,
                ),
              if (profileTitle != null)
                Column(
                  children: [
                    AutoSizeText(
                      profileTitle!,
                      maxLines: 1,
                      style: TypoSty.title.copyWith(color: ColorSty.primary),
                      textAlign: TextAlign.center,
                      minFontSize: 0,
                      stepGranularity: 0.1,
                    ),
                    const SizedBox(height: SpaceDims.sp2),
                    Container(
                      width: 55,
                      height: 2,
                      color: ColorSty.primary,
                    )
                  ],
                ),
              if (!isDelete! && back != null) ...[
                const SizedBox(width: SpaceDims.sp32),
                const SizedBox(width: SpaceDims.sp24),
              ],
            ],
          ),
    );
  }
}
