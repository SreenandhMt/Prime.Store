import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentaion/page/auth_page.dart';
import '../widgets/info_widget.dart';
import '/bottom_navigation/bottom_navigation.dart';
import '/core/theme/themes.dart';
import '../widgets/product_list.dart';
import '../widgets/search_page.dart';
import '/main.dart';
import 'package:redacted/redacted.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_feed/home_list_feed.dart';
import '../widgets/home_widgets.dart';
import '/features/home/presentation/widgets/category.dart';
import '/features/home/presentation/widgets/home_banner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const width10 = SizedBox(
  width: 10,
);
final urls = [
  "https://cdn-media.powerlook.in/mycustomfolder/banner_10_.jpg?aio=w-1200",
  "https://cdn-media.powerlook.in/mycustomfolder/banner-1_3_.jpg?aio=w-1200"
];
bool userCliked=false,userClikedLeft=false,loading=false;

PageController _pageController = PageController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(GetData());
    final size = MediaQuery.of(context).size;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: ListView(
            children: [
              const SizedBox(height: 10,),
              if(size.width>=1000)
              appBarForWeb(size,context)
              else
              appBar(size, context),
              const SizedBox(
                height: 10,
              ),
              LimitedBox(
                  maxHeight: size.height*0.3,
                  maxWidth: double.infinity,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onHorizontalDragEnd: (details) => userCliked=true,
                        onHorizontalDragStart: (details) => setState(() {
                          userCliked=true;
                        }),
                        child: PageView(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) async{
                            // _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
                            
                          },
                          children:
                              List.generate(2, (index) => index==10?const SizedBox(): HomeBanner(url: urls[index],)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 2,
                            onDotClicked: (index) {
                              _pageController.animateTo(index-1,duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
                            },
                            effect: ColorTransitionEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                spacing: 5,
                                dotColor: Colors.grey.shade700,
                                activeDotColor: Colors.green),
                          ),
                        ),
                      )
                    ],
                  )),
              const CategoryWidget(),
              if(state is HomeData)
              Column(
                children: List.generate(state.data.length, (index) => Column(
                  children: [
                    Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width<=1000?null:size.width*0.7,
                  child: Row(
                    children: [
                      CircleAvatar(radius: 15,backgroundImage: NetworkImage(state.data[index].imageUrl!)),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        state.data[index].shopName!,
                        style: mainAppTextTheme(20.0),
                      ),
                      const Expanded(child: SizedBox()),
                      if(state.data[index].products!.length>4&&size.width<=1000)
                      GestureDetector(
                        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(data: state.data[index].products!),)),
                        child: Text(
                          "See More",
                          style: mainAppTextTheme(15.0),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              HomeProductListWidget(data: state.data[index],),
                  ],
                )),
              )else
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar().redacted(context: context, redact: false),
                        width10,
                    Container(width: 90,height: 20,decoration: BoxDecoration(color: theme.primary,borderRadius: BorderRadius.circular(10)),margin: const EdgeInsets.all(3),),
                      ],
                    ),
                  ),
                  Wrap(
                children: List.generate(4, (index) => const ProductLoadingWidget()),
              ),
                ],
              ),
              const FooterScreen(),
            ],
          ),
        );
      },
    );
  }

  Widget appBar(Size size,BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  width10,
                  SizedBox(
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
                  if(size.width>=1000)
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: (){
                      context.go("/Settings/3");
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  width10,
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: (){
                      if(size.width>=1000)
                      {
                        context.go("/Settings/6");
                        return;
                      }else{
                        value.value=3;
                        return;
                      }
                    },
                    icon: const Icon(
                      Icons.shopping_bag_rounded,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  width10,
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: (){
                      if(size.width>=1000)
                      {
                       context.go("/Settings/7");
                        return;
                      }else{
                        value.value=1;
                        return;
                      }
                    },
                    icon: const Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
  }

   Widget appBarForWeb(Size size,BuildContext context){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        width10,
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
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
                        if(snapshot.hasData)
                        iconsForAppBar()
                        else
                        MaterialButton(color: Colors.transparent,shape: Border.all(width: 2,color: Colors.red.shade200,style: BorderStyle.solid),padding: EdgeInsets.all(17),onPressed: () {
                          
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: Border.all(),
                        child: Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            width: size.width <= 1000
                                ? size.width * 0.6
                                : size.width * 0.3,
                            child: Scaffold(body: const AuthGate())),
                      ),
                    );
                  },child: Center(child: Text("SignIn",style: mainAppTextTheme(null),),),),
                  width10
                      ],
                    ),
        );
      }
    );
  }

  Widget iconsForAppBar(){
    return Row(
      children: [
        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: (){
                            context.go("/Settings/3");
                          },
                          icon: const Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        width10,
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: (){
                            context.go("/Settings/6");
                          },
                          icon: const Icon(
                            Icons.shopping_bag_rounded,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        width10,
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: (){
                            context.go("/Settings/7");
                          },
                          icon: const Icon(
                            Icons.notifications,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                         width10,
                        PopupMenuButton(
                          child: const CircleAvatar(radius: 14,),
                          padding: EdgeInsets.all(0),
                          shape: Border.all(),
                          itemBuilder: (context) {
                          return [
                            const PopupMenuItem(child: Text("Profile"),padding: EdgeInsets.only(left: 20,right: 80,bottom: 10,top: 10)),
                            const PopupMenuItem(child: Text("Orders"),padding: EdgeInsets.only(left: 20,right: 40,bottom: 10,top: 10)),
                            const PopupMenuItem(child: Text("Wishlist"),padding: EdgeInsets.only(left: 20,right: 40,bottom: 10,top: 10)),
                            const PopupMenuItem(child: Text("Logout",style: TextStyle(color: Colors.red),),padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10))
                          ];
                        },),
      ],
    );
  }
}
