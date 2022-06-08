import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../option_state.dart';

// TODO: MAKE IT CLICKABLE
class ProductSizeOption extends StatefulWidget {
  const ProductSizeOption({
    Key? key,
    required this.size,
    required this.id,
    required this.currentID,
    required this.inStock,
    required this.onTap,
  }) : super(key: key);

  final int id, currentID;
  final String size;
  final bool inStock;
  final Function(int) onTap;

  @override
  State<ProductSizeOption> createState() => _ProductSizeOptionState();
}

class _ProductSizeOptionState extends State<ProductSizeOption> {
  @override
  Widget build(BuildContext context) {
    OptionState _optionState;
    if (widget.inStock) {
      _optionState = widget.currentID == widget.id
          ? OptionState.Selected
          : OptionState.Deselected;
    } else {
      _optionState = OptionState.Disabled;
    }
    print(_optionState);

    return GestureDetector(
      onTap: () {
        if (_optionState == OptionState.Disabled) return;

        setState(() {
          print(widget.currentID);
          widget.onTap(widget.id);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: _getEdgeInsetsFromState(_optionState),
        decoration: BoxDecoration(
          color: _getBoxColorFromState(_optionState),
          borderRadius: BorderRadius.circular(7),
          border: _optionState == OptionState.Disabled
              ? Border()
              : Border.all(color: kSecondaryColor),
        ),
        child: Text(
          widget.size,
          style: TextStyle(
            color: _getTextColorFromState(_optionState),
            fontSize: 14,
            fontWeight: _optionState == OptionState.Selected
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
        return EdgeInsets.symmetric(horizontal: 20, vertical: 11);
      default:
        return EdgeInsets.symmetric(horizontal: 14, vertical: 8);
    }
  }
}
