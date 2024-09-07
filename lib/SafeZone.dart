import 'package:flutter/material.dart';

class SafeZone extends StatelessWidget {
  const SafeZone({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final safeLeftPadding = MediaQuery.of(context).padding.left + 16;
    final safeRightPadding = MediaQuery.of(context).padding.right + 16;
    final safeBottomPadding = MediaQuery.of(context).padding.bottom + 16;
    final safeTopPadding = MediaQuery.of(context).padding.top + 16;

    return Padding(
      padding: EdgeInsets.only(
          left: safeLeftPadding,
          right: safeRightPadding,
          bottom: safeBottomPadding,
          top: safeTopPadding),
      child: child,
    );
  }
}
