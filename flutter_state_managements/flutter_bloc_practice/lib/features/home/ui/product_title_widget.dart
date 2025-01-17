import 'package:flutter/material.dart';
import 'package:flutter_bloc_practice/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_practice/features/home/models/home_product_data_model.dart';

class ProductTitleWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTitleWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  State<ProductTitleWidget> createState() => _ProductTitleWidgetState();
}

class _ProductTitleWidgetState extends State<ProductTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15), // Optional: for rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with opacity
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 8, // How soft the shadow looks
            offset: Offset(0, 0), // Changes position of shadow (x, y)
          ),
        ],
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    widget.homeBloc.add(HomeProductWishListButtonClickedEvent(
                        dataModel: widget.productDataModel));
                  },
                  icon: const Icon(Icons.favorite_border)),
              IconButton(
                onPressed: () {
                  widget.homeBloc.add(HomeProductCartButtonClickedEvent(
                      dataModel: widget.productDataModel));
                },
                icon: Icon(widget.productDataModel.isInCart
                    ? Icons.shopping_bag
                    : Icons.shopping_bag_outlined),
              )
            ],
          ),
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(widget.productDataModel.imageUrl))),
          ),
          Text(
            "${widget.productDataModel.id} - ${widget.productDataModel.name}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rs. ${widget.productDataModel.price}",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.productDataModel.category,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(widget.productDataModel.description),
          Text(widget.productDataModel.inStock),
        ],
      ),
    );
  }
}
