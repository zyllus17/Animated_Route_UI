import 'package:flutter/material.dart';

const _busSize = 30.0;
const _dotSize = 18.0;

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  bool animated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bally -> Howrah'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final centerDot = constraints.maxWidth / 2 - _dotSize / 2;
          final centerBus = constraints.maxWidth / 2 - _busSize / 2;
          return Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                left: centerBus,
                top: animated ? 15 : constraints.maxHeight - _busSize - 10,
                bottom: 0.0,
                child: BusLine(),
              ),

              /// 1st Dot
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                left: centerDot,
                top: animated ? 100 : constraints.maxHeight,
                child: RouteDot(selected: true),
              ),

              /// 2nd Dot
              AnimatedPositioned(
                duration: const Duration(milliseconds: 800),
                right: centerDot,
                top: animated ? 200 : constraints.maxHeight,
                child: RouteDot(selected: true, left: true),
              ),

              /// 3rd Dot
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1000),
                left: centerDot,
                top: animated ? 300 : constraints.maxHeight,
                child: RouteDot(),
              ),

              /// 4th Dot
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1200),
                right: centerDot,
                top: animated ? 400 : constraints.maxHeight,
                child: RouteDot(selected: true, left: true),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      animated = !animated;
                    });
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class BusLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.directions_bus,
          size: _busSize,
        ),
        Expanded(
          child: Container(
            width: 5,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}

class RouteDot extends StatelessWidget {
  final bool selected;
  final bool displayCard;
  final bool left;

  const RouteDot({
    this.selected = false,
    this.displayCard = false,
    this.left = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (left) ...[
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('JFK + ORY'),
            ),
          ),
          Container(
            width: 10,
            height: 1,
            color: Colors.grey[400],
          ),
        ],
        Container(
          height: _dotSize,
          width: _dotSize,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.grey[100],
            ),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundColor: selected ? Colors.red : Colors.green,
            ),
          ),
        ),
        if (!left) ...[
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('JFK + ORY'),
            ),
          ),
          Container(
            width: 10,
            height: 1,
            color: Colors.grey[400],
          ),
        ],
      ],
    );
  }
}
