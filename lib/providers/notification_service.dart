import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

class NotificationService {
  RemoteMessage remoteMessage;
  BuildContext context;

  NotificationService(this.remoteMessage, {required this.context});

  void showToast() {
    print("REMOTEMESSAGE ${remoteMessage.toString()}");

    var title = remoteMessage.notification?.title;
    var body = remoteMessage.notification?.body;
    var data = remoteMessage.data;

    //TODO - display a dialog for the random quote
    Widget toastWidget = Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        margin: const EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 40,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: secondaryColor,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/img/ico.png',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title!,
                    style: textStyle.apply(
                      fontSizeDelta: -2,
                      fontWeightDelta: 2,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    body!,
                    style: textStyle.apply(
                      fontSizeDelta: -4,
                      fontWeightDelta: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showOverlayNotification(
      (context) => toastWidget,
      duration: const Duration(seconds: 12),
      position: NotificationPosition.bottom,
    );
  }
}
