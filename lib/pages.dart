import 'package:flutter/material.dart';
import 'package:gptva/src/src.dart';

// Define an enum called Pages
enum Pages {
  // Define an enum value splash with "splash" as the route name and SplashScreen as the page
  splash("splash", SplashScreen()),
  // Define an enum value home with "home" as the route name and HomePage as the page
  home("home", HomePage());
  // Declare the routeName and page properties
  final String routeName;
  final Widget page;
  // Constructor for the Pages enum
  const Pages(this.routeName, this.page);
  // Asynchronous function to replace the current route with a new route
  Future<dynamic> pushReplacement(BuildContext context) async {
    return await Navigator.pushReplacementNamed(context, routeName);
  }
  // Getter for the route map
  Map<String, Widget Function(BuildContext)> get route =>
      {routeName: (context) => page};
}