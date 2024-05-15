import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Chat'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
      ),
      body: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeItem(
                  icon: controller.listening.value
                      ? Icons.blur_on
                      : Icons.wifi_tethering,
                  text: controller.listening.value
                      ? 'Aguardando conexão'
                      : 'Iniciar servidor',
                  gradient: controller.listening.value
                      ? const LinearGradient(
                          colors: [
                            Colors.blue,
                            Color.fromARGB(255, 41, 134, 255),
                          ],
                        )
                      : const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 79, 179, 91),
                            Color(0xFF378B29)
                          ],
                        ),
                  onTap: () => controller.startBluetoothServer(),
                ),
                const SizedBox(height: 16),
                if (!controller.listening.value)
                  HomeItem(
                    icon: Icons.bluetooth_searching,
                    text: 'Procurar dispositivos',
                    gradient: const LinearGradient(
                      //#5200AE #4062BB
                      colors: [Color(0xFF5200AE), Color(0xFF4062BB)],
                    ),
                    onTap: () => controller.showDevicesDialog(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  //get icon, decoration, text
  final IconData icon;
  final Gradient gradient;
  final String text;
  final VoidCallback onTap;

  const HomeItem({
    Key? key,
    required this.icon,
    required this.gradient,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 100,
              color: Colors.white,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
