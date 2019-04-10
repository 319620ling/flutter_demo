import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemeData(

        primaryColor: Colors.red,

        primarySwatch: Colors.teal,

      ),

      home: BackDrop(),

    );

  }

}

class BackDrop extends StatefulWidget {

  @override

  _BackDropState createState() => _BackDropState();

}

class _BackDropState extends State<BackDrop>

    with SingleTickerProviderStateMixin {

  AnimationController animationController;

  @override

  void initState() {

    super.initState();

    animationController = AnimationController(

      vsync: this,

      duration: Duration(milliseconds: 100),

      value: 1,

    );

  }

  @override

  void dispose() {

    super.dispose();

    animationController.dispose();

  }

  bool get isPanelVisible {

    final AnimationStatus status = animationController.status;

    return status == AnimationStatus.completed ||

        status == AnimationStatus.forward;

  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {

    final height = constraints.biggest.height;

    final backHeight = height - 32;

    final frontHeight = -32.0;

    return RelativeRectTween(

            begin: RelativeRect.fromLTRB(0.0, backHeight, 0.0, frontHeight),

            end: RelativeRect.fromLTRB(0.0, 60.0, 0.0, 0.0))

        .animate(CurvedAnimation(

            parent: animationController, curve: Curves.easeInOut));

  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Backdrop'),

        leading: IconButton(

          onPressed: () {

            animationController.fling(velocity: isPanelVisible ? -1.0 : 1.0);

          },

          icon: AnimatedIcon(

            icon: AnimatedIcons.close_menu,

            progress: animationController.view,

          ),

        ),

      ),

      body:  Container(

            child: Column(

              children: <Widget>[

                Container(

                  color: Colors.blue,

                  child: Center(

                    child: Text(

                      'Back Panl',

                      style: TextStyle(color: Colors.white, fontSize: 28.0),

                    ),

                  ),

                ),
SlideStack (),
                Material(

                    elevation: 4.0,

                    borderRadius: BorderRadius.only(

                      topLeft: Radius.circular(16.0),

                      topRight: Radius.circular(16.0),

                    ),

                    child: Column(

                      children: <Widget>[

                        Container(

                          height: 32,

                          child: Text(

                            'Shop Here',

                            style: TextStyle(color: Colors.red),

                          ),

                        ),

                        Expanded(

                          child: Center(

                            child: Text('Front Panl',

                                style: TextStyle(
                                    color: Colors.red, fontSize: 28.0)),

                          ),

                        )

                      ],

                    ),

                  ),
              ],

            ),

          )
      );
  }
}