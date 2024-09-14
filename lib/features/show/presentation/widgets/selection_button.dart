// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SelectionButton extends StatefulWidget {
  final SelectionButtonController selectButtonController;
  final List<String> options;
  final double buttonWidth;
  final double buttonHeight;
  final Function(String) onChange;

  const SelectionButton({
    super.key,
    required this.selectButtonController,
    required this.options,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.onChange,
  });

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  int _selectedIndex = 0;

  final Duration _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    widget.selectButtonController.value = widget.options[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.buttonWidth * widget.options.length) + 3.0,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.goldenrodYellow, width: 1.5),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: _animationDuration,
            curve: Curves.easeOutExpo,
            left: _selectedIndex * widget.buttonWidth,
            child: Container(
              width: widget.buttonWidth,
              height: widget.buttonHeight,
              decoration: const BoxDecoration(
                color: AppColors.goldenrodYellow,
              ),
            ),
          ),
          Row(
            children: widget.options
                .map(
                  (option) => SelectButton(option, () {
                    setState(() {
                      int index = widget.options.indexOf(option);
                      _selectedIndex = index;
                      widget.selectButtonController.value = option;
                      widget.onChange(option);
                    });
                  }),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget SelectButton(String text, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: widget.buttonWidth,
        height: widget.buttonHeight,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(child: ButtonText(text)),
      ),
    );
  }

  Widget ButtonText(String text) {
    return AnimatedDefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: text == widget.selectButtonController.value
              ? Colors.white
              : AppColors.goldenrodYellow),
      duration: _animationDuration,
      curve: Curves.easeOutQuad,
      child: Text(text),
    );
  }
}

class SelectionButtonController {
  String value = '';
}
