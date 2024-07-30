import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/popups/snackbar.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:vibration/vibration.dart';

import '../../../config/colors.dart';
import '../../../config/images.dart';
import '../../../translations/locale_keys.g.dart';
import '../../controller/cubit.dart';
import 'button.dart';

class ProductsGrid extends StatelessWidget {
  AppCubit cubit;

  ProductsGrid({
    super.key,
    required this.cubit,
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

    return SliverGrid(
        delegate: SliverChildListDelegate(List.generate(
            cubit.products.length,
                (index) =>
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "ProductDetails",
                        arguments: cubit.products[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: 10,
                        left: index % 2 == 0 ? 10 : 0,
                        right: index % 2 != 0 ? 10 : 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.fieldGrey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Image.network(
                                  cubit.products[index].image,
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
                                  left: 20,
                                  child: Text(
                                    "${(cubit.products[index].discount)
                                        .round()} % ${LocaleKeys.discount
                                        .tr()}",
                                    style: const TextStyle(
                                        fontFamily: "AppFont",
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                          Text(
                            cubit.products[index].category,
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: "AppFont"),
                          ),
                          Text(
                            cubit.products[index].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: AppColors.secondaryColor,
                                fontFamily: "AppFont"),
                          ),

                          // RatingStars(rating: cubit.products[index].rating),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${(cubit.products[index].price * (1 -
                                      cubit.products[index].discount * .01))
                                      .toStringAsFixed(0)} ${cubit
                                      .products[index].currency}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "AppFont",
                                      fontSize: 16,
                                      color: AppColors.danger),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Stack(children: [
                                    Text(
                                      "${cubit.products[index].price} ${cubit
                                          .products[index].currency}",
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: "AppFont",
                                          color: AppColors.lightGrey),
                                    ),
                                    Positioned(
                                      top: 12,
                                      child: Container(
                                        height: 1,
                                        color: AppColors.lightGrey,
                                        width: 60,
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MainButton(
                                fontSize: 14,
                                onTap: () {
                                  cubit.appCart
                                      .addToCart(cubit.products[index], 1);
                                  cubit.isCart = false;
                                  cubit.getAllProducts();
                                  cubit.getTotal();
                                  Vibration.vibrate(duration: 200);
                                },
                                text: LocaleKeys.addToCart.tr(),
                                width: 100,
                                height: 50,
                              ),
                              ViewWidget(
                                  onTap: () {
                                    cubit
                                        .addProductToFavorites(
                                        cubit.products[index].id.toString())
                                        .then((_) {
                                      defaultSnackBar(context: context,
                                          content: "Product added to fav successfully",
                                          color: AppColors.success);
                                    });
                                  },
                                  width: 40,
                                  height: 50,
                                  border: true,
                                  image: AppImages.like,
                                  iconColor: cubit.products[index].favorite == 1
                                      ? Colors.white
                                      : AppColors.lightGrey,
                                  bgColor: cubit.products[index].favorite == 1
                                      ? Colors.red
                                      : Colors.white),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ))),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0,
        ));
  }
}
