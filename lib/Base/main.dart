import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_cart/Views/AddRecord.dart';
import 'package:quick_cart/Views/Home.dart';
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
        debugShowCheckedModeBanner: false,
        title: 'Quick Cart',
        onGenerateRoute: (RouteSettings settings){
          Map<String,Widget> pages={
            "splash":Home(),
            "login":AddRecord(),
          };

          var pageToShow = pages[settings.name] ?? Home();

          if (settings.name == "/") {
            pageToShow = Home();
          } else if (settings.name == "/login") {
            pageToShow = AddRecord();
          }
        return MaterialPageRoute(builder: (ctx)=>pageToShow,settings: settings );

        },
        home:   Home(),
      ),
    );
  }
}
