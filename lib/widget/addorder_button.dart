
import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/text_style.dart';

class AddOrderButton extends StatefulWidget {
  final ValueChanged<int> onChange;
  final int initCount;

  const AddOrderButton({Key? key, required this.onChange, required this.initCount}) : super(key: key);

  @override
  _AddOrderButtonState createState() => _AddOrderButtonState();
}

class _AddOrderButtonState extends State<AddOrderButton> {
  static int jumlahOrder = 0;

  @override
  void initState() {
    jumlahOrder = widget.initCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("button $jumlahOrder");
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (jumlahOrder != 0)
          TextButton(
            onPressed: () {
              setState(() => jumlahOrder--);
              widget.onChange(jumlahOrder);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(25, 25),
              side: const BorderSide(color: ColorSty.primary, width: 2),
            ),
            child: const Icon(Icons.remove),
          ),
        if (jumlahOrder != 0) Text("$jumlahOrder", style: TypoSty.subtitle),
        TextButton(
          onPressed: () {
            setState(() => jumlahOrder++);
            widget.onChange(jumlahOrder);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(25, 25),
            primary: ColorSty.white,
            backgroundColor: ColorSty.primary,
          ),
          child: const Icon(Icons.add, color: ColorSty.white),
        )
      ],
    );
  }
}
