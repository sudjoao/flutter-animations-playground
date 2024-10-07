import 'package:flutter/material.dart';

class Animations extends StatefulWidget {
  const Animations({super.key});

  @override
  State<Animations> createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> {
  final Duration duration = const Duration(milliseconds: 1700);
  final Color color = Colors.deepPurple;
  double width = 150;

  final List<Curve> expandCurves = [
    Curves.easeIn,
    Curves.bounceIn,
    Curves.elasticIn,
    Curves.fastLinearToSlowEaseIn,
    Curves.decelerate,
  ];

  final List<Curve> contractCurves = [
    Curves.easeOut,
    Curves.bounceOut,
    Curves.elasticOut,
    Curves.fastOutSlowIn,
    Curves.linearToEaseOut,
  ];

  final List<Curve> otherCurves = [
    Curves.slowMiddle,
    Curves.easeInOut,
  ];

  void changeWidth() {
    setState(() {
      width = width == 150 ? 600 : 150;
    });
  }

  @override
  Widget build(BuildContext context) {
    int maxLength = expandCurves.length > contractCurves.length
        ? expandCurves.length
        : contractCurves.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
        actions: [
          TextButton(onPressed: changeWidth, child: const Text("Change Width")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(maxLength, (index) {
                  Curve curve = width > 150
                      ? (index < expandCurves.length
                          ? expandCurves[index]
                          : expandCurves.last)
                      : (index < contractCurves.length
                          ? contractCurves[index]
                          : contractCurves.last);
                  return Column(
                    children: [
                      Text(curve.toString()),
                      AnimatedContainer(
                        duration: duration,
                        curve: curve,
                        width: width,
                        height: 80,
                        color: color,
                      ),
                    ],
                  );
                }),
                const Text("Other Curves", style: TextStyle(fontSize: 24)),
                const Divider(),
                ...otherCurves.map((curve) {
                  return Column(
                    children: [
                      Text(curve.toString()),
                      AnimatedContainer(
                        duration: duration,
                        curve: curve,
                        width: width,
                        height: 80,
                        color: color,
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
