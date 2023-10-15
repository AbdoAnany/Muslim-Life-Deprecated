// @dart=2.9

import 'package:azkar/Features/azkar/view/cubit/azkar_cubit.dart';
import 'package:azkar/Features/bloc/Qibla_cubit/qibla_cubit.dart';
import 'package:azkar/Features/bloc/Sibha_cubit/misbaha_cubit.dart';
import 'package:azkar/Features/bloc/bookmarks/cubit.dart';
import 'package:azkar/Features/bloc/main_bloc/main_bloc.dart';
import 'package:azkar/Features/pages/home_screen/main_screen.dart';
import 'package:azkar/core/providers/app_provider.dart';
import 'package:azkar/core/utils/size_config.dart';
import 'package:azkar/core/widgets/date_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'Features/bloc/chapter/cubit.dart';

import 'Features/pages/splash_screen.dart';
import 'core/shared/themes.dart';
import 'injection.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjectionInit();
  await Hive.initFlutter();  await Hive.openBox('app');
  //diohelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AzkarCubit()..getAzkar()),
         // BlocProvider(create: (context) => PrayerCubit()),
          BlocProvider(create: (context) => QiblaCubit()),
          BlocProvider(create: (context) => MisbahaCubit()),
          BlocProvider(create: (context) => ChapterCubit()),
          BlocProvider(create: (context) => BookmarkCubit()),
          BlocProvider(create: (context) => MainBloc()..getPrayTime()),
          BlocProvider(create: (_) => AppProvider()),


        ],
        child:MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            title: 'أدوات المسلم',
            home: SplashScreen()),);
  }
}