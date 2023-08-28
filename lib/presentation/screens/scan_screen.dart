import 'dart:io';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'amount_input_screen.dart';

class ScanScreen extends StatefulWidget {
  final File? initialImage;

  ScanScreen({this.initialImage});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.initialImage != null) {
      _image = widget.initialImage;
    }
  }

  Future<void> _selectImageSource(BuildContext context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    await showModalBottomSheet(
      context: context,
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: 10.0),
          color: Colors.grey[200],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildOption(
                icon: Icons.camera_alt,
                text: 'Camera',
                onTap: () {
                  _launchScanner(ScannerFileSource.CAMERA);
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 15.0),
              _buildOption(
                icon: Icons.photo_library,
                text: 'Photo Library',
                onTap: () {
                  _launchScanner(ScannerFileSource.GALLERY);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(
      {required IconData icon, required String text, required Function onTap}) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(icon, size: 30.0, color: theme.colorScheme.secondary),
      title: Text(text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0)),
      onTap: () => onTap(),
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  Future<void> _launchScanner(ScannerFileSource source) async {
    final scannedImage =
        await DocumentScannerFlutter.launch(context, source: source);
    if (scannedImage != null) {
      setState(() {
        _image = scannedImage;
        //navigate to amount input screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AmountInputScreen(scannedImage: _image),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => _selectImageSource(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FluentIcons.camera_add_24_regular,
                  size: 120, color: Colors.grey[400]),
              const SizedBox(height: 20), // Some spacing
              Text(
                "Tap anywhere to start scan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
