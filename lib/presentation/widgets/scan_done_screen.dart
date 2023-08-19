
import 'package:flutter/material.dart';

import '../animations/face_id_animation_controller.dart';
import 'face_id_painter.dart';


class DoneScreen extends StatefulWidget {
  const DoneScreen({
    Key? key,
    this.customPaintSize = 200.0,
  }) : super(key: key);

  final double customPaintSize;

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen>
    with SingleTickerProviderStateMixin {
  late final FaceIDAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FaceIDAnimationController(
      customPaintSize: widget.customPaintSize,
      controller: AnimationController(
        duration: const Duration(seconds: 4),
        vsync: this,
      ),
    );
    Future.delayed(
        const Duration(seconds: 1),
            () => _controller.forward().then((_) {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.of(context).pop();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(
            widget.customPaintSize,
            widget.customPaintSize,
          ),
          painter: FaceIDPainter(
            animation: _controller,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}