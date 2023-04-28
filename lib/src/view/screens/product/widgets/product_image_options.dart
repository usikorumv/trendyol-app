import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../option_state.dart';

class ProductImageOption extends StatefulWidget {
  const ProductImageOption({
    Key? key,
    required this.id,
    required this.imgUrl,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final int id;
  final String imgUrl;
  final bool isSelected;
  final Function(int) onTap;

  @override
  State<ProductImageOption> createState() => _ProductImageOptionState();
}

class _ProductImageOptionState extends State<ProductImageOption> {
  @override
  Widget build(BuildContext context) {
    OptionState _optionState =
        widget.isSelected ? OptionState.Selected : OptionState.Deselected;

    Size _sizeOfImage = _getSizeFromOptionState(_optionState);

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap(widget.id);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: _optionState == OptionState.Selected
              ? Border.all(color: kSecondaryColor, width: 2)
              : Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(7),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.network(
            widget.imgUrl,
            height: _sizeOfImage.height,
            width: _sizeOfImage.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Size _getSizeFromOptionState(OptionState optionState) {
    switch (optionState) {
      case OptionState.Selected:
        return const Size(66, 84);
      default:
        return const Size(56, 71);
    }
  }
}
