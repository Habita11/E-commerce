import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/config/colors.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/ui/widgets/button.dart';
import 'package:matjary/presentation/ui/widgets/rating.dart';
import 'package:matjary/presentation/ui/widgets/vertical_separator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:vibration/vibration.dart';

import '../../../../../config/images.dart';
import '../../../../../domain/entities/product.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../controller/states.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leadingWidth: 100,
              toolbarHeight: 70,
              backgroundColor: Colors.white,
              leading: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context,"HomeScreen");
                          cubit.currentIndex = 0;
                        },
                        icon: const Icon(Icons.arrow_back_outlined,color: Colors.black,)
                    ),
                  ),

                ],
              ),
              centerTitle: true,
              elevation: 0,
              title:  Text(
                LocaleKeys.productDetails.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "AppFont",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context,"HomeScreen");
                      cubit.currentIndex = 2;
                      cubit.isCart = true;
                    },
                    icon: SizedBox(
                      width: 30,
                      child: Stack(children: [Image.asset(AppImages.cart_no_bg,scale: 1,color: Colors.black87,),
                        Positioned(
                          top: 0,
                          right: 2,
                          child:cubit.allProducts.isNotEmpty?Badge(
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            smallSize: 20,
                            label: Text("${cubit.allProducts.length}",style: const TextStyle(
                              color: Colors.white,
                            ),),
                          )
                              :const SizedBox(),
                        ),
                      ]
                      ),
                    )
                ),
                IconButton(
                    onPressed: () {
                    },
                    icon: Image.asset(AppImages.share,scale: 2,color: Colors.black,)),

              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height * .2,
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.fieldGrey),
                          borderRadius: BorderRadius.circular(10)),
                      child: PhotoView(imageProvider: NetworkImage(product.image),
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent
                      ),),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: height * .15,
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        slivers: [
                          SliverList(
                              delegate: SliverChildListDelegate(List.generate(
                            10,
                            (index) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: width * .25,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.fieldGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(
                                  product.image,
                                ),
                              ),
                            ),
                          ))),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      AppImages.samsung,
                      scale: 2,
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontFamily: "AppFont",
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingStars(rating: product.rating),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppImages.fire,
                          scale: 3,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        RichText(
                          text:  TextSpan(
                            children: [
                              TextSpan(
                                  text: LocaleKeys.purchased.tr(),
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontFamily: "AppFont")),
                              TextSpan(
                                text: " ",
                              ),
                              TextSpan(
                                  text: "250",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontFamily: "AppFont")),
                              TextSpan(
                                text: " ",
                              ),
                              TextSpan(
                                  text: LocaleKeys.times.tr(),
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontFamily: "AppFont")),
                            ],
                          ),
                        ),

                        const VerticalSeparator(),
                        Image.asset(
                          AppImages.sent,
                          scale: 3,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        RichText(
                          text:  TextSpan(
                            children: [
                              TextSpan(
                                  text: LocaleKeys.remaining.tr(),
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontFamily: "AppFont")),
                              TextSpan(
                                text: " ",
                              ),
                              TextSpan(
                                  text: "16",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontFamily: "AppFont")),
                              TextSpan(
                                text: " ",
                              ),
                              TextSpan(
                                  text: LocaleKeys.pieces.tr(),
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontFamily: "AppFont")),
                            ],
                          ),
                        ),


                      ],
                    ),
                     Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(product.description,
                        style: TextStyle(
                          fontFamily: "AppFont",
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                         LocaleKeys.total.tr(),

                          style: TextStyle(
                            fontFamily: "AppFont",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            LocaleKeys.quantity.tr(),

                            style: TextStyle(
                              fontFamily: "AppFont",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${(product.price * (1 - (product.discount/100)) * quantity).toStringAsFixed(0)} ${cubit.user.currency}",

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "AppFont",
                            fontSize: 20,
                            color: AppColors.danger,
                          ),
                        ),
                        const Spacer(),
                        ViewWidget(
                          bgColor: Colors.white,
                          onTap: () {
                            quantity++;
                            cubit.emit(AppChangeCartState());
                          },
                          width: 40,
                          height: 40,
                          border: true,
                          borderRdius: 5,
                          text: "+",
                          textColor: AppColors.lightGrey,
                          fontSize: 20,
                        ),
                        ViewWidget(
                          bgColor: Colors.white,
                          onTap: () {},
                          width: 40,
                          height: 40,
                          border: true,
                          borderRdius: 0,
                          text: "$quantity",
                          textColor: AppColors.lightGrey,
                          fontSize: 20,
                        ),
                        ViewWidget(
                          bgColor: Colors.white,
                          onTap: () {
                            if (quantity != 1) {
                              quantity--;
                              cubit.emit(AppChangeCartState());
                            }
                          },
                          width: 40,
                          height: 40,
                          border: true,
                          borderRdius: 5,
                          text: "-",
                          textColor: AppColors.lightGrey,
                          fontSize: 20,
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ViewWidget(
                      bgColor: AppColors.primaryColor,
                      onTap: () {
                        cubit.appCart.addToCart(product, quantity);
                        cubit.isCart = false;
                        cubit.getAllProducts();
                        cubit.getTotal();
                        Vibration.vibrate(duration: 100);
                      },
                      width: double.infinity,
                      height: 50,
                      text: LocaleKeys.addToCart.tr(),
                      image: AppImages.cart_no_bg,
                      iconColor: Colors.white,
                      fontSize: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      LocaleKeys.productDetails.tr(),
                      style: TextStyle(
                          fontFamily: "AppFont",
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.fieldGrey),
                      ),
                      child: DataTable(
                        headingRowHeight: 0,
                        dividerThickness: 0,
                        dataRowHeight: 50,
                        columns: const [
                          DataColumn(
                              label: Text(
                            "",
                            style: TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: "AppFont",
                                fontSize: 20),
                          )),
                          DataColumn(
                              label: Text(
                            "",
                            style: TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: "AppFont",
                                fontSize: 20),
                          )),
                        ],
                        rows: List.generate(
                            9,
                            (index) => DataRow(
                                    color: index % 2 != 0
                                        ? MaterialStateProperty.all(
                                            AppColors.fieldGrey)
                                        : MaterialStateProperty.all(
                                            Colors.white),
                                    cells: const [
                                      DataCell(Center(
                                        child: Text(
                                          "أبل",
                                          style: TextStyle(
                                              color: AppColors.secondaryColor,
                                              fontFamily: "AppFont",
                                              fontSize: 16),
                                        ),
                                      )),
                                      DataCell(Center(
                                        child: Text(
                                          "العلامة التجارية",
                                          style: TextStyle(
                                              color: AppColors.secondaryColor,
                                              fontFamily: "AppFont",
                                              fontSize: 16),
                                        ),
                                      )),
                                    ])),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
