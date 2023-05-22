import 'package:flutter/material.dart';
import 'package:lenoid/widgets/status/empty_widget.dart';

// used for navigation route faking view
// it will invisible on phone size screen
class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 1000
        ? const EmptyWidget(message: "Your'e not Lost buddy <:")
        : Container();
  }
}
