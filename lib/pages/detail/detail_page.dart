import 'package:flutter/material.dart';
import 'package:lenoid/routes/app_navigator.dart';
import 'package:lenoid/widgets/status/empty_widget.dart';
import 'package:lenoid/widgets/toast.dart' show Toast;

class DetailPage extends StatelessWidget {
  final String title;
  const DetailPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          onPressed: () {
            AppNavigator.closePage();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: EmptyWidget(
            message: "Hello From Other Activity",
            actions: [
              EmptyWidgetButton(
                  text: "Back",
                  icon: const Icon(Icons.refresh),
                  actions: () {
                    context.showSnackBar('Hello From Snakbar Extension');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
