import 'dart:io';

import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void errorDialog(BuildContext context, Failure failure) {
  if (failure is FirebaseFailure) {
    print(
        'code: ${failure.code}\nmessage: ${failure.message}\nplugin: ${failure.plugin}');
  } else {
    print(failure.message);
  }
  if (Platform.isIOS) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(failure is FirebaseFailure ? failure.code : 'Error'),
          content: Text(failure is FirebaseFailure
              ? '${failure.plugin}\n ${failure.message}'
              : failure.message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context); //chiudo il dialogf
              },
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(failure is FirebaseFailure ? failure.code : 'Error'),
          content: Text(failure is FirebaseFailure
              ? '${failure.plugin}\n ${failure.message}'
              : failure.message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        );
      },
    );
  }
}
