import 'dart:async';
import 'dart:math';

import 'package:elliptic_text/elliptic_text.dart';
import 'package:flutter/material.dart';
import 'package:pomo_de_paque_website/managers/config_manager.dart';
import 'package:pomo_de_paque_website/managers/theme_manager.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});

  final Widget child;

  final List<(String, double)> _images = const [
    ('EggBigBlue', 85),
    ('EggBigBlue', 110),
    ('EggBigMulticolor', 85),
    ('EggBigMulticolor', 105),
    ('EggSmallBlueDotted', 25),
    ('EggSmallBlueDotted', 35),
    ('EggSmallBlueDotted', 45),
    ('EggSmallBlueStriped', 25),
    ('EggSmallBlueStriped', 35),
    ('EggSmallBlueStriped', 45),
    ('EggSmallRedDotted', 25),
    ('EggSmallRedDotted', 35),
    ('EggSmallRedDotted', 45),
    ('EggSmallRedStriped', 25),
    ('EggSmallRedStriped', 35),
    ('EggSmallRedStriped', 45),
    ('EggSmallYellow', 25),
    ('EggSmallYellow', 35),
    ('EggSmallYellow', 45),
    ('FlowerBlue', 65),
    ('FlowerBlue', 75),
    ('FlowerBlue', 85),
    ('FlowerRed', 65),
    ('FlowerRed', 75),
    ('FlowerRed', 85),
    ('FlowerYellow', 65),
    ('FlowerYellow', 75),
    ('FlowerYellow', 85),
    ('LeafRed', 65),
    ('LeafRed', 75),
    ('LeafRed', 85),
    ('TreeBranchBlue', 65),
    ('TreeBranchBlue', 75),
    ('TreeBranchBlue', 85),
    ('TreeBranchPink', 65),
    ('TreeBranchPink', 75),
    ('TreeBranchPink', 85),
    ('TreeBranchRed', 65),
    ('TreeBranchRed', 75),
    ('TreeBranchRed', 85),
    ('TreeBranchYellow', 65),
    ('TreeBranchYellow', 75),
    ('TreeBranchYellow', 85),
    ('RabbitSideView', 65),
    ('RabbitSideView', 85),
    ('RabbitsWithEarBent', 65),
    ('RabbitsWithEarBent', 105),
    ('RabbitsWithEarBent', 145),
    ('RabbitWithEyesClosed', 65),
    ('RabbitWithEyesClosed', 85),
    ('RabbitWithTeeth', 65),
    ('RabbitWithTeeth', 85),
  ];

  @override
  Widget build(BuildContext context) {
    return _GradientRotatingBackground(
      child: Center(
        child:
            Stack(alignment: Alignment.center, fit: StackFit.loose, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          ..._images.map((e) => _MovingImage(e.$1, width: e.$2)).toList(),
          Positioned(
            top: 30,
            child: SizedBox(
              height: 220,
              width: 900.0,
              child: EllipticText(
                text: ConfigManager.instance.eventName,
                perimiterAlignment: EllipticText_PerimiterAlignment.top,
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: 'Gwibble',
                  color: ThemeManager.instance.titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 75,
            child: SizedBox(
              height: 220,
              width: 900.0,
              child: Text(
                '27 au 29 mars 2024',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Gwibble',
                  color: ThemeManager.instance.titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child,
        ]),
      ),
    );
  }
}

class _GradientRotatingBackground extends StatefulWidget {
  const _GradientRotatingBackground({this.child});

  final Widget? child;

  @override
  State<_GradientRotatingBackground> createState() =>
      _GradientRotatingBackgroundState();
}

class _GradientRotatingBackgroundState
    extends State<_GradientRotatingBackground> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 60), vsync: this)
        ..repeat(reverse: true);
  late final Animation<Decoration> _animation = DecorationTween(
    begin: BoxDecoration(
        gradient: LinearGradient(
      //stops: const [0, 0.5, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomLeft,
      colors: [
        ThemeManager.instance.primaryColor,
        ThemeManager.instance.primaryColor,
        ThemeManager.instance.secondaryColor,
      ],
    )),
    end: BoxDecoration(
        gradient: LinearGradient(
      //stops: const [0, 0.5, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      colors: [
        ThemeManager.instance.primaryColor,
        ThemeManager.instance.primaryColor,
        ThemeManager.instance.secondaryColor,
      ],
    )),
  ).animate(_controller)
    ..addListener(() {
      setState(() {});
    });

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _animation.value,
      width: MediaQuery.of(context).size.width,
      child: widget.child,
    );
  }
}

class _MovingImage extends StatefulWidget {
  const _MovingImage(this.name, {required this.width});

  final String name;
  final double width;

  @override
  State<_MovingImage> createState() => _MovingImageState();
}

class _MovingImageState extends State<_MovingImage>
    with TickerProviderStateMixin {
  final _random = Random();
  bool _firstTime = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  final maxWaitingTime = 120;
  final maxFirstWaitingTime = 15;
  final minTime = 60;
  final randomTime = 120;

  late int _duration;
  late double _direction;
  late double _horizontalStart;
  late double _horizontalEnd;
  late double _opacity;

  Future<void> _resetAnimation() async {
    _duration = _random.nextInt(randomTime) + minTime;
    _direction = _random.nextBool() ? 1 : -1;

    _horizontalStart = _random.nextDouble();
    _horizontalEnd = _random.nextDouble();
    _opacity = _random.nextDouble() * 0.3 + 0.1;

    _controller = AnimationController(
        duration: Duration(seconds: _duration), vsync: this);

    _animation = Tween<double>(
            begin: _direction > 0 ? -0.3 : 1.3,
            end: _direction > 0 ? 1.3 : -0.3)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    setState(() {});

    if (_firstTime && _random.nextBool()) {
      _controller.value = _random.nextDouble();
    } else {
      await Future.delayed(Duration(seconds: _random.nextInt(maxWaitingTime)));
    }
    _firstTime = false;

    _controller.forward();
    await Future.delayed(Duration(seconds: _duration));
    _resetAnimation();
  }

  @override
  void initState() {
    super.initState();

    _resetAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Positioned(
          top: _animation.value * MediaQuery.of(context).size.height,
          left: (_horizontalStart +
                  _animation.value * (_horizontalEnd - _horizontalStart)) *
              MediaQuery.of(context).size.width,
          child: child!),
      child: Opacity(
        opacity: _opacity,
        child: SizedBox(
          width: widget.width,
          child: Image.asset('assets/images/${widget.name}.png'),
        ),
      ),
    );
  }
}
