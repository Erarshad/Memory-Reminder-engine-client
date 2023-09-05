import 'package:calmwheel/const/const.dart';
import 'package:calmwheel/views/dashboard.dart';
import 'package:calmwheel/views/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiProvider(
          providers: [
             ChangeNotifierProvider(create: (_) => DashboardViewModel()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: secondarythemeColor),
              useMaterial3: true,
              fontFamily: fontFamily
            ),
            home: const DashBoard(),
          ));
    });
  }
}
