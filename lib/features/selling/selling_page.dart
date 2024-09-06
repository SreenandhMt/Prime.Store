import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '/features/account/presentaion/bloc/selling/sell_bloc.dart';
import '/features/home/domain/entities/home_entitie.dart';
import '/main.dart';

const height10 = SizedBox(
  height: 10
);
final colorsController = TextEditingController(),
    sizeController = TextEditingController(),
    productAboutController = TextEditingController(),
    productNameController = TextEditingController(),
    productHighController = TextEditingController(),
    productTypeController = TextEditingController(), price = TextEditingController();

class SellingPage extends StatefulWidget {
  const SellingPage({
    Key? key,
    this.data,
  }) : super(key: key);
  final HomeDataEntities? data;

  @override
  State<SellingPage> createState() => _SellingPageState();
}

class _SellingPageState extends State<SellingPage> {
  List<XFile?> images = [];
  List<dynamic> imageurl=[];
  List<String> colors = [];
  List<String> selectedSize = [];

  @override
  void initState() {
    if(widget.data!=null)
    {
      load();
    }
    super.initState();
  }

  void load() {
   try {
      imageurl = widget.data!.productUrls!;
    productNameController.text = widget.data!.productName!;
    productTypeController.text = widget.data!.map!["productType"]??"";
    productAboutController.text = widget.data!.productAbout!;
    colors=[];
    for (var element in widget.data!.colorList!) {
      
      colors.add(element);
    }
    selectedSize=[];
    for (var element in widget.data!.sizeList!) {
      
      selectedSize.add(element);
    }
    price.text=widget.data!.map!["price"].toString();
    setState(() {});
   } catch (e) {
     
   }
  }

