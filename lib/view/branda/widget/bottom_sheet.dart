import 'package:flutter/material.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/widget/input/labellevel_selection.dart';
import 'package:java_code_app/widget/sheet/detailmenu_sheet.dart';

class BottomSheetDetailMenuTopping extends StatefulWidget {
  final List<Level> listLevel;
  final Level? selectedLevel;
  final ValueChanged<Level> onSelection;

  const BottomSheetDetailMenuTopping({
    Key? key,
    required this.listLevel,
    required this.selectedLevel,
    required this.onSelection,
  }) : super(key: key);

  @override
  _BottomSheetDetailMenuToppingState createState() =>
      _BottomSheetDetailMenuToppingState();
}

class _BottomSheetDetailMenuToppingState extends State<BottomSheetDetailMenuTopping> {
  Level? _selectedLevel;

  @override
  void initState() {
    if(widget.selectedLevel != null) _selectedLevel = widget.selectedLevel;
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BottomSheetDetailMenu(
      title: "Pilih Level",
      content: Expanded(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (Level item in widget.listLevel)
              LabelLevelSelection(
                data: item,
                isSelected: item == _selectedLevel,
                onSelection: (Level value) {
                  widget.onSelection(value);
                  setState(() => _selectedLevel = value);
                  Navigator.of(context).pop(value);
                },
              ),
          ],
        ),
      ),
    );
  }
}
