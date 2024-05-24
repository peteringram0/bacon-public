//import 'package:Bacon/utils/RouteGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './utils/Auth.dart';
import './screens/home/Home.dart';
import './screens/login/Login.dart';
import './store/Store.dart';
import './utils/Updater.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  var hasPermissions = await authService.hasPermissions();
  if (!hasPermissions) {
    authService.requestPermissions();
  }

  Updater();

  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Bacon.',
        debugShowCheckedModeBanner: false,
//
//        routes: <String, WidgetBuilder>{
//          'home': (BuildContext context) => new Home(),
//          'login': (BuildContext context) => new Login()
//        },

//        initialRoute: '/',
//        onGenerateRoute: RouteGenerator.generateRoute,

        home: StreamBuilder(
          stream: authService.user,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active) {
              return snapshot.hasData ? Home() : Login();
            } else {
              return Text('');
            }
          },
        ),

      ),
    ),
  );
}
