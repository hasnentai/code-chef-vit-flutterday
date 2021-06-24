import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  double height = 94.0;
  double width = 94.0;
  double pLeft = 0.0;
  double targetValue = 2 * math.pi;
  late AnimationController _animationController;
  late AnimationController _animationControllerUfo;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20))
          ..repeat();
    _animationControllerUfo =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
  }

  Widget implicitAnimatedContainer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInCirc,
            height: height,
            width: width,
            color: Colors.blue,
          ),
        ),
        ElevatedButton(
            onPressed: () => {
                  this.setState(() {
                    height = height == 120.0 ? 64.0 : 120.0;
                    width = width == 120.0 ? 64.0 : 120.0;
                  })
                },
            child: Text("Change Size"))
      ],
    );
  }

  Widget implicitCustomAnimation(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://cdn.mos.cms.futurecdn.net/LLqd5henXciW7vFwHU8PWA-480-80.jpg"))),
      child: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: targetValue),
          duration: Duration(seconds: 20),
          builder: (_, double angle, __) {
            return Transform.rotate(
              angle: angle,
              child: Image.network(
                  "https://cdn.pixabay.com/photo/2018/01/26/13/04/sun-3108640_640.png"),
            );
          },
        ),
      ),
    );
  }

  Widget explicitAnimationRotation(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://cdn.mos.cms.futurecdn.net/LLqd5henXciW7vFwHU8PWA-480-80.jpg"))),
        child: Center(
          child: RotationTransition(
            turns: _animationController,
            child: Image.network(
                "https://cdn.pixabay.com/photo/2018/01/26/13/04/sun-3108640_640.png"),
          ),
        ));
  }

  Widget ufoContainer(BuildContext context) {
    
     return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://cdn.mos.cms.futurecdn.net/LLqd5henXciW7vFwHU8PWA-480-80.jpg"))),
       ),
       AnimatedBuilder(animation: _animationControllerUfo, builder: (_,__){
         return   ClipPath(
          clipper: const BeamClipper(),
          child: Container(
            height: 1000,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.5,
                colors: [
                  Colors.yellow,
                  Colors.transparent,
                ],
                stops: [0,_animationControllerUfo.value]
              ),
              
            ),
          ),
        );
       }),
      
        Image.network("https://mpfpi.com/wp-content/uploads/2020/04/ufo.png",width: 1000.0,)
      ],
    );
  }

  Widget implicitAnimationPosition(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        AnimatedPositioned(
          duration: Duration(seconds: 5),
          left: pLeft,
          child: GestureDetector(
            onTap: () => {
              this.setState(() {
                pLeft = pLeft == 120.0 ? 0.0 : 120.0;
              })
            },
            child: Container(
              height: 124.0,
              width: 150.0,
              color: Colors.blue,
              padding: EdgeInsets.all(20.0),
              child: Center(child: Text("Change Position")),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MyApp1());
  }
}


class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    _animation = Tween(begin: 1.2,end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.repeat(
      reverse: true
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(animation: _controller, builder: (context,widget){
        return Center(
        child:  Container(
            height: 90.0,
            width: 90.0,
            child: CustomPaint(
              painter: PacMan(
                openAngle: _animation.value
              )
          ),
        ),
      );
      })
    );
  }
}




class PacMan extends CustomPainter {

  
  double openAngle;
  PacMan({required this.openAngle});

  


  @override
  void paint(Canvas canvas, Size size) {
    Paint _arc = Paint()
      ..color = Colors.yellow[600]!
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;
    canvas.drawArc(Rect.fromLTRB(0,0,90,90), math.pi, math.pi/openAngle, true, _arc);
    canvas.drawArc(Rect.fromLTRB(0,0,90,90), -math.pi, -math.pi/openAngle, true, _arc);
   // canvas.drawArc(Rect.fromCircle(center:_center,radius: _radius), -math.pi, math.pi, true, _arc);

  }

  @override
  bool shouldRepaint(PacMan oldPaint) {
    return true;
  }
}


class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;
@override
void initState() {
  super.initState();
  _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 9),
  );
  _animation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
    curve: Curves.easeIn,
    parent: _controller
  ));
  _controller.repeat();
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context,w){
          return Center(
          child: Stack(
            children: <Widget>[
              Container(
            child: CustomPaint(painter: Heart(
              progress: _animation.value
            ),),
          ),
               Container(
            child: CustomPaint(painter: StaticHeart(
              
            ),),
          ),
              
            ],
          )
        );
        },
           
      ),
    );
  }
}

