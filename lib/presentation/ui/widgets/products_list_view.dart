import 'package:flutter/material.dart';
import 'package:matjary/data/data_source.dart';
import 'package:matjary/presentation/ui/widgets/rating.dart';
import 'package:vibration/vibration.dart';

import '../../../config/colors.dart';
import '../../../config/images.dart';

import '../../controller/cubit.dart';
import 'button.dart';
import 'main_button.dart';


class ProductsList extends StatelessWidget {
  AppCubit cubit;
  ProductsList({super.key, 
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
          List.generate(cubit.products.length, (index) =>
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, "ProductDetails",arguments: cubit.products[index]);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
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
                            cubit.products[index].category,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: "AppFont"),
                          ),
                          SizedBox(
                            width: 200,
                            height: 20,
                            child: Text(
                              cubit.products[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontFamily: "AppFont"),
                            ),
                          ),
                          const Text(
                            "شاشة سوبر ريتينا XDR",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: "AppFont"),
                          ),
                          RatingStars(rating: cubit.products[index].rating),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Stack(children: [
                                Text(
                                  "${cubit.products[index].price} ر.س",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
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
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${(cubit.products[index].price-cubit.products[index].price*(cubit.products[index].discount*.01)).toStringAsFixed(2)} رس",
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
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
                                  onTap: () {
                                    changeFavorites(cubit.products[index].id.toString());
                                  },
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
                                  cubit.appCart.addToCart(cubit.products[index], 1);
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
