import 'dart:io';

import 'package:contacts_app/core/utils/app_assets.dart';
import 'package:contacts_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class BottomSheetHeader extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final ValueNotifier<File?> pickedImage;

  const BottomSheetHeader({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.pickedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          flex: 35,
          child: GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                pickedImage.value = File(image.path);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gold, width: 1),
                borderRadius: BorderRadius.circular(28),
              ),
              child: ValueListenableBuilder(
                valueListenable: pickedImage,
                builder: (context, image, child) {
                  if (image != null) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.file(image, fit: BoxFit.cover),
                      ),
                    );
                  } else {
                    return LottieBuilder.asset(AppAnimations.imagePicker);
                  }
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: nameController,
                builder: (context, name, child) {
                  return Text(
                    name.text.isEmpty ? 'User Name' : name.text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.gold,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
              const Divider(color: AppColors.gold),
              ValueListenableBuilder(
                valueListenable: emailController,
                builder: (context, email, child) => Text(
                  email.text.isEmpty ? 'example@email.com' : email.text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.gold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(color: AppColors.gold),
              ValueListenableBuilder(
                valueListenable: phoneController,
                builder: (context, phone, child) {
                  return Text(
                    phone.text.isEmpty ? '+200000000000' : phone.text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.gold,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
