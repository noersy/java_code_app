
import 'package:flutter/material.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';

class LabelToppingSelection extends StatefulWidget {
  final Level data;
  final bool? initial;
  final ValueChanged<Level> onSelection;

  const LabelToppingSelection({
    Key? key,
    required this.data,
    required this.onSelection,
    this.initial,
  }) : super(key: key);

  @override
  State<LabelToppingSelection> createState() => _LabelToppingSelectionState();
}

class _LabelToppingSelectionState extends State<LabelToppingSelection> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.initial ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: SpaceDims.sp20,
        horizontal: SpaceDims.sp4,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: _isSelected ? ColorSty.primary : ColorSty.white,
          primary: !_isSelected ? ColorSty.primary : ColorSty.white,
          padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorSty.primary),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          setState(() => _isSelected = !_isSelected);
          widget.onSelection(widget.data);
        },
        child: Row(
          children: [
            const SizedBox(width: SpaceDims.sp4),
            Text("${widget.data.keterangan}"),
            const SizedBox(width: SpaceDims.sp4),
            if (_isSelected) const Icon(Icons.check, size: 18.0),
          ],
        ),
      ),
    );
  }
}
