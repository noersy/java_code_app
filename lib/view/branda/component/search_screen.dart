
import 'package:flutter/material.dart';
import 'package:java_code_app/theme/spacing.dart';

class SearchScreen extends StatefulWidget {
  final List result;

  const SearchScreen({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp12),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: const [
                // for (Map<String, dynamic> item in widget.result)
                // CardMenu(data: item),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
