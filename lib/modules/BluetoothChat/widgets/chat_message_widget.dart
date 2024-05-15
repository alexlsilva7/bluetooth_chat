import 'dart:async';

import 'package:bluetooth_chat/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessage extends GetWidget {
  ChatMessage({
    super.key,
    required this.message,
  });

  final RxString time = ''.obs;

  final Message message;

  final Rxn<Timer> timer = Rxn<Timer>();

  void ajustRelativeTime() {
    var now = DateTime.now();
    var diff = now.difference(message.createdAt.toLocal());
    if (diff.inDays > 0) {
      time.value = 'há ${diff.inDays}d';
    } else if (diff.inHours > 0) {
      time.value = 'há ${diff.inHours}h';
    } else if (diff.inMinutes > 0) {
      time.value = 'há ${diff.inMinutes}m';
    } else {
      time.value = 'Agora';
    }
  }

  void updateRelativeTime() {
    ajustRelativeTime();
    timer.value = Timer.periodic(const Duration(minutes: 1), (timer) {
      ajustRelativeTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    updateRelativeTime();
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    0.75, // Definir um limite máximo de largura
              ),
              decoration: BoxDecoration(
                  color: message.isMe
                      ? Colors.deepPurple
                      : Colors.deepPurple[100]!.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(32),
                    topRight: const Radius.circular(32),
                    bottomLeft: Radius.circular(message.isMe ? 32 : 0),
                    bottomRight: Radius.circular(message.isMe ? 0 : 32),
                  )),
              child: Text(
                message.message,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                softWrap: true,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
              message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Obx(
                () => Text(
                  time.value,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
