// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NeoTile extends StatefulWidget {
  final double height;
  final double width;
  bool winner;
  String? text;

  NeoTile({
    required this.height,
    required this.width,
    this.winner = false,
    this.text,
    Key? key,
  }) : super(key: key);

  @override
  State<NeoTile> createState() => _NeoTileState();
}

class _NeoTileState extends State<NeoTile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: 1.seconds,
    );
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 1,
            spreadRadius: 0.1,
            blurStyle: BlurStyle.inner,
            color: Theme.of(context).colorScheme.secondary,
          ),
          BoxShadow(
            offset: const Offset(-2, -2),
            blurRadius: 1,
            spreadRadius: 0.1,
            blurStyle: BlurStyle.inner,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
      ),
      child: widget.winner
          ? Animate(
              controller: _animationController,
              effects: <Effect>[
                ShimmerEffect(
                  curve: Curves.easeInOut,
                  duration: _animationController.duration,
                ),
              ],
              child: _childWidget(context),
            )
          : _childWidget(context),
    );
  }

  Widget _childWidget(BuildContext context) {
    return Text(
      widget.text == null ? '' : widget.text!,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: widget.height * 0.8,
        height: 1.2,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
