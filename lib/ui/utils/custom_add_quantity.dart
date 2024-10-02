import 'package:flutter/material.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

// ignore: must_be_immutable
class CustomQuantity extends StatefulWidget {
  final int minNumber;
  final int maxNumber;
  final double iconSize;
  int value;
  final ValueChanged onChanged;

  CustomQuantity({
    super.key,
    required this.minNumber,
    required this.maxNumber,
    required this.iconSize,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomQuantity> createState() => _CustomQuantityState();
}

class _CustomQuantityState extends State<CustomQuantity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: widget.iconSize,
          onPressed: () {
            setState(() {
              widget.value = widget.value == widget.minNumber
                  ? widget.minNumber
                  : widget.value -= 1;
              widget.onChanged(widget.value);
            });
          },
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 10.0,
          child: Text(
            '${widget.value}'.farsiNumber,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'Lalezar'),
          ),
        ),
        IconButton(
          iconSize: widget.iconSize,
          onPressed: () {
            setState(() {
              widget.value = widget.value == widget.maxNumber
                  ? widget.maxNumber
                  : widget.value += 1;
              widget.onChanged(widget.value);
            });
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
