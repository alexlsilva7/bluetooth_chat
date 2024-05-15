import 'dart:async';
import 'dart:developer';

import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:bluetooth_chat/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class BluetoothChatController extends GetxController {
  final allBluetooth = AllBluetooth();

  BluetoothDevice connectedDevice = Get.arguments as BluetoothDevice;

  StreamSubscription<ConnectionResult>? connectionSubscription;
  StreamSubscription<String?>? dataSubscription;

  final TextEditingController textController = TextEditingController();
  final RxList<Message> messages = <Message>[].obs;

  @override
  onInit() {
    allBluetooth.listenForData.listen((event) {
      messages.add(Message(
        id: const Uuid().v4(),
        author: connectedDevice.name,
        message: event?.toString() ?? 'Unknown message',
        createdAt: DateTime.now(),
        isMe: false,
      ));
    });
    super.onInit();
  }

  Future<void> disconnect() async {
    await allBluetooth.closeConnection();
    log('MYLOG: Disconnected');
    dataSubscription?.cancel();
    dataSubscription = null;
    Get.back();
  }

  Future<void> sendMessage(String message) async {
    log('MYLOG: Sending message: $message');
    if (message.isEmpty) {
      return;
    }
    if (await allBluetooth.sendMessage(message)) {
      log('MYLOG: Message sent: $message');
      messages.add(Message(
        id: const Uuid().v4(),
        author: 'Me',
        message: message,
        createdAt: DateTime.now(),
        isMe: true,
      ));

      textController.clear();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Erro ao enviar mensagem',
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void clearMessages() {
    messages.clear();
    log('MYLOG: Messages cleared');
  }
}
