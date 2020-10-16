
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sedc/food_list.dart';
import 'package:sedc/splash_sceen.dart';

import 'bloc/food_bloc.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return BlocProvider<FoodBloc>(
      create: (context) => FoodBloc(),
    child: MultiProvider(
      providers:[
       Provider(create: (context) => FoodList(),),
      ],
          child: MaterialApp(
        localizationsDelegates: [
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
   GlobalCupertinoLocalizations.delegate,
 ],
 
 supportedLocales: [
   Locale('ar' , '')
 ],
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    )
    );
    
  }

  CartService() {}
    
}

