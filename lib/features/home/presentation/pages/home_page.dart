import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/features/account/presentaion/page/desktop%20widget/desktop_widget.dart';
import '/bottom_navigation/bottom_navigation.dart';
import '/core/theme/themes.dart';
import '../widgets/product_list.dart';
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
              AppBar(size, context),
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
                      if(state.data[index].products!.length>=4)
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
              FooterScreen(),
            ],
          ),
        );
      },
    );
  }

  Widget AppBar(Size size,BuildContext context){
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
                      currentIndex = 3;
                      value.value=2;
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
                        currentIndex = 6;
                      value.value=2;
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
                        currentIndex = 7;
                      value.value=2;
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
}


class FooterScreen extends StatefulWidget {
  @override
  State<FooterScreen> createState() => _FooterScreenState();
}

class _FooterScreenState extends State<FooterScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
              Divider(height: 1,color: Colors.black26),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeature(Icons.verified, 'Premium Quality', 'All the clothing products are made from 100% premium quality fabric.'),
                _buildFeature(Icons.lock, 'Secure Payments', 'Highly Secured SSL-Protected Payment Gateway.'),
                _buildFeature(Icons.refresh, '7 Days Return', 'Return or exchange the orders within 7 days of delivery.'),
              ],
            ),
          ),
          // Footer Information
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: size.width>=1000?CrossAxisAlignment.center:CrossAxisAlignment.start,
              children: [
               if(size.width>=1000)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Registered Office Address
                    _buildFooterColumn(
                      'REGISTERED OFFICE ADDRESS',
                      [
                        'Powerlook Apparels Pvt Ltd',
                        'Lotus Corporate Park Wing G02 - 1502,',
                        'Ram Mandir Lane, off Western Express',
                        'Highway, Goregaon, Mumbai, 400063',
                      ],
                    ),
                    
                    // Useful Links
                    _buildFooterColumn(
                      'USEFUL LINKS',
                      [
                        'About Us',
                        'Shipping Policy',
                        'Privacy Policy',
                        'Affiliate Programme',
                        'Sitemap',
                      ],
                    ),
                    
                    // Categories
                    _buildFooterColumn(
                      'CATEGORIES',
                      [
                        'T-Shirts',
                        'Shirts',
                        'Bottoms',
                        'Jacket',
                        'Co-ords',
                        'Accessories',
                      ],
                    ),
                    
                    // Support
                    _buildFooterColumn(
                      'SUPPORT',
                      [
                        'Mail: support@powerlook.in',
                        'Phone: +91 969-6333-000',
                      ],
                    ),
                  ],
                )else Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Registered Office Address
                    _buildFooterColumn(
                      'REGISTERED OFFICE ADDRESS',
                      [
                        'Powerlook Apparels Pvt Ltd',
                        'Lotus Corporate Park Wing G02 - 1502,',
                        'Ram Mandir Lane, off Western Express',
                        'Highway, Goregaon, Mumbai, 400063',
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Useful Links
                    _buildFooterColumn(
                      'USEFUL LINKS',
                      [
                        'About Us | Shipping Policy | Privacy Policy | Affiliate Programme | Sitemap'
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Categories
                    _buildFooterColumn(
                      'CATEGORIES',
                      [
                        'T-Shirts | Shirts | Bottoms | Jacket | Co-ords | Accessories',
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Support
                    _buildFooterColumn(
                      'SUPPORT',
                      [
                        'Mail: support@powerlook.in',
                        'Phone: +91 969-6333-000',
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Payment Methods & Social Media
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('100% Secure Payment'),
                    Row(
                      children: [
                        Image.network('https://www.powerlook.in/icons/payments-logo.svg?aio=w-256', height: 20),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.facebook, color: Colors.blue),
                        SizedBox(width: 10),
                        Icon(Icons.camera, color: Colors.pink),
                        SizedBox(width: 10),
                        Icon(Icons.wallet, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    final size = MediaQuery.of(context).size;
    if(size.width<=1000)
    {
      return Column(
      children: [
        Icon(icon, size: 40),
        const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
    }
    return Row(
      children: [
        Icon(icon, size: 40),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        SizedBox(width: size.width*0.15,child: Text(description, textAlign: TextAlign.start)),
          ],
        )
      ],
    );
  }

  Widget _buildFooterColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...items.map((item) => Text(item)).toList(),
      ],
    );
  }
}
