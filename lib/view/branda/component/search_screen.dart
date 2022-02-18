import 'package:flutter/material.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/view/branda/widget/menuberanda_card.dart';

class SearchScreen extends StatefulWidget {
  final String result;
  final MenuList data;

  const SearchScreen({
    Key? key,
    required this.result,
    required this.data,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<DMenu> data = [];

  @override
  void initState() {
    data = widget.data.data
        .where((element) =>
            element.nama.toLowerCase().contains(widget.result.toLowerCase()))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp12),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: widgetListMenu(),
          ),
        ),
      ],
    );
  }

  Widget widgetListMenu() {
    if (data.isNotEmpty) {
      return Column(
        children: [
          for (DMenu item in data) CardMenu(data: item),
        ],
      );  
    } else {
      return Center(child: Text('data tidak dtiemukan'));
    }
  }
}
