import 'package:bluetooth_chat/application/bindings/application_bindings.dart';
import 'package:bluetooth_chat/application/ui/ui_config.dart';
import 'package:bluetooth_chat/modules/BluetoothChat/bluetooth_chat_module.dart';
import 'package:bluetooth_chat/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      //localizationsDelegates: const [...GlobalMaterialLocalizations.delegates],
      //supportedLocales: const [Locale('pt', 'BR')],
      title: UiConfig.title,
      debugShowCheckedModeBanner: false,
      theme: UiConfig.theme,
      initialBinding: ApplicationBindings(),
      getPages: [
        ...BluetoothChatModule().routers,
        ...HomeModule().routers,
      ],
      initialRoute: '/home',
    );
  }
}
