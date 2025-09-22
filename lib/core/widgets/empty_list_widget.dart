import 'package:contacts_app/core/utils/app_assets.dart';
import 'package:contacts_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LottieBuilder.asset(AppAnimations.emptyList),
        Text(
          'There is No Contacts Added Here',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.gold,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
