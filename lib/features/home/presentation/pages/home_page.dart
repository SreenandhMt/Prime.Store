import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/presentation/pages/product_list.dart';
import '/features/search/pages/search_page.dart';
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
    final appColor = Theme.of(context).colorScheme.secondary;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: ListView(
            children: [
              const SizedBox(height: 10,),
              AppBar(size, context),
              const SizedBox(
                height: 10,
              ),
              LimitedBox(
                  maxHeight: size.width*0.5,
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
                            if(loading)return;
                            if(userCliked)
                            {
                              loading=true;
                              await Future.delayed(const Duration(seconds: 15),() {
                                userCliked=false;
                                loading=false;
                                // _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
                              },);
                              return;
                            }
                            if(value==10)
                            {
                              _pageController.jumpTo(0);
                            }
                            await Future.delayed(const Duration(seconds: 15),() => _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.bounceIn),);
                          },
                          children:
                              List.generate(11, (index) => index==10?const SizedBox():const HomeBanner()),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 10,
                            effect: ColorTransitionEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                spacing: 5,
                                dotColor: Colors.grey.shade700,
                                activeDotColor: Colors.white),
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
                child: Row(
                  children: [
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.verified,
                    //       color: appColor,
                    //     )),
                    CircleAvatar(radius: 15,backgroundImage: NetworkImage(state.data[index].imageUrl!)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      state.data[index].shopName!,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Expanded(child: SizedBox()),
                    if(state.data[index].products!.length>=4)
                    GestureDetector(
                      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductList(data: state.data[index].products!),)),
                      child: Text(
                        "See More",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: appColor),
                      ),
                    ),
                  ],
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
              )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget AppBar(Size size,BuildContext context){
    return Row(
                children: [
                  width10,
                  SizedBox(
                    child: Center(child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:4,top: 4),
                        child: Text("STORE",style: TextStyle(fontSize:  size.width*0.06,fontWeight: FontWeight.bold,color: theme.brightness == Brightness.dark?Colors.green:Colors.yellow)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3,top: 3),
                        child: Text("STORE",style: TextStyle(fontSize: size.width*0.06,fontWeight: FontWeight.bold,color: Colors.pinkAccent)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2,top: 2),
                        child: Text("STORE",style: TextStyle(fontSize: size.width*0.06,fontWeight: FontWeight.bold,color: theme.brightness== Brightness.dark?Colors.green:Colors.deepPurple)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1,top: 1),
                        child: Text("STORE",style: TextStyle(fontSize: size.width*0.06,fontWeight: FontWeight.bold,color: Colors.black)),
                      ),
                      Text("STORE",style: TextStyle(fontSize: size.width*0.06,fontWeight: FontWeight.bold,color: theme.brightness == Brightness.dark?Colors.white:theme.secondary),),
                    ],
                  ),),),
                  width10,
                  LimitedBox(
                      maxWidth: (size.width * 0.52),
                      maxHeight: 100,
                      child: CupertinoSearchTextField(
                        padding: const EdgeInsets.all(15),
                        itemSize: 25,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchPage(),)),
                      )),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(
                      Icons.shopping_bag_rounded,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  width10,
                  const Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.grey,
                  ),
                ],
              );
  }
}
