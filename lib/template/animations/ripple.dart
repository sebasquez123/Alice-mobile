import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wave_blob/wave_blob.dart';

class AnimatedRipple extends StatelessWidget {
  const AnimatedRipple({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = DateTime.now().millisecondsSinceEpoch / 1000.0;
    final senWave = 20 * math.sin(2 * math.pi * 1 * t);
    final ValueListenable<double> senWaveListenable = ValueNotifier(senWave);
    return ValueListenableBuilder<double>(
      valueListenable: senWaveListenable,
      builder: (context, amplitude, child) {
        final size = MediaQuery.of(context).size;
        return EntityAnimation(
          blobSize: size,
          callColor: [
            Colors.blue.withAlpha(127),
            Colors.cyan.withAlpha(127),
          ],
          amplitude: 8000
        );
      },
    );
  }
}

class EntityAnimation extends StatefulWidget {
  final List<Color> callColor;
  final double amplitude;
  final Size blobSize;

  const EntityAnimation({
    super.key,
    required this.callColor,
    required this.amplitude,
    required this.blobSize,
  });

  @override
  State<EntityAnimation> createState() => _EntityAnimationState();
}

class _EntityAnimationState extends State<EntityAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _updateColorAnimations();
  }

  @override
  void didUpdateWidget(EntityAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.callColor != oldWidget.callColor) {
      _updateColorAnimations();
    }
  }

  void _updateColorAnimations() {
    if (widget.callColor.length < 2) return; 

    setState(() {
      _colorAnimation1 = ColorTween(
        begin: widget.callColor[0],
        end: widget.callColor[1],
      ).animate(_animationController);

      _colorAnimation2 = ColorTween(
        begin: widget.callColor[1],
        end: widget.callColor[0],
      ).animate(_animationController);
    });
  }

  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => AudioWaveBlob(
              overCircle: true,
              blobSize: widget.blobSize,
              autoScale: true,
              blobCount: 2,
              blobColors: [
                _colorAnimation1.value ?? Colors.blue,
                _colorAnimation2.value ?? Colors.cyan,
              ],
              scale: 1.1,
              speed: 1,
              amplitude: 1000,
              child: const SizedBox.shrink(),
            ),
        ),
      ),
    );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class AudioWaveBlob extends StatefulWidget {
  final double scale;
  final double amplitude;
  final bool autoScale;
  final int blobCount;
  final bool centerCircle;
  final bool overCircle;
  final double speed;
  final List<Color> circleColors;
  final List<Color> blobColors;
  final Widget? child;
  final double width;
  final Size blobSize;
  const AudioWaveBlob({
    super.key,
    this.scale = 1.0,
    this.amplitude = 4250.0,
    this.autoScale = true,
    this.blobCount = 5,
    this.centerCircle = true,
    this.overCircle = false,
    this.speed = 8.6,
    this.width = 1.0,
    this.circleColors = const [
      Color.fromARGB(255, 255, 255, 255),
    ],
    this.blobColors = const [
      Color.fromARGB(65, 86, 232, 255),
      Color.fromARGB(61, 0, 131, 212),
    ],
    this.child = const SizedBox.shrink(),
    required this.blobSize,
  });
  @override
  AudioWaveBlobState createState() => AudioWaveBlobState();
}

class AudioWaveBlobState extends State<AudioWaveBlob>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) => Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Container(
            width: widget.blobSize.width * widget.width,
            height: widget.blobSize.height * 0.2,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: WaveBlob(
              colors: widget.blobColors,
              speed: widget.speed,
              blobCount: widget.blobCount,
              amplitude: widget.amplitude,
              scale: widget.scale,
              autoScale: widget.autoScale,
              centerCircle: widget.centerCircle,
              overCircle: widget.overCircle,
              circleColors: widget.circleColors,
              child: widget.child ?? Container(),
            ),
          ),
      ),
    );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}