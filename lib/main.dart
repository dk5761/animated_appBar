import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SlidingAppBar({
    Key? key,
    required this.child,
    required this.controller,
    required this.visible,
  }) : super(key: key);

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position:
          Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double orjWidth = MediaQuery.of(context).size.width;
    double cameraWidth = orjWidth / 24;
    double yourWidth = (orjWidth - cameraWidth) / 5;
    int _index = _tabController.index;

    _tabController.addListener(() {
      setState(() {
        _index = _tabController.index;
      });
    });

    return Scaffold(
      appBar: SlidingAppBar(
        visible: _index != 0,
        controller: _controller,
        child: AppBar(
          title: const Text('TabBar Widget'),
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            labelPadding: EdgeInsets.symmetric(
                horizontal: (orjWidth - (cameraWidth + yourWidth * 3)) / 8.5),
            padding: const EdgeInsets.only(left: 0),
            tabs: <Widget>[
              const Tab(
                icon: Icon(Icons.camera_alt),
              ),
              SizedBox(
                width: yourWidth,
                height: 50,
                child: const Icon(Icons.beach_access_sharp),
              ),
              SizedBox(
                width: yourWidth,
                height: 50,
                child: const Icon(Icons.brightness_5_sharp),
              ),
              SizedBox(
                width: yourWidth,
                height: 50,
                child: const Icon(Icons.cloud_outlined),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: Text("It's cloasdaudy here"),
          ),
          Center(
            child: Text("It's cloudy here"),
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}