  int co = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<SellBloc, SellState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        if(size.width>=1000)
        {
          return SizedBox(
            child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                      onTap: () async {
                        final daa = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (daa == null) return;
                        images.add(daa);
                        setState(() {});
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Icon(Icons.add_a_photo_rounded),
                        ),
                      )),
                ),
                if(widget.data==null)
                Wrap(
                  children: List.generate(
                      images.length,
                      (index) => GestureDetector(
                          onTap: () =>
                              setState(() => images.removeAt(index)),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: FileImage(
                                        File(images[index]!.path)))),
                            child: const Center(
                              child: Icon(Icons.delete),
                            ),
                          ))),
                )else Wrap(
                  children: List.generate(
                      imageurl.length,
                      (index) => GestureDetector(
                          onTap: () =>
                              setState(() => imageurl.removeAt(index)),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(imageurl[index]))),
                            child: const Center(
                              child: Icon(Icons.delete),
                            ),
                          ))),
                ),
                height10,
                TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "Prodect Name"),
                ),
                height10,
                TextFormField(
                  controller: productAboutController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "Prodect About"),
                  maxLines: 4,
                  maxLength: 60,
                ),
                height10,
                TextFormField(
                  controller: productHighController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "Prodect Highlighats"),
                  maxLines: 6,
                  maxLength: 60,
                ),
                height10,
                TextFormField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "Price"),
                ),
                height10,
                height10,
                TextFormField(
                  controller: productTypeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "Product Type"),
                ),
                height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LimitedBox(
                        maxWidth: ((size.width / 2) * 0.95)/2,
                        child: TextFormField(
                          controller: sizeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              hintText: "Prodect Sizes",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedSize
                                          .add(sizeController.text);
                                    });
                                  },
                                  icon: const Icon(Icons.add))),
                        )),
                    LimitedBox(
                        maxWidth: ((size.width / 2) * 0.95)/2,
                        child: TextFormField(
                          onChanged: (value) {
                            int? data =
                                int.tryParse(colorsController.text);
                            if (data == null || data > 15) return;
                            setState(() {
                              co = data;
                            });
                          },
                          controller: colorsController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              hintText: "Colors",
                              prefixIcon: Icon(
                                Icons.circle_rounded,
                                color: Colors.primaries[co],
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (colorsController.text.isNotEmpty) return;
                                    setState(() {
                                      colors.add(colorsController.text);
                                    });
                                  },
                                  icon: const Icon(Icons.add))),
                          keyboardType: TextInputType.number,
                        ))
                  ],
                ),
                if (colors.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Seleted Colors"),
                  ),
                Wrap(
                  children: List.generate(
                      colors.length,
                      (index) => GestureDetector(
                        onTap: () {
                          colors.removeAt(index);
                          setState(() {});
                        },
                        child:Text(colors[index]),
                      )),
                ),
                if (selectedSize.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Seleted Colors"),
                  ),
                Wrap(
                  children: List.generate(
                      selectedSize.length,
                      (index) => GestureDetector(
                        onTap: () {
                          selectedSize.removeAt(index);
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.all(6),
                              width: 70,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey),
                              child: Center(
                                child: Text(
                                  selectedSize[index].toString(),
                                  style: GoogleFonts.archivoBlack(),
                                ),
                              ),
                            ),
                      )),
                ),
                height10,
                GestureDetector(
                    onTap: () async {
                      if(price.text.isEmpty)return;
                      if(widget.data!=null){
                        context.read<SellBloc>().add(UpdateProducts(
                          id: widget.data!.productId!,
                          price: int.parse(price.text),
                          colorsList: colors,
                          imageList: imageurl.map((e) => e.toString(),).toList(),
                          productAbout: productAboutController.text,
                          productName: productNameController.text,
                          sellerId: widget.data!.sellerId!,
                          productType:productTypeController.text,
                          sizeList: selectedSize));
                          return;
                      }
                      
                      context.read<SellBloc>().add(Sell(
                          price: int.parse(price.text),
                          colorsList: colors,
                          imageList: images,
                          productAbout: productAboutController.text,
                          productName: productNameController.text,
                          producthigh: productHighController.text,
                          productType:productTypeController.text,
                          sizeList: selectedSize));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Colors.green,
                                Color.fromARGB(255, 133, 185, 124)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Center(
                        child: Text(
                          "Upload",
                          style: TextStyle(
                              color: theme.background,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
        }
        if(state is Uploading) return const Center(child: CupertinoActivityIndicator(radius: 10,),);
        return Scaffold(
          appBar: AppBar(actions: [
            IconButton(onPressed: (){
              if(widget.data!=null)
              {
                context.read<SellBloc>().add(Delete(id: widget.data!.productId!));
                // Navigator.pop(context);
              }
            }, icon: Icon(Icons.delete,color: theme.error,))
          ],),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: GestureDetector(
                            onTap: () async {
                              final daa = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (daa == null) return;
                              images.add(daa);
                              setState(() {});
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Icon(Icons.add_a_photo_rounded),
                              ),
                            )),
                      ),
                      if(widget.data==null)
                      Wrap(
                        children: List.generate(
                            images.length,
                            (index) => GestureDetector(
                                onTap: () =>
                                    setState(() => images.removeAt(index)),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(images[index]!.path)))),
                                  child: const Center(
                                    child: Icon(Icons.delete),
                                  ),
                                ))),
                      )else Wrap(
                        children: List.generate(
                            imageurl.length,
                            (index) => GestureDetector(
                                onTap: () =>
                                    setState(() => imageurl.removeAt(index)),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(imageurl[index]))),
                                  child: const Center(
                                    child: Icon(Icons.delete),
                                  ),
                                ))),
                      ),
                      height10,
                      TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            hintText: "Prodect Name"),
                      ),
                      height10,
                      TextFormField(
                        controller: productAboutController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            hintText: "Prodect About"),
                        maxLines: 4,
                        maxLength: 500,
                      ),
                      height10,
                      TextFormField(
                        controller: productHighController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            hintText: "Prodect Highlighats"),
                        maxLines: 6,
                        maxLength: 60,
                      ),
                      height10,
                      TextFormField(
                        controller: price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            hintText: "Price"),
                      ),
                      height10,
                      height10,
                      TextFormField(
                        controller: productTypeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            hintText: "Product Type"),
                      ),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LimitedBox(
                              maxWidth: (size.width / 2) * 0.95,
                              child: TextFormField(
                                controller: sizeController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    hintText: "Prodect Sizes",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedSize
                                                .add(sizeController.text);
                                          });
                                        },
                                        icon: const Icon(Icons.add))),
                              )),
                          LimitedBox(
                              maxWidth: (size.width / 2) * 0.95,
                              child: TextFormField(
                                onChanged: (value) {
                                },
                                controller: colorsController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    hintText: "Colors",
                                    prefixIcon: Icon(
                                      Icons.circle_rounded,
                                      color: Colors.yellow[100],
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          if (colorsController.text.isEmpty) return;
                                          setState(() {
                                            colors.add(colorsController.text);
                                          });
                                        },
                                        icon: const Icon(Icons.add))),
                                keyboardType: TextInputType.number,
                              ))
                        ],
                      ),
                      if (colors.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Seleted Colors"),
                        ),
                      Wrap(
                        children: List.generate(
                            colors.length,
                            (index) => GestureDetector(
                              onTap: () {
                                colors.removeAt(index);
                                setState(() {});
                              },
                              child:Text(colors[index]),
                            )),
                      ),
                      if (selectedSize.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Seleted "),
                        ),
                      Wrap(
                        children: List.generate(
                            selectedSize.length,
                            (index) => GestureDetector(
                              onTap: () {
                                selectedSize.removeAt(index);
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.all(6),
                                    width: 70,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey),
                                    child: Center(
                                      child: Text(
                                        selectedSize[index].toString(),
                                        style: GoogleFonts.archivoBlack(),
                                      ),
                                    ),
                                  ),
                            )),
                      ),
                    ],
                  ),
                ),
                height10,
                GestureDetector(
                    onTap: () async {
                      if(price.text.isEmpty)return;
                      if(widget.data!=null){
                        context.read<SellBloc>().add(UpdateProducts(
                          id: widget.data!.productId!,
                          price: int.parse(price.text),
                          colorsList: colors,
                          imageList: imageurl.map((e) => e.toString(),).toList(),
                          productAbout: productAboutController.text,
                          productName: productNameController.text,
                          sellerId: widget.data!.sellerId!,
                          productType:productTypeController.text,
                          sizeList: selectedSize));
                          return;
                      }
                      
                      context.read<SellBloc>().add(Sell(
                          price: int.parse(price.text),
                          colorsList: colors,
                          imageList: images,
                          productAbout: productAboutController.text,
                          productName: productNameController.text,
                          producthigh: productHighController.text,
                          productType:productTypeController.text,
                          sizeList: selectedSize));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Colors.green,
                                Color.fromARGB(255, 133, 185, 124)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Center(
                        child: Text(
                          "Upload",
                          style: TextStyle(
                              color: theme.background,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
