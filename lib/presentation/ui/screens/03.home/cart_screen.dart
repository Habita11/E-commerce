import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/config/images.dart';
import 'package:matjary/domain/entities/product.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/controller/states.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';
import 'package:matjary/translations/locale_keys.g.dart';

import '../../../../config/colors.dart';
import '../../widgets/button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          List<Product> products = cubit.allProducts.keys.toList();
          return cubit.allProducts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.cartIllustration,
                        scale: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       MainText(
                        text: LocaleKeys.emptyCart.tr(),
                        color: AppColors.lightGrey,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            List.generate(
                              products.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: Stack(children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.fieldGrey),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey[50],
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.network(
                                            products[index].image,
                                            scale: 6,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                products[index].name,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: "AppFont",
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MainText(
                                              text:
                                                  "${(products[index].price * (1 - (products[index].discount / 100))).toStringAsFixed(0)} ${products[index].currency}",
                                              fontSize: 14,
                                              color: AppColors.danger,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ViewWidget(
                                                    bgColor: Colors.white,
                                                    onTap: () {
                                                      int x = cubit.allProducts[
                                                          products[index]]!;
                                                      x++;
                                                      cubit.allProducts[
                                                          products[index]] = x;
                                                      cubit.getAllProducts();
                                                      cubit.getTotal();
                                                    },
                                                    width: 40,
                                                    height: 40,
                                                    border: true,
                                                    borderRdius: 5,
                                                    text: "+",
                                                    textColor: AppColors
                                                        .secondaryColor,
                                                    fontSize: 20,
                                                  ),
                                                  ViewWidget(
                                                    bgColor: Colors.white,
                                                    onTap: () {},
                                                    width: 40,
                                                    height: 40,
                                                    border: true,
                                                    borderRdius: 0,
                                                    text:
                                                        "${cubit.allProducts[products[index]]}",
                                                    textColor: AppColors
                                                        .secondaryColor,
                                                    fontSize: 20,
                                                  ),
                                                  ViewWidget(
                                                    bgColor: Colors.white,
                                                    onTap: () {
                                                      int x = cubit.allProducts[
                                                          products[index]]!;
                                                      if (cubit.allProducts[
                                                              products[
                                                                  index]] ==
                                                          1) {
                                                        cubit.appCart
                                                            .removeFromCart(
                                                                products[
                                                                    index]);
                                                        products
                                                            .removeAt(index);
                                                        cubit.getAllProducts();
                                                        cubit.getTotal();
                                                      } else {
                                                        x--;
                                                        cubit.allProducts[
                                                            products[
                                                                index]] = x;
                                                        cubit.getAllProducts();
                                                      }
                                                    },
                                                    width: 40,
                                                    height: 40,
                                                    border: true,
                                                    borderRdius: 5,
                                                    text: "-",
                                                    textColor: AppColors
                                                        .secondaryColor,
                                                    fontSize: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 80,
                                                    child: Text(
                                                      "${((products[index].price * cubit.allProducts[products[index]]!) - (products[index].price * cubit.allProducts[products[index]]! * (products[index].discount / 100))).toStringAsFixed(0)} ${products[index].currency}",

                                                      style: const TextStyle(
                                                          overflow: TextOverflow.ellipsis,
                                                          fontFamily: "AppFont",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: SizedBox(
                                      height: 40,
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.appCart
                                              .removeFromCart(products[index]);
                                          products.removeAt(index);
                                          cubit.getAllProducts();
                                          cubit.getTotal();
                                          print(cubit.allProducts);
                                        },
                                        icon: Image.asset(
                                          AppImages.trash,
                                          color: AppColors.danger,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.total.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "AppFont"),
                                ),
                                Text(
                                  "${cubit.getTotal().toStringAsFixed(0)} ${products[0].currency}",
                                  style: const TextStyle(
                                      color: AppColors.danger,
                                      fontFamily: "AppFont",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ViewWidget(
                              bgColor: AppColors.primaryColor,
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, "OrderScreen");
                              },
                              width: double.infinity,
                              height: 50,
                              text: LocaleKeys.confirmOrder.tr(),
                              iconColor: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 75,
                          ),
                        )
                      ]),
                );
        },
        listener: (context, state) {});
  }
}
