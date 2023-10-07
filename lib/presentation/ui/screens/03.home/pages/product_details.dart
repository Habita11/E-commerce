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
                  IconButton(
                      onPressed: () {
                      },
                      icon: Image.asset(AppImages.share,scale: 2,color: Colors.black,)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context,"HomeScreen");
                        cubit.currentIndex = 1;
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
                ],
              ),
              centerTitle: true,
              elevation: 0,
              title: const Text(
                "تفاصيل المنتج",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "AppFont",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context,"HomeScreen");
                      cubit.currentIndex = 3;
                    },
                    icon: const Icon(Icons.arrow_forward_outlined,color: Colors.black,)
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: height * .4,
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.fieldGrey),
                          borderRadius: BorderRadius.circular(10)),
                      child: PhotoView(imageProvider: AssetImage(product.image),
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
                                child: Image.asset(
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
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "تم شراؤه",
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
                                  text: "مرة",
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontFamily: "AppFont")),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Image.asset(
                          AppImages.fire,
                          scale: 3,
                        ),
                        const VerticalSeparator(),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "المتبقي",
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
                                  text: "وحدة",
                                  style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontFamily: "AppFont")),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Image.asset(
                          AppImages.sent,
                          scale: 3,
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "موبايل ابل ايفون 11 بشريحتين لاتصال وذاكرة داخلية 64 جيجا ويدعم تقنية شبكة الجيل الرابع ال تي اي مع تطبيق فيس تايم، بنفسجي، النسخة العالمية",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "AppFont",
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "المجموع :",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
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
                            "حدد الكمية :",
                            textDirection: TextDirection.rtl,
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
                          "${(product.price * (1 - product.discount) * quantity).toStringAsFixed(2)} ر.س",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
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
                      text: "أضف للسلة",
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
                    const Text(
                      "مميزات المنتج",
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
                                    cells: [
                                      const DataCell(Center(
                                        child: Text(
                                          "أبل",
                                          style: TextStyle(
                                              color: AppColors.secondaryColor,
                                              fontFamily: "AppFont",
                                              fontSize: 16),
                                        ),
                                      )),
                                      const DataCell(Center(
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
