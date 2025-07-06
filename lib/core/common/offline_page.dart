import 'package:flutter/material.dart';
import 'package:simiko/core/theme/app_colors.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 64, color: purpleColor),
              SizedBox(height: 20),
              Text("You are offline", style: blackTextStyle.copyWith(fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // coba reload halaman sebelumnya atau fetch ulang
                  Navigator.pop(context); // atau pushNamed ke halaman utama
                },
                child: Text("Retry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
