import 'dart:math' show pi;
import 'dart:ui';
import 'package:azkar/core/shared/colors.dart';
import 'package:azkar/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:azkar/core/widgets/loading_indicator.dart';

class QiblahCompassWidget extends StatelessWidget {
   QiblahCompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, AsyncSnapshot<QiblahDirection> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingIndicator();

          final qiblahDirection = snapshot.data!;

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: -200,
                left: -200,
                child: Opacity(
                    opacity: .2, child: Image.asset(StaticAssets.arabic)),
              ),


              Center(
                child: Transform.rotate(
                  angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: StaticAssets.qibla,
                      child: Image.asset(StaticAssets.qibla,width:  MediaQuery.of(context).size.height * 0.5,)),
                ),
              ),
              Positioned(   top: 100,

                  child: Text('أتجاه القبلة',style: TextStyle(fontSize:  MediaQuery.of(context).size.height * 0.04, color: kMainColor),)),
              Positioned(   top: 40,right: 0,

                  child:   IconButton(icon: Icon(Icons.arrow_forward,color: kMainColor),onPressed: (){Navigator.of(context).pop();},)),


            ],
          );
        },
      ),
    );
  }
}
