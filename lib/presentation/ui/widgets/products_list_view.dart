import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/widgets/rating.dart';
import 'package:vibration/vibration.dart';

import '../../../config/colors.dart';
import '../../../config/images.dart';

import '../../../domain/entities/product.dart';
import '../../controller/cubit.dart';
import 'button.dart';
import 'main_button.dart';


class ProductsList extends StatelessWidget {
  AppCubit cubit;
  ProductsList({
    required this.cubit
});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return  SliverList(
        delegate: SliverChildListDelegate(
          List.generate(products.length, (index) =>
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, "ProductDetails",arguments: products[index]);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: height * .25,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.fieldGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            products[index].category,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: "AppFont"),
                          ),
                          SizedBox(
                            width: 200,
                            height: 20,
                            child: Text(
                              products[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontFamily: "AppFont"),
                            ),
                          ),
                          Text(
                            "شاشة سوبر ريتينا XDR",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: "AppFont"),
                          ),
                          RatingStars(rating: products[index].rating),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Stack(children: [
                                Text(
                                  "${products[index].price} ر.س",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "AppFont",
                                      color: AppColors.lightGrey),
                                ),
                                Positioned(
                                  top: 12,
                                  child: Container(
                                    height: 1,
                                    color: AppColors.lightGrey,
                                    width: 70,
                                  ),
                                )
                              ]),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${(products[index].price-products[index].price*products[index].discount).toStringAsFixed(2)} رس",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "AppFont",
                                    fontSize: 16,

                                    color: AppColors.danger),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ViewWidget(
                                  onTap: () {},
                                  width: width * .13,
                                  height: height * .07,
                                  border: true,
                                  image: AppImages.like,
                                  iconColor: AppColors.lightGrey,
                                  bgColor: Colors.white),
                              SizedBox(width: width * .03,),
                              MainButton(
                                fontSize: 14,
                                onTap: (){
                                  cubit.appCart.addToCart(products[index], 1);
                                  cubit.getAllProducts();
                                  cubit.getTotal();
                                  cubit.isCart=false;
                                  Vibration.vibrate(duration:200);

                                },
                                text: "أضف للسلة",
                                width:150 ,
                                height: 50,
                              ),
                            ],
                          )
                        ],

                      ),
                      Stack(
                          children: [
                            Image.asset(products[index].image,
                              width: 120,
                              height: 300,
                            ),
                            Positioned(
                              top: 50,
                              left: 15,
                              child: Image.asset(AppImages.discount,
                                scale: 3,
                                fit: BoxFit.fitWidth,),
                            ),
                            Positioned(
                                top: 52,
                                left: 20,
                                child: Text(
                                  "خصم${(products[index].discount*100).round()}%",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "AppFont",
                                      color: Colors.white),
                                )),


                          ]),
                    ],
                  ),
                ),
              ),
            )
        ),
        ),
    );
  }
}
