import 'dart:developer';

import 'package:bluetooth_chat/modules/BluetoothChat/widgets/chat_message_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'bluetooth_chat_controller.dart';

class BluetoothChatPage extends GetView<BluetoothChatController> {
  const BluetoothChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool isPop) {
        log('Pop invoked: $isPop');
        controller.disconnect();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.connectedDevice.name),
          backgroundColor: Colors.deepPurple.withOpacity(0.5),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return ChatMessage(message: message);
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepPurple[900]!.withOpacity(0.2),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: ' Digite sua mensagem',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        controller.sendMessage(controller.textController.text),
                    icon: const Icon(FontAwesomeIcons.paperPlane,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
