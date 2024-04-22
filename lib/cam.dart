// ignore_for_file: use_build_context_synchronously

import 'package:cam/cam_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController camController;

  Future<void> initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    camController = CameraController(
      cameras[1],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await camController.initialize();
  }

  Future<void> takePicture() async {
    XFile file = await camController.takePicture();
    final camProvider = Provider.of<CamProvider>(context, listen: false);
    camProvider.imgFile = file;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializeCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Stack(
              children: [
                Positioned.fill(child: CameraPreview(camController)),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => takePicture(),
                          child: const CircleAvatar(
                            radius: 30,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
