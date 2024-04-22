import 'dart:io';

import 'package:cam/cam.dart';
import 'package:cam/cam_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CamProvider(),
      child: MaterialApp(
        title: 'Cam',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).width * 0.8,
              child: Consumer<CamProvider>(builder: (context, provider, child) {
                if (provider.imgFile != null) {
                  return Image.file(
                    File(provider.imgFile!.path),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraScreen(),
                  ),
                );
              },
              child: const Text("Take Picture"),
            )
          ],
        ),
      ),
    );
  }
}
