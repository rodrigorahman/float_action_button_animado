import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _animationController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.idle:
          print('Parado');
          break;
        case ScrollDirection.forward:
          _animationController.forward();
          break;
        case ScrollDirection.reverse:
          _animationController.reverse();
          break;
      }
    });

    _animationController = AnimationController(vsync: this, duration: kThemeAnimationDuration, value: 1);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FloatActionButton Animado'),
      ),
      floatingActionButton: FadeTransition(
        opacity: _animationController,
        child: ScaleTransition(
          scale: _animationController,
          child: FloatingActionButton.extended(
            onPressed: null,
            icon: Icon(Icons.shopping_cart),
            label: const Text('Ir Para o Carrinho'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        controller: _scrollController,
        children: List.generate(10, (index) => index++)
            .map((e) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: e % 2 == 0 ? Colors.red[200] : Colors.green[200],
                ))
            .toList(),
      ),
    );
  }
}
