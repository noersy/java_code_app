import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class TileListDMenu extends StatelessWidget {
  final String title;
  final String? prefix;
  final Widget? prefixCostume;
  final IconData? icon;
  final SvgPicture? svgPicture;
  final bool? prefixIcon;
  final SvgPicture? iconSvg;
  final TextStyle? textStylePrefix;
  final Function() onPressed;
  final bool? dense, isLoading;

  const TileListDMenu({
    Key? key,
    required this.title,
    this.prefix,
    this.icon,
    this.prefixIcon,
    required this.onPressed,
    this.textStylePrefix,
    this.dense,
    this.prefixCostume,
    this.svgPicture,
    this.iconSvg,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.5),
        ListTile(
          onTap: prefixIcon ?? false ? onPressed : null,
          leading: Padding(
            padding: const EdgeInsets.only(top: SpaceDims.sp2),
            child: iconSvg == null
                ? Icon(icon, color: ColorSty.primary, size: 23.0)
                : iconSvg!,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TypoSty.captionBold),
              Row(
                children: [
                  SizedBox(
                    width: isLoading! ? 90 : (prefixCostume != null) ? 165 : 118,
                    child: isLoading!
                        ? const SkeletonText(height: 20.0)
                        : prefixCostume ??
                            Text(
                              prefix ?? "",
                              style: prefixIcon ?? false
                                  ? TypoSty.captionSemiBold
                                      .copyWith(fontWeight: FontWeight.normal)
                                      .merge(textStylePrefix)
                                  : dense ?? false
                                      ? TypoSty.captionSemiBold
                                          .copyWith(
                                              fontWeight: FontWeight.normal)
                                          .merge(textStylePrefix)
                                      : TypoSty.title
                                          .copyWith(color: ColorSty.primary)
                                          .merge(textStylePrefix),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                  ),
                  if (prefixIcon ?? false)
                    Padding(
                      padding: EdgeInsets.only(
                        left: dense ?? false ? SpaceDims.sp4 : SpaceDims.sp8,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: dense ?? false ? 18.0 : 22.0,
                        color: ColorSty.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
