import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_work/features/account/presentaion/page/account_page.dart';
import 'package:main_work/features/cart/presentaion/pages/cart_page.dart';
import 'package:main_work/features/home/presentation/pages/home_page.dart';
import 'package:main_work/features/notification/presentaion/page/notification_page.dart';

import '../core/theme/themes.dart';
import '../features/search/pages/search_page.dart';
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
  GlobalKey<ScaffoldState> scaffoldkey  = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    theme = Theme.of(context).colorScheme;
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (context,s,_) {
        if(size.width>=1000)
        {
           return Scaffold(
            key: scaffoldkey,
          body: page[value.value],
          // bottomNavigationBar: BottomNavigationBar(
          //   onTap: (pag) => value.value=pag,
          //   currentIndex: value.value,
          //   selectedItemColor: theme.secondary,
          //   unselectedItemColor: Colors.grey,
          //   showUnselectedLabels: true,
          //   selectedLabelStyle: GoogleFonts.barlow(fontSize:12),
          //   items: const [
          //     BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          //     BottomNavigationBarItem(icon: Icon(Icons.notifications),label: "Notification"),
          //     BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Account"),
          //     BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart")
          //   ],
          // )
        );
        }
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
  Widget AppBar(Size size,BuildContext context){
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    width10,
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        scaffoldkey.currentState!.openDrawer();
                      },
                      child: SizedBox(
                        child: Center(child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:4,top: 4),
                            child: Text("STORE",style: textTheme(size.width<=1000?size.width*0.06:size.width*0.027,theme.brightness == Brightness.dark?Colors.green:Colors.yellow)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3,top: 3),
                            child: Text("STORE",style: textTheme( size.width<=1000?size.width*0.06:size.width*0.027,Colors.pinkAccent)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2,top: 2),
                            child: Text("STORE",style: textTheme(size.width<=1000?size.width*0.06:size.width*0.027,theme.brightness== Brightness.dark?Colors.green:Colors.deepPurple)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1,top: 1),
                            child: Text("STORE",style: textTheme(size.width<=1000?size.width*0.06:size.width*0.027,Colors.black)),
                          ),
                          Text("STORE",style: textTheme(size.width<=1000?size.width*0.06:size.width*0.027,theme.brightness == Brightness.dark?Colors.white:theme.secondary)),
                        ],
                      ),),),
                    ),
                    const Expanded(child: SizedBox()),
                    LimitedBox(
                        maxWidth: (size.width * 0.45),
                        maxHeight: 100,
                        child: CupertinoSearchTextField(
                          keyboardType: TextInputType.none,
                          padding: const EdgeInsets.all(15),
                          itemSize: 25,
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchPage(),)),
                        )),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        value.value=2;
                      },
                      icon: const Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                    width10,
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        value.value=2;
                      },
                      icon: const Icon(
                        Icons.shopping_bag_rounded,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                    width10,
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        value.value=1;
                      },
                      icon: const Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                     width10,
                    PopupMenuButton(
                      child: CircleAvatar(radius: 14,),
                      itemBuilder: (context) {
                      return [
                        PopupMenuItem(child: Text("Profile")),
                        PopupMenuItem(child: Text("Orders")),
                        PopupMenuItem(child: Text("wishlist")),
                        PopupMenuItem(child: Text("logout"))
                      ];
                    },),
                    width10,
                  ],
                ),
    );
  }
}


