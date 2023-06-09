import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    this.isFilled = true,
    required this.child,
    this.onTap,
    this.padding,
    this.elevation,
    this.backgroundColor,
  }) : super(key: key);
  final bool isFilled;
  final Widget child;
  final double? elevation;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation ?? 0,
      type: isFilled ? MaterialType.card : MaterialType.transparency,
      color: isFilled
          ? backgroundColor?.withOpacity(0.4) ??
              Theme.of(context).colorScheme.surface
          : backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }
}
