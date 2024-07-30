import 'package:flutter/material.dart';
import 'package:matjary/presentation/ui/widgets/main_text.dart';

import '../../../../../config/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
              Spacer(),
              Column(
                children: [
                  MainText(
                    text: "محمد حبيته",
                    color: Colors.black,
                  ),
                  MainText(
                      text: "201006320722+",
                      color: AppColors.primaryColor,
                      fontSize: 14),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!,
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2))
                ]),
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                      height: 30,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0,right: 10),
                            child: MainText(
                              text: "طلباتي",
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.propane_tank_outlined),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
