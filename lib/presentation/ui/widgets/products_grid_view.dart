import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/rating.dart';
import 'package:vibration/vibration.dart';


import '../../../config/colors.dart';
import '../../../config/images.dart';
import '../../../domain/entities/product.dart';
import '../../controller/cubit.dart';
import 'button.dart';


class ProductsGrid extends StatelessWidget {
  AppCubit cubit;
ProductsGrid({required this.cubit});
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return BlocBuilder(
      builder: (BuildContext context, state) { return SliverGrid(

          delegate:SliverChildListDelegate(

              List.generate(products.length, (index) => GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, "ProductDetails",arguments: products[index]);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10,left: index%2==0?10:0,right: index%2 !=0 ?10:0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.fieldGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 150,
                              width: double.infinity,

                              child: Image.asset(
                                products[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                top: 10,
                                left: 10,
                                child: Image.asset(
                                  AppImages.discount,
                                  scale: 3,
                                )),
                            Positioned(
                                top: 12,
                                left: 15,
                                child: Text(
                                  "خصم${(products[index].discount*100).round()}%",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "AppFont",
                                      color: Colors.white),
                                )),
                          ],
                        ),

                        Text(
                          products[index].category,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: "AppFont"),
                        ),
                        Text(
                          products[index].name,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontFamily: "AppFont"),
                        ),
                        Text(
                          "شاشة سوبر ريتينا XDR",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: AppColors.lightGrey,
                              fontFamily: "AppFont"),
                        ),
                        RatingStars(rating:products[index].rating),
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
                          children: [
                            ViewWidget(
                                onTap: (){},
                                width:40 ,
                                height: 50,
                                border: true,
                                image: AppImages.like,
                                iconColor: AppColors.lightGrey,
                                bgColor: Colors.white),
                            MainButton(
                              fontSize: 14,
                              onTap: (){
                                cubit.appCart.addToCart(products[index], 1);
                                cubit.isCart=false;
                                cubit.getAllProducts();
                                cubit.getTotal();
                                Vibration.vibrate(duration:200);


                              },
                              text: "أضف للسلة",
                              width:100 ,
                              height: 50,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
          ), gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 0,
      )
      ); },
    );

  }
}
