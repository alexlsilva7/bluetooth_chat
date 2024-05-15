import 'package:bluetooth_chat/modules/BluetoothChat/bluetooth_chat_bindings.dart';
import 'package:bluetooth_chat/modules/BluetoothChat/bluetooth_chat_page.dart';
import 'package:bluetooth_chat/application/modules/module.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class BluetoothChatModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/bluetooth_chat',
      page: () => const BluetoothChatPage(),
      binding: BluetoothChatBindings(),
    ),
  ];
}
