import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimatedGrid extends StatefulWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double spacing;
  final Duration staggerDuration;
  final Duration animationDuration;

  const AnimatedGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.spacing = 16.0,
    this.staggerDuration = const Duration(milliseconds: 100),
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  AnimatedGridState createState() => AnimatedGridState();
}

class AnimatedGridState extends State<AnimatedGrid> {
  bool _isReadyToAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isReadyToAnimate = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: widget.crossAxisCount,
      mainAxisSpacing: widget.spacing,
      crossAxisSpacing: widget.spacing,
      children: List.generate(widget.children.length, (index) {
        Widget child = widget.children[index];

        if (child is Image && child.image is NetworkImage) {
          child = CachedNetworkImage(
            imageUrl: (child.image as NetworkImage).url,
            fit: child.fit ?? BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        }

        return _AnimatedGridItem(
          child: child,
          delay: Duration(
              milliseconds: index * widget.staggerDuration.inMilliseconds),
          duration: widget.animationDuration,
          isReadyToAnimate: _isReadyToAnimate,
        );
      }),
    );
}

class _AnimatedGridItem extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final bool isReadyToAnimate;

  const _AnimatedGridItem({
    required this.child,
    required this.delay,
    required this.duration,
    required this.isReadyToAnimate,
  });

  @override
  _AnimatedGridItemState createState() => _AnimatedGridItemState();
}

class _AnimatedGridItemState extends State<_AnimatedGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _blurAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Added blur animation with a different interval
    _blurAnimation = Tween<double>(
      begin: 10.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));
  }

  @override
  void didUpdateWidget(_AnimatedGridItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isReadyToAnimate && !_hasAnimated) {
      _hasAnimated = true;
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: _blurAnimation.value,
                sigmaY: _blurAnimation.value,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: widget.child,
              ),
            ),
          ),
        ),
    );
}