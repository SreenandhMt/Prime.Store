import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_work/features/account/presentaion/page/account_page.dart';
import 'package:main_work/features/cart/presentaion/pages/cart_page.dart';
import 'package:main_work/features/home/presentation/pages/home_page.dart';
import 'package:main_work/features/notification/presentaion/page/notification_page.dart';

import '../main.dart';

const page = [
  HomeScreen(),
  ScreenNotification(),
  ScreenAccount(),
  ScreenCartPage()
];

ValueNotifier value = ValueNotifier(0);

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context).colorScheme;
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (context,s,_) {
        return Scaffold(
          body: page[value.value],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (pag) => value.value=pag,
            currentIndex: value.value,
            selectedItemColor: theme.secondary,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: GoogleFonts.barlow(fontSize:12),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.notifications),label: "Notification"),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Account"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart")
            ],
          )
        );
      }
    );
  }
}