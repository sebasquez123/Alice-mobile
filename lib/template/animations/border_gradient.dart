
import 'package:flutter/material.dart';

class AnimatedGradientBorder extends StatefulWidget {
  final double radius;
  final Duration duration;
  final double thickness;
  final Widget? child;
  final List<Color> colorList;
  const AnimatedGradientBorder({
    super.key,
    this.radius = 32,
    this.duration = const Duration(seconds: 20),
    this.thickness = 8,
    this.child,
    this.colorList = const [
      Color.fromRGBO(3, 0, 35, 0.8),
      Color.fromRGBO(255, 255, 255, 0.8),
      Color.fromRGBO(0, 117, 255, 0.8),
      Color.fromRGBO(227, 240, 255, 0.8),
      Color.fromRGBO(35, 189, 255, 0.8),
      Color.fromRGBO(206, 240, 255, 0.8),
    ],
  });

  @override
  AnimatedGradientBorderState createState() => AnimatedGradientBorderState();
}

class AnimatedGradientBorderState extends State<AnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _tlAlignAnim;
  late Animation<Alignment> _brAlignAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _tlAlignAnim = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
        tween:
            Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
            begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
            begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
            begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
    ]).animate(_controller);

    _brAlignAnim = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
            begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
            begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween:
            Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
            begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
    ]).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) => Stack(
      children: [
        widget.child != null
            ? ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
                child: widget.child!,
              )
            : const SizedBox.shrink(),
        ClipPath(
          clipper: _CenterCutPath(
              radius: widget.radius, thickness: widget.thickness),
          child: RepaintBoundary(
            child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.radius),
                      ),
                      gradient: LinearGradient(
                          begin: _tlAlignAnim.value,
                          end: _brAlignAnim.value,
                          colors: [
                            widget.colorList[0],
                            widget.colorList[1],
                            widget.colorList[2],
                            widget.colorList[3],
                            widget.colorList[4],
                            widget.colorList[5],
                          ]),
                    ),
                  )),
          ),
        ),
      ],
    );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CenterCutPath extends CustomClipper<Path> {
  final double radius;
  final double thickness;
  _CenterCutPath({this.radius = 0, this.thickness = 1});

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(
        -size.width, -size.width, size.width * 2, size.height * 2);
    final double width = size.width - thickness * 2;
    final double height = size.height - thickness * 2;

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(thickness, thickness, width, height),
          Radius.circular(radius - thickness),
        ),
      )
      ..addRect(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant _CenterCutPath oldClipper) => oldClipper.radius != radius || oldClipper.thickness != thickness;
}
