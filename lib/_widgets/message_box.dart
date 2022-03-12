import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class MessageBox {
  static void show(BuildContext context, String message, VoidCallback onOK) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      onOK();
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).ok),
                  )
                ],
              ),
            ),
          );
        },
        barrierDismissible: false);
  }
}
