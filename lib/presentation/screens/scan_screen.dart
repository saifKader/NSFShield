import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras![selectedCameraIndex],
      ResolutionPreset.max,
    );

    _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_cameraController!),
          Positioned(
            bottom: 50.0,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () async {
                  try {
                    final path = '${(await getTemporaryDirectory()).path}/${DateTime.now()}.png';
                    XFile picture = await _cameraController!.takePicture();
                    picture.saveTo(path);
                    // Do something with the path if needed.
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Icon(Icons.camera),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
