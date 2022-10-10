import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  const ExpandableDescription({
    Key? key,
    required this.text,
    required this.maxLines,
    this.style,
    this.textAlign,
  }) : super(key: key);

  final int maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String text;

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Text(
        widget.text,
        style: widget.style,
        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        textAlign: widget.textAlign,
        softWrap: true,
        maxLines: isExpanded ? null : widget.maxLines,
      ),
    );
  }
}
