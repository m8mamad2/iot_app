import 'package:flutter/material.dart';


Size size(BuildContext context)=> MediaQuery.sizeOf(context);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff060912),
      body: Column(
        children: [
          SizedBox(height: 100,),
          CustomPaint(
            size: Size(size(context).width*0.5, size(context).height*0.2), 
            painter: RPSCustomPainter(),
          ),
        ]
      )
    );
  }
}

class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  // Triangle
  Paint paintFill1 = Paint()
      ..color = const Color(0xff182943)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    Path path_1 = Path();
    path_1.moveTo(size.width*0.5084833,size.height*-0.2902857);
    path_1.quadraticBezierTo(size.width*-0.0296333,size.height*1.0083429,size.width*-0.0400500,size.height*1.0383429);
    path_1.cubicTo(size.width*-0.0218500,size.height*1.2303714,size.width*0.9771000,size.height*1.1884000,size.width*1.0268167,size.height*1.0264286);
    path_1.quadraticBezierTo(size.width*1.0164000,size.height*0.9964286,size.width*0.5084833,size.height*-0.2902857);
    path_1.close();

    canvas.drawPath(path_1, paintFill1);
  

  // Triangle
  Paint paintStroke1 = Paint()
      ..color = const Color(0xff182943)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel;
     
         
    
    canvas.drawPath(path_1, paintStroke1);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
