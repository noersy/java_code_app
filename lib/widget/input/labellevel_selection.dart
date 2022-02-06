import 'package:flutter/material.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';

class LabelLevelSelection extends StatefulWidget {
  final Level data;
  final bool isSelected;
  final ValueChanged<Level> onSelection;

  const LabelLevelSelection({
    Key? key,
    required this.data,
    required this.onSelection,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<LabelLevelSelection> createState() => _LabelLevelSelectionState();
}

class _LabelLevelSelectionState extends State<LabelLevelSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: SpaceDims.sp20,
        horizontal: SpaceDims.sp4,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: widget.isSelected ? ColorSty.primary : ColorSty.white,
          primary: !widget.isSelected ? ColorSty.primary : ColorSty.white,
          padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorSty.primary),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          widget.onSelection(widget.data);
        },
        child: Row(
          children: [
            const SizedBox(width: SpaceDims.sp4),
            Text("${widget.data.keterangan}"),
            const SizedBox(width: SpaceDims.sp4),
            if (widget.isSelected) const Icon(Icons.check, size: 18.0),
          ],
        ),
      ),
    );
  }
}
