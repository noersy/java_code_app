import 'package:flutter/material.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final Function onSearch;
  final TextEditingController editingController;
  const SearchBar({
    Key? key,
    required this.onSearch,
    required this.editingController,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.0,
      child: TextFormField(
        controller: widget.editingController,
        onChanged: (value) {
          widget.onSearch(value);
        },
        decoration: InputDecoration(
          isDense: true,
          hintText: Provider.of<LangProviders>(context).lang.beranda!.pencarian,
          hintStyle: TypoSty.captionSemiBold.copyWith(color: ColorSty.grey),
          prefixIcon: const Icon(
            IconsCs.search,
            color: ColorSty.primary,
          ),
          contentPadding: const EdgeInsets.only(
            left: 53,
            right: SpaceDims.sp12,
            top: SpaceDims.sp12,
            bottom: SpaceDims.sp8,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorSty.primary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorSty.primary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorSty.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
