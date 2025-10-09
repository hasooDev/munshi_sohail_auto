// import 'package:flutter/material.dart';
//
// import '../utility/app_class.dart';
// import 'app_text.dart';
//
// class DashBoard extends StatefulWidget {
//   final List<GridItem> items;
//
//   const DashBoard({super.key, required this.items});
//
//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }
//
// class _DashBoardState extends State<DashBoard> {
//   @override
//   Widget build(BuildContext context) {
//     List<Color> colors = [
//       Colors.teal,
//       Colors.deepPurple,
//       Colors.orange,
//       Colors.indigo,
//       Colors.deepOrangeAccent,
//       Colors.brown,
//     ];
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double boxWidth = (constraints.maxWidth - 48) / 2;
//
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Wrap(
//             spacing: 16,
//             runSpacing: 16,
//             children: List.generate(widget.items.length, (index) {
//               final item = widget.items[index];
//               final color = colors[index % colors.length];
//
//               return Container(
//                 width: boxWidth,
//                 height: 140,
//                 decoration: BoxDecoration(
//                   color: color,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       item.iconPath,
//                       height: 32,
//                       width: 32,
//
//                     ),
//                     const SizedBox(height: 8),
//                     AppText(
//                       text: item.title,
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     const SizedBox(height: 12),
//                     AppText(
//                       text: item.number.toString(),
//                       fontSize: 26,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         );
//       },
//     );
//   }
// }

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
    _pageController = PageController();
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
      height: 250,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal, // vertical like ATM card swipe
        itemCount: widget.items.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 0.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
              } else {
                value = (_pageController.initialPage - index).toDouble();
              }

              // Card slides up and fades
              double translateY = value * -50; // move up
              double scale = 1 - (0.05 * value.abs());
              double opacity = (1 - value.abs()).clamp(0.0, 1.0);

              return Transform.translate(
                offset: Offset(0, translateY),
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: _buildCard(
                      widget.items[index],
                      colors[index % colors.length],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(GridItem item, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(item.iconPath, height: 100),
            const SizedBox(height: 12),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 AppText(
                   text: item.title,
                   fontSize: 24,
                   color: Colors.white,
                   fontWeight: FontWeight.w900,
                 ),

                 AppText(
                   text: item.number.toString(),
                   fontSize: 38,
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                 ),
               ],
             )
          ],
        ),
      ),
    );
  }
}


