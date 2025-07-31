import 'package:flutter/material.dart';
import '../utility/app_class.dart';
import 'app_text.dart';

class DashBoard extends StatefulWidget {
  final List<GridItem> items;

  const DashBoard({super.key, required this.items});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.teal,
      Colors.deepPurple,
      Colors.orange,
      Colors.indigo,
      Colors.deepOrangeAccent,
      Colors.brown,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        double boxWidth = (constraints.maxWidth - 48) / 2;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(widget.items.length, (index) {
              final item = widget.items[index];
              final color = colors[index % colors.length];

              return Container(
                width: boxWidth,
                height: 140,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item.iconPath,
                      height: 32,
                      width: 32,

                    ),
                    const SizedBox(height: 8),
                    AppText(
                      text: item.title,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 12),
                    AppText(
                      text: item.number.toString(),
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

/*
import 'package:flutter/material.dart';
import '../utility/app_class.dart';
import 'app_text.dart';

class DashBoard extends StatefulWidget {
  final List<GridItem> items;

  const DashBoard({super.key, required this.items});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75, initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Color> colors = [
    Colors.teal,
    Colors.deepPurple,
    Colors.orange,
    Colors.indigo,
    Colors.deepOrangeAccent,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = (_pageController.page ?? _pageController.initialPage) - index.toDouble();
                value = (1 - (value.abs() * 0.3)).clamp(0.85, 1.0);
              }

              return Transform.scale(
                scale: value,
                child: _buildCard(widget.items[index], colors[index % colors.length]),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(GridItem item, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(item.iconPath, height: 36, width: 36),
            const SizedBox(height: 12),
            AppText(
              text: item.title,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10),
            AppText(
              text: item.number.toString(),
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
*/
