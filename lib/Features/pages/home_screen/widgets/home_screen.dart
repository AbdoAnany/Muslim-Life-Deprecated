// @dart=2.9

import 'dart:ui';

import 'package:azkar/Features/bloc/main_bloc/main_bloc.dart';
import 'package:azkar/Features/bloc/main_bloc/main_state.dart';
import 'package:azkar/core/shared/styles.dart';
import 'package:azkar/core/utils/assets.dart';
import 'package:azkar/core/utils/drawer.dart';
import 'package:azkar/core/utils/size_config.dart';
import 'package:azkar/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azkar/core/shared/colors.dart';
import 'package:hijri/hijri_calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainBloc prayer = MainBloc.get(context);
        var today = HijriCalendar.now();
        HijriCalendar.now();
        HijriCalendar.setLocal('ar');
        return SafeArea(
          child: Scaffold(
            body: Directionality(
            // add this
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                Positioned(
                  bottom:  -SizeConfig.screenHeight*.3,
                  left: -SizeConfig.screenWidth*.5,
                  child: Opacity(
                      opacity: .35, child: Image.asset(StaticAssets.arabic)),
                ),
                Positioned(
                  top:  -SizeConfig.screenHeight*.3,
                  right: -SizeConfig.screenWidth*.5,
                  child: Opacity(
                    opacity: .35,
                    child: Hero(
                        tag: StaticAssets.arabic,
                        child: Image.asset(StaticAssets.arabic)),
                  ),
                ),
                Column(children: [
                  prayer.prayList.isEmpty
                      ?    Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //   CircularProgressIndicator(),
                        InkWell(onTap: (){
                          prayer.getPrayTime();
                        },
                          child: Text(
                            prayer.textState,
                            style: LightText(),
                          ),
                        )
                      ],
                    ),
                  )
                      : GestureDetector(
                    onTap: (){
                      prayer.getPrayTime();
                    },
                    child: Container(
                        height: 200,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: kMainColor,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffb0c168),
                                  Color(0xff57b78f),
                                  Color(0xff0fafaf),
                                  Colors.teal
                                ]),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400],
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                  offset: Offset(0, 4)),
                            ],
                            borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10,),
                            Expanded(flex:3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 8, bottom: 20),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${today.fullDate()}",textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontSize:18,
                                          color: kWhite),
                                    ),Spacer(),
                                    Text(
                                      prayer.prayList.first.meta
                                          .timezone
                                          .split('/')[1],
                                      style: TextStyle(
                                          color: kWhite,
                                          fontSize: 20),
                                    ),
                              SizedBox(width: 10,)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex:2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 8),
                                child: Text(
                                  'مواقيت الصلاة',
                                  style: TextStyle(
                                      color: kWhite,
                                      fontSize:
                                      24),
                                ),
                              ),
                            ),
                            Expanded(flex:4,
                              child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: List.generate(
                                    6,
                                        (index) =>     Expanded(flex:1,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Text(
                                          prayer.prayerName['$index']
                                              .toString() +
                                              '\n' +
                                              prayer.prayList.first
                                                  .timings.pray[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: kWhite,
                                              fontSize:
                                              SizeConfig.screenWidth *
                                                  .05),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            // SizedBox(height: 10,)
                          ],
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 20),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: DrawerUtils.items.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                DrawerUtils.items[index]['route']),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              boxShadow: [
                                // BoxShadow(
                                //     color: Colors.grey[400],
                                //     blurRadius: 8,
                                //     spreadRadius: 1,
                                //     offset: Offset(4, 4)),
                                BoxShadow(
                                    color: Colors.grey[200],
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: Offset(0, 8)),
                              ],
                              border: Border.all(color: kMainColor, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Expanded(flex: 4,
                                child: Hero(
                                    tag: DrawerUtils.items[index]['imagePath'],
                                    child: Image.asset(
                                      DrawerUtils.items[index]['imagePath'],
                                      height: SizeConfig.screenHeight * .1,
                                    )),
                              ),
                              Text(
                                DrawerUtils.items[index]['title'],
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: SizeConfig.screenWidth * .05),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],),
                Align(alignment: Alignment.bottomCenter,
                  child: Text('النسخة 1.0.9',style: TextStyle(color: Colors.blueGrey ),),
                )
              ],
            ),
          ),),
        );
      },
    );
  }

  //SliderWidget

//Header Time

}
