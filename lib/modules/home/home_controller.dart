import 'dart:async';
import 'dart:developer';

import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final allBluetooth = AllBluetooth();
  Rxn<BluetoothDevice> connectedDevice = Rxn<BluetoothDevice>();
  RxBool connected = false.obs;
  RxBool listening = false.obs;
  RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  StreamSubscription<ConnectionResult>? connectionSubscription;

  @override
  void onInit() {
    super.onInit();
    _scanForConnections();
  }

  Future<void> _scanForConnections() async {
    //await startBluetoothServer();
    allBluetooth.closeConnection();
    connectionSubscription = allBluetooth.listenForConnection.listen((event) {
      if (event.state) {
        connected.value = true;
        connectedDevice.value = event.device;
        log('MYLOG: Connected to ${event.device?.name} ${event.device?.address}');
        Get.toNamed('/bluetooth_chat', arguments: event.device)?.then((value) {
          connected(false);
          listening(false);
        });
      } else {
        connected(false);
        listening(false);
        connectedDevice.value = null;
        log('MYLOG: Disconnected from ${event.device?.name} ${event.device?.address}');
        Get.back();
      }
    });
    // allBluetooth.listenForData.listen((str) {
    //   log('MYLOG: Received message: $str');
    //   if (str == null) {
    //     return;
    //   }
    //   messages.add(Message(
    //     id: const Uuid().v4(),
    //     author: connectedDevice.value?.name ?? 'Unknown',
    //     message: str,
    //     createdAt: DateTime.now(),
    //     isMe: false,
    //   ));
    // });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await allBluetooth.connectToDevice(device.address);
    connectedDevice.value = device;
    connected(true);
  }

  Future<void> showDevicesDialog() async {
    final devices = await allBluetooth.getBondedDevices();

    await Get.defaultDialog(
      title: 'Dispositivos',
      content: SizedBox(
        height: Get.height * 0.5,
        width: Get.width * 0.5,
        child: ListView(
          children: devices
              .map(
                (device) => ListTile(
                    title: Text(device.name),
                    subtitle: Text(device.address),
                    onTap: () async {
                      await connectToDevice(device);
                      Get.back();
                    }),
              )
              .toList(),
        ),
      ),
    );
  }

  Future<void> startBluetoothServer() async {
    if (listening.value) {
      log('MYLOG: Stopping server');
      await allBluetooth.closeConnection();
      listening(false);
      return;
    }
    await allBluetooth.startBluetoothServer();
    log('MYLOG: Server started');
    listening(true);
  }

  stopBluetoothServer() {
    allBluetooth.closeConnection();
    listening(false);
  }
}
