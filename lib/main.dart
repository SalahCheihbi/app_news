// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isMacOS) {
    await DesktopWindow.setMinWindowSize(const Size(
      350,
      650,
    ));
  }

  Bloc.observer = MyBlocObserver();
  DioHelper.int();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark != null));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBuissnes()
            ..getScience()
            ..getSport(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getChange(
              formShared: isDark,
            ),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              theme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800)),
                primarySwatch: Colors.red,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    titleSpacing: 20.0,
                    centerTitle: false,
                    backgroundColor: Colors.white,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black38,
                    ),
                    titleTextStyle: TextStyle(color: Colors.black),
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.black)),
              ),
              darkTheme: ThemeData(
                  textTheme: const TextTheme(
                      bodyText1: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800)),
                  primarySwatch: Colors.red,
                  scaffoldBackgroundColor: HexColor('3f453f'),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                    centerTitle: false,
                    backgroundColor: HexColor('3f453f'),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.black38,
                    ),
                    titleTextStyle: const TextStyle(color: Colors.white),
                    elevation: 0.0,
                    iconTheme: const IconThemeData(color: Colors.white),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      elevation: 0.0,
                      backgroundColor: HexColor('3f453f'),
                      unselectedItemColor: Colors.grey)),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const NewsLayout());
        },
      ),
    );
  }
}
