import 'package:flutter/material.dart';

import 'package:main_work/features/account/domain/entities/account_orders_entities.dart';
import 'package:main_work/features/account/presentaion/widgets/order_detail.dart';

class ShopOrderSummary extends StatelessWidget {
  const ShopOrderSummary({
    Key? key,
    required this.data,
  }) : super(key: key);
  final AccountOrdersDataEntities data;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 6),
            color:data.status=="0"?Colors.green.shade100:data.status=="1"?Colors.yellow.shade100:data.status=="2"?Colors.green.shade200:Colors.red.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.status=="0"?"Order Place" :data.status=="1"? "Order Shipped":data.status=="2"?"Order Delivered":data.status.toString(),
                  style: TextStyle(
                   color: data.status=="0"?Colors.green.shade500:data.status=="1"?Colors.yellow:data.status=="2"?Colors.green.shade700:Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: size.width*0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${data.map!.productName}',
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        'Item(s) 1',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                // Product Image
                Image.network(
                  data.map!.productUrls!.first??"", // Replace with your image URL
                  height: 100,
                  width: 100,
                ),
                const SizedBox(width: 10),
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.map!.productAbout!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                      "₹${data.map!.map!["price"]??""}.00",
                        style: const TextStyle(
                        ),
                      ),
                      Text(
                        'Color: ${data.colors}, Size: ${data.size}, 1 Item(s)',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'SKU 1126021-S',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderDetailsPage(data: data,isEditing: true,),));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: data.status=="0"?Colors.green.shade300:data.status=="1"?Colors.yellow.shade300:data.status=="2"?Colors.green.shade400:Colors.red.shade300,
                  ),
                  child: const Text('VIEW DETAILS'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Order Number and Date
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #001457490',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Placed on 30 Aug, 2024',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
