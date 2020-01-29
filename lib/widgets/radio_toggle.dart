import 'package:flutter/material.dart';

class RadioToggle extends StatefulWidget {
  final Color activeColor;
  final Color activeTextColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final List<ValueToggle> choices;
  final void Function(String) onSelected;

  const RadioToggle({
    Key key,
    @required this.choices,
    this.activeColor = Colors.teal,
    this.activeTextColor = Colors.white,
    this.textColor = Colors.black,
    this.fontSize = 24.0,
    this.fontWeight = FontWeight.w700,
    this.onSelected,
  }) : super(key: key);

  @override
  _RadioToggleState createState() => _RadioToggleState();
}

class _RadioToggleState extends State<RadioToggle> {
  _buildList() => widget.choices
      .map(
        (choice) => Container(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          width: double.maxFinite,
          child: Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              bottomLeft: Radius.circular(32.0),
            ),
            color: choice.isSelected ? widget.activeColor : Colors.white24,
            child: InkWell(
              onTap: () {
                widget.choices
                    .forEach((item) => item.isSelected = item == choice);

                if (widget.onSelected != null) {
                  widget.onSelected(choice.title);
                }

                setState(() {});

                Navigator.pop(context);
              },
              highlightColor: Colors.transparent,
              radius: 120.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  choice.title,
                  style: TextStyle(
                    color: choice.isSelected
                        ? widget.activeTextColor
                        : widget.textColor,
                    fontSize: widget.fontSize,
                    fontWeight: widget.fontWeight,
                  ),
                ),
              ),
            ),
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildList(),
    );
  }
}

class ValueToggle {
  bool isSelected;
  final String title;

  ValueToggle({
    this.isSelected,
    this.title,
  });
}
