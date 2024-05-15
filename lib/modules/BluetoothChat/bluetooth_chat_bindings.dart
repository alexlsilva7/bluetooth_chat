import 'package:get/get.dart';
import 'bluetooth_chat_controller.dart';

class BluetoothChatBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(BluetoothChatController());
  }
}
