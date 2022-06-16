import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../option_state.dart';

class ProductSizeOption extends StatefulWidget {
  const ProductSizeOption({
    Key? key,
    required this.optionState,
    required this.size,
  }) : super(key: key);

  final OptionState optionState;
  final String size;

  @override
  State<ProductSizeOption> createState() => _ProductSizeOptionState();
}

class _ProductSizeOptionState extends State<ProductSizeOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.decelerate,
        padding: _getEdgeInsetsFromState(widget.optionState),
        decoration: BoxDecoration(
          color: _getBoxColorFromState(widget.optionState),
          borderRadius: BorderRadius.circular(7),
          border: widget.optionState == OptionState.Disabled
              ? const Border()
              : Border.all(color: kSecondaryColor),
        ),
        child: Text(
          widget.size,
          style: TextStyle(
            color: _getTextColorFromState(widget.optionState),
            fontSize: 14,
            fontWeight: widget.optionState == OptionState.Selected
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Color _getTextColorFromState(OptionState optionState) {
    switch (optionState) {
      case OptionState.Disabled:
        return kTextColor.withOpacity(0.3);
      case OptionState.Selected:
        return Colors.white;
      case OptionState.Deselected:
        return kTextColor;
    }
  }

  Color _getBoxColorFromState(OptionState optionState) {
    switch (optionState) {
      case OptionState.Disabled:
        return kLightGreyColor[1];
      case OptionState.Selected:
        return kSecondaryColor;
      case OptionState.Deselected:
        return Colors.white;
    }
  }

  EdgeInsets _getEdgeInsetsFromState(OptionState optionState) {
    switch (optionState) {
      case OptionState.Selected:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 11);
      default:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 8);
    }
  }
}
