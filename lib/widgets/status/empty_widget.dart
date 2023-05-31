import 'dart:math';

import 'package:flutter/material.dart';

class EmptyWidgetButton {
  final Icon icon;
  final String text;
  final Function()? actions;
  const EmptyWidgetButton({
    required this.text,
    required this.icon,
    required this.actions,
  });
}

class EmptyWidget extends StatelessWidget {
  final String message;
  final List<EmptyWidgetButton>? actions;

  const EmptyWidget({
    required this.message,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getRandomFace(),
              style: materialTheme.textTheme.displayLarge!.copyWith(
                color: materialTheme.colorScheme.onSurface.withAlpha(97),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: materialTheme.textTheme.displaySmall,
              ),
            ),
            if (actions == null)
              const SizedBox()
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 5,
                  alignment: WrapAlignment.center,
                  children: [
                    for (var it in actions!)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: FilledButton.icon(
                          icon: it.icon,
                          label: Text(it.text),
                          onPressed: it.actions,
                          style: FilledButton.styleFrom(
                            fixedSize: const Size.fromHeight(40),
                          ),
                        ),
                      ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

var _error_faces = [
  "(ﾉ´ з `)ノ",
  "(￣ε￣＠)",
  "(.❛ ᴗ ❛.)",
  "(/ω＼)",
  "!(•̀ᴗ•́)و ̑̑",
  "(•̀o•́)ง",
  "ʕ •ᴥ•ʔ",
  "(･o･;)",
  "Σ(ಠ_ಠ)",
  "ಥ_ಥ",
  "(˘･_･˘)",
  "(；￣Д￣)",
  "(･Д･。",
];

String getRandomFace() {
  final random = Random();
  return _error_faces[random.nextInt(_error_faces.length)];
}
