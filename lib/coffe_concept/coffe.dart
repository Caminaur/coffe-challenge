import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageCoffeController = PageController(
    viewportFraction: 0.35,
  );
  double? _currentPage = 0.0;
  int numeroUnico = 0;

  void _coffeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeController.page;
    });
  }

  @override
  void initState() {
    _pageCoffeController.addListener(_coffeScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeController.removeListener(_coffeScrollListener);
    _pageCoffeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    offset: Offset.zero,
                    spreadRadius: 45,
                  ),
                ],
              ),
            ),
          ),
          Transform.scale(
            alignment: Alignment.bottomCenter,
            scale: 1.6,
            child: PageView.builder(
              controller: _pageCoffeController,
              scrollDirection: Axis.vertical,
              itemCount: 12 + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox.shrink();
                }
                final result = _currentPage! - index + 1;
                numeroUnico = _currentPage!.toInt();
                final value = -0.4 * result + 1;
                final calculo = size.height / 2.6 * (1 - value).abs();
                final opacity = value.clamp(0.0, 1.0);
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(0.3, calculo)
                      ..scale(value),
                    child: Opacity(
                      opacity: opacity,
                      child: Image.asset(
                        'assets/$index.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: Duration(seconds: 3000),
                  child: Text('\$${1 + (numeroUnico + 1 * .5)}',
                      style: TextStyle(fontSize: 30)),
                  key: Key(_currentPage.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
