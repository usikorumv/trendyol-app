import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../option_state.dart';

class ProductSizeOption extends StatefulWidget {
  const ProductSizeOption({
    Key? key,
    required this.id,
    required this.currentId,
    required this.size,
    required this.inStock,
  }) : super(key: key);

  final int id, currentId;
  final String size;
  final bool inStock;

  @override
  State<ProductSizeOption> createState() => _ProductSizeOptionState();
}

class _ProductSizeOptionState extends State<ProductSizeOption> {
  late OptionState _optionState;

  @override
  void initState() {
    super.initState();
    if (widget.inStock) {
      _optionState = OptionState.Deselected;
      // _optionState = widget.currentID == widget.id
      //     ? OptionState.Selected
      //     : OptionState.Deselected;
    } else {
      _optionState = OptionState.Disabled;
    }

    // if (_optionState == OptionState.Disabled) return;
    // setState(() {

      // _optionState = widget.currentID == widget.id
      //     ? OptionState.Selected
      //     : OptionState.Deselected;
    // });
  }

  @override
  Widget build(BuildContext context) {
    _optionState = widget.inStock ? widget.currentId == widget.id
        ? OptionState.Selected
        : OptionState.Deselected : OptionState.Disabled;

    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: _getEdgeInsetsFromState(_optionState),
        decoration: BoxDecoration(
          color: _getBoxColorFromState(_optionState),
          borderRadius: BorderRadius.circular(7),
          border: _optionState == OptionState.Disabled
              ? const Border()
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
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 11);
      default:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 8);
    }
  }
}
