import 'package:flutter/material.dart';
import 'package:quick_cart/Views/login.dart';
import 'package:quick_cart/Views/signUp.dart';
import 'package:quick_cart/Views/splash.dart';
import 'package:provider/provider.dart';
import 'package:quick_cart/Providers/appProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create: (_)=> AppProvider())
      ],
      child: MaterialApp(
        title: 'Quick Cart',
        onGenerateRoute: (RouteSettings settings){
          Map<String,Widget> pages={
            "splash":Splash(),
            "login":Login(),
            "signUp":SignUp()
          };

          var pageToShow = pages[settings.name] ?? Splash();

          if (settings.name == "/") {
            pageToShow = Splash();
          } else if (settings.name == "/login") {
            pageToShow = Login();
          } else if (settings.name == "/signUp") {
            pageToShow = SignUp();
          }
        return MaterialPageRoute(builder: (ctx)=>pageToShow,settings: settings );

        },
        home: const Splash(),
      ),
    );
  }
}
