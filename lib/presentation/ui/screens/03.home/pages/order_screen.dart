import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matjary/data/data_source.dart';
import 'package:matjary/presentation/controller/cubit.dart';
import 'package:matjary/presentation/ui/popups/snackbar.dart';
import 'package:matjary/presentation/ui/widgets/main_button.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';
import 'package:matjary/presentation/ui/widgets/text_field.dart';

import '../../../../../config/colors.dart';
import '../../../../../domain/entities/product.dart';
import '../../../../controller/states.dart';

class OrderScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List order = [];

  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    List<Product> products = cubit.allProducts.keys.toList();
    List quantities = cubit.allProducts.values.toList();
    cubit.allProducts.forEach((key, value) {
      order.add({"product_id": "${key.id}", "quantity": value});
    });
    print(order);

    nameController.text = cubit.user.name;
    phoneController.text = "+${cubit.user.countryCode} 1006320722";
    addressController.text = "المنصورة-جديله-دوران جديله-الجامع الكبير";
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    title: const MainText(
                      text: 'تفاصيل الطلب',
                      color: AppColors.secondaryColor,
                    ),
                    toolbarHeight: 60,
                    actions: [
                      IconButton(
                          onPressed: () {
                            cubit.currentIndex = 1;
                            Navigator.pushReplacementNamed(
                                context, "HomeScreen");
                          },
                          icon: const Icon(
                            Icons.arrow_forward_outlined,
                            color: AppColors.secondaryColor,
                          ))
                    ],
                    leadingWidth: 0,
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(List.generate(
                          products.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.fieldGrey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            MainText(
                                              text: products[index].name,
                                              fontSize: 16,
                                              color: AppColors.secondaryColor,
                                            ),
                                            MainText(
                                              text:
                                                  "الكمية : ${quantities[index]}",
                                              color: AppColors.secondaryColor,
                                              fontSize: 16,
                                            ),
                                            MainText(
                                              text:
                                                  "المجموع : ${((products[index].price * quantities[index]) * (1 - products[index].discount / 100)).toStringAsFixed(2)} ر.س",
                                              color: AppColors.secondaryColor,
                                              fontSize: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Image.network(
                                          products[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )))),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${cubit.getTotal().toStringAsFixed(2)} ر.س",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              color: AppColors.danger,
                              fontFamily: "AppFont",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "الإجمالي : ",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "AppFont"),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(),
                  )),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const MainText(
                            text: "تأكيد البيانات",
                            color: AppColors.secondaryColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultFormField(
                              controller: nameController,
                              hintText: "أدخل اسم المستخدم",
                              suffixIcon: const Icon(Icons.person_2_outlined),
                              label: "اسم المستخدم"),
                          DefaultFormField(
                              controller: phoneController,
                              hintText: "أدخل رقم الهاتف",
                              suffixIcon: const Icon(Icons.phone_enabled_outlined),
                              label: "رقم الهاتف"),
                          DefaultFormField(
                              controller: addressController,
                              hintText: "أدخل العنوان",
                              suffixIcon: const Icon(Icons.location_city_outlined),
                              label: "العنوان"),
                          const SizedBox(
                            height: 10,
                          ),
                          MainButton(
                              text: "تأكيد الطلب",
                              onTap: () {
                                addAddress(
                                        title: nameController.text,
                                        address: addressController.text,
                                        phone: phoneController.text,
                                        countryCode: "20")
                                    .then((_) {
                                  placeOrder(order).then((_) {
                                    defaultSnackBar(
                                        context: context,
                                        content: "تم تأكيد الطلب بنجاح",
                                        color: AppColors.success);
                                    cubit.clearCart();

                                    Navigator.pushReplacementNamed(
                                        context, "HomeScreen");
                                    cubit.currentIndex = 0;
                                  });
                                });
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
