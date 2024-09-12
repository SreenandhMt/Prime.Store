import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_work/core/theme/themes.dart';

import 'package:main_work/features/account/domain/entities/account_orders_entities.dart';
import 'package:main_work/features/account/presentaion/bloc/bloc/account_bloc.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

import '../../../notification/data/data_sources/data_source.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage(
    {super.key, required this.data,this.isEditing}
  );
  final AccountOrdersDataEntities data;
  final bool? isEditing;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  int? status;
  @override
  void initState() {
    status = int.tryParse(widget.data.status.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width<=1000)
    {
      return Scaffold(
        appBar: AppBar(title: const Text('Order Details'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: size.width*0.95,
          child: ListView(
            children: [
              SizedBox(
                width: size.width*0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          widget.data.map!.productUrls!.first, // Replace with actual image URL
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.data.map!.productAbout}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 4,
                              ),
                              const SizedBox(height: 4),
                              Text("₹${widget.data.map!.map!["price"]}"),
                              const SizedBox(height: 4),
                              if(widget.data.colors!=null&&widget.data.colors!.isNotEmpty)
                              Text('Color: ${widget.data.colors}'),
                              if(widget.data.size!=null&&widget.data.size!.isNotEmpty)
                              Text('Size: ${widget.data.size}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tracking',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    OrderTrackerZen(
                      text_primary_color: Theme.of(context).colorScheme == darkTheme.colorScheme? Colors.white : Colors.black,
                      text_secondary_color: Colors.white,
                      isShrinked: true,
                        tracker_data: [
                          if(status!>=0)
                          TrackerData(
                            title: "Order Place",
                            date: "Sat, 8 Apr '22",
                            tracker_details: [
                              TrackerDetails(
                                title: "Your order was placed on Zenzzen",
                                datetime: "Sat, 8 Apr '22 - 17:17",
                              ),
                              TrackerDetails(
                                title: "Zenzzen Arranged A Callback Request",
                                datetime: "Sat, 8 Apr '22 - 17:42",
                              ),
                            ],
                          ),
                          if(status!>=1)
                          TrackerData(
                            title: "Order Shipped",
                            date: "Sat, 8 Apr '22",
                            tracker_details: [
                              TrackerDetails(
                                title: "Your order was shipped with MailDeli",
                                datetime: "Sat, 8 Apr '22 - 17:50",
                              ),
                            ],
                          ),
                          if(status!>=2)
                          TrackerData(
                            title: "Order Delivered",
                            date: "Sat,8 Apr '22",
                            tracker_details: [
                              TrackerDetails(
                                title: "You received your order, by MailDeli",
                                datetime: "Sat, 8 Apr '22 - 17:51",
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if(status!<2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(onPressed: (){
                          if(status==null)return;
                          setState(() {
                            status = status!+1;
                          });
                          NotificationDataSource().updateNotification(status: status!, id: "", data: widget.data);
                          context.read<AccountBloc>().add(GetFavoriteData());
                        },child: const Text("Next Step"),)
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Delivery Address',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.data.buyerAddress!.name!),
                     Text(widget.data.buyerAddress!.address1!),
                     Text(widget.data.buyerAddress!.address2!),
                     Text('${widget.data.buyerAddress!.landmark!}, ${widget.data.buyerAddress!.city}, ${widget.data.buyerAddress!.state!}'),
                     Text(widget.data.buyerAddress!.postcode!),
                     const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    const Text(
                      'Store Address',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.data.sellerAddress!.address1??""),
                    Text(widget.data.sellerAddress!.address2??''),
                    Text('${widget.data.sellerAddress!.landmark}, ${widget.data.sellerAddress!.city}, ${widget.data.sellerAddress!.state}'),
                    Text(widget.data.sellerAddress!.postcode??""),
                    const SizedBox(height: 20),
                    const Text(
                      'Payment Method',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('Cash On Delivery'),
                    const SizedBox(height: 20),
                    
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                'Order Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total MRP'),
                  Text("₹${widget.data.map!.map!["price"]??"300"}"),
                ],
              ),
              const SizedBox(height: 5,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Estimated Tax'),
                  Text('₹00.00'),
                ],
              ),
              const SizedBox(height: 5,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery'),
                  Text('₹00.00'),
                ],
              ),
              const SizedBox(height: 5,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('COD Fee'),
                  Text('₹00.00'),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Order Total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${widget.data.map!.map!["price"]}.00',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width*0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: size.width*0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Order Details'),
                      Row(
                        children: [
                          Image.network(
                            widget.data.map!.productUrls!.first, // Replace with actual image URL
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                           Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  '${widget.data.map!.productName}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                ),
                                Text(
                                  '${widget.data.map!.productAbout}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 4,
                                ),
                                const SizedBox(height: 4),
                                Text("₹${widget.data.map!.map!["price"]??"300"}.0"),
                                const SizedBox(height: 4),
                                const Text('Color: Mauve Pink'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Tracking',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      OrderTrackerZen(
                      text_primary_color: Theme.of(context).colorScheme == darkTheme.colorScheme? Colors.white : Colors.black,
                      text_secondary_color: Colors.white,
                      isShrinked: true,
                        tracker_data: [
                          if(status!>=0)
                          TrackerData(
                            title: "Order Place",
                            date: "Sat, 8 Apr '22",
                            tracker_details: [
                              TrackerDetails(
                                title: "Your order was placed on Zenzzen",
                                datetime: "Sat, 8 Apr '22 - 17:17",
                              ),
                              TrackerDetails(
                                title: "Zenzzen Arranged A Callback Request",
                                datetime: "Sat, 8 Apr '22 - 17:42",
                              ),
                            ],
                          ),
                          if(status!>=1)
                          TrackerData(
                            title: "Order Shipped",
                            date: "Sat, 8 Apr '22",
                            tracker_details: [
                              TrackerDetails(
                                title: "Your order was shipped with MailDeli",
                                datetime: "Sat, 8 Apr '22 - 17:50",
                              ),
                            ],
                          ),
                          if(status!>=2)
                          TrackerData(
                            title: "Order Delivered",
                            date: "Sat,8 Apr '22",
                            tracker_details: [
                              TrackerDetails(
                                title: "You received your order, by MailDeli",
                                datetime: "Sat, 8 Apr '22 - 17:51",
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if(status!<2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(onPressed: (){
                          if(status==null)return;
                          setState(() {
                            status = status!+1;
                          });
                          NotificationDataSource().updateNotification(status: status!, id: "", data: widget.data);
                          context.read<AccountBloc>().add(GetFavoriteData());
                        },child: const Text("Next Step"),)
                      ],
                    ),
                      const SizedBox(height: 20),
                      const Text(
                        'Delivery Address',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                     Text(widget.data.buyerAddress!.name!),
                     Text(widget.data.buyerAddress!.address1!),
                     Text(widget.data.buyerAddress!.address2!),
                     Text('${widget.data.buyerAddress!.landmark!}, ${widget.data.buyerAddress!.city}, ${widget.data.buyerAddress!.state!}'),
                     Text(widget.data.buyerAddress!.postcode!),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      const Text(
                        'Store Address',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(widget.data.sellerAddress!.address1??""),
                      Text(widget.data.sellerAddress!.address2??''),
                      Text('${widget.data.sellerAddress!.landmark}, ${widget.data.sellerAddress!.city}, ${widget.data.sellerAddress!.state}'),
                      Text(widget.data.sellerAddress!.postcode??""),
                      const SizedBox(height: 20),
                      const Text(
                        'Payment Method',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text('Cash On Delivery'),
                      const SizedBox(height: 20),
                      
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width*0.20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total MRP'),
                      Text('₹${widget.data.map!.map!["price"]??"300"}.0'),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estimated Tax'),
                      Text('₹00.00'),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery'),
                      Text('₹00.00'),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('COD Fee'),
                      Text('₹00.00'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order Total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹${widget.data.map!.map!["price"]??"300"}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
