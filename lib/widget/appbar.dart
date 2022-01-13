

import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class CostumeAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final String? profileTitle;
  final bool? back, dense;
  final Icon? icon;
  const CostumeAppBar({Key? key, required this.title, this.back, this.icon, this.dense = false, this.profileTitle}) : super(key: key);

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
        )
      ),
      leading: back != null ? IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: ColorSty.primary),
        onPressed: () => Navigator.of(context).pop(false),
      ) : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon != null) ...[
            icon!,
            const SizedBox(width: SpaceDims.sp8),
            if(dense ?? false)
              const SizedBox(width: SpaceDims.sp12),
          ],
          if(profileTitle != null) const SizedBox(width: SpaceDims.sp46+3),
          Text(title, style: TypoSty.title),
          if(profileTitle != null) Column(
            children: [
              Text(profileTitle!, style: TypoSty.title.copyWith(color: ColorSty.primary)),
              const SizedBox(height: SpaceDims.sp2),
              Container(
                width: 55,
                height: 2,
                color: ColorSty.primary,
              )
            ],
          ),
          const SizedBox(width: SpaceDims.sp32),
          const SizedBox(width: SpaceDims.sp24),
        ],
      ),
    );
  }

}