class Heart extends CustomPainter {

  double progress;

  Heart({required this.progress});


  Path createPath(double radius) {
    var path = Path();
    var angle = math.pi * 2;
    //path.moveTo(radius * math.cos(0.0), radius * math.sin(0.0));
    for (double i = 0; i < angle; i += 0.01) {
      double x = radius * 16 * math.pow(math.sin(i), 3);
      double y = -radius * (13 * math.cos(i) - 5 * math.cos(2 * i) - 2 * math.cos(3 * i)- math.cos(4 * i));
      path.lineTo(x, y);
      
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[900]!
      ..style = PaintingStyle.stroke
     
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

      var path = createPath(10);
    PathMetrics pathMetrics = path.computeMetrics(forceClosed: true);
    for (PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        pathMetric.length * progress/1.5,
        pathMetric.length * progress,
      );
      canvas.drawShadow(extractPath,Colors.blue[700]!, 10.0, true);
      canvas.drawPath(extractPath, paint);
    }

  }

  @override
  bool shouldRepaint(Heart oldHeart) => true;
}
class StaticHeart extends CustomPainter {

  late double progress;

  StaticHeart();


  Path createPath(double radius) {
    var path = Path();
    var angle = math.pi * 2;
    //path.moveTo(radius * math.cos(0.0), radius * math.sin(0.0));
    for (double i = 0; i < angle; i += 0.01) {
      double x = radius * 16 * math.pow(math.sin(i), 3);
      double y = -radius * (13 * math.cos(i) - 5 * math.cos(2 * i) - 2 * math.cos(3 * i)- math.cos(4 * i));
      path.lineTo(x, y);
      
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.bevel
     
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;
      canvas.drawShadow(createPath(9),Colors.blue[900]!, 60.0, true);
      
      
      canvas.drawPath(createPath(9), paint);
      
    }

  

  @override
  bool shouldRepaint(StaticHeart oldHeart) => true;
}

class MyApp1 extends StatefulWidget {
  MyApp1() ;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> with TickerProviderStateMixin {
  late AnimationController _animationController;

  double _containerPaddingLeft = 20.0;
  late double _animationValue;
  double _translateX = 0;
  double _translateY = 0;
  double _rotate = 0;
  double _scale = 1;

  late bool show;
  bool sent = false;
  Color _color = Colors.lightBlue;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1300));
    show = true;
    _animationController.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController.value;
        if (_animationValue >= 0.2 && _animationValue < 0.4) {
          _containerPaddingLeft = 100.0;
          _color = Colors.green;
        } else if (_animationValue >= 0.4 && _animationValue <= 0.5) {
          _translateX = 80.0;
          _rotate = -20.0;
          _scale = 0.1;
        } else if (_animationValue >= 0.5 && _animationValue <= 0.8) {
          _translateY = -20.0;
        } else if (_animationValue >= 0.81) {
          _containerPaddingLeft = 20.0;
         sent = true;
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding:EdgeInsets.all(100.0),
            child:Center(
              child: GestureDetector(
               
                  onTap: () {
                    _animationController.forward();
                  },
                  child: AnimatedContainer(
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                            color: _color,
                            blurRadius: 21,
                            spreadRadius: -15, 
                            offset: Offset(
                              0.0, 
                              20.0,
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: _containerPaddingLeft,
                          right: 20.0,
                          top: 10.0,
                          bottom: 10.0),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          (!sent)
                              ? AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  child: Icon(Icons.send),
                                  curve: Curves.fastOutSlowIn,
                                  transform: Matrix4.translationValues(
                                      _translateX, _translateY, 0)
                                    ..rotateZ(_rotate)
                                    ..scale(_scale),
                                )
                              : Container(),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 600),
                            child: show ? SizedBox(width: 10.0) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: show ? Text("Send") : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: sent ? Icon(Icons.done) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            alignment: Alignment.topLeft,
                            duration: Duration(milliseconds: 600),
                            child: sent ? SizedBox(width: 10.0) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: sent ? Text("Done") : Container(),
                          ),
                        ],
                      ))))
          ),
        ],
      )),
    );
  }
}
