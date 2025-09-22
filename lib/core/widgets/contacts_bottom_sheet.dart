import 'dart:io';

import 'package:contacts_app/core/models/contact_model.dart';
import 'package:contacts_app/core/utils/app_colors.dart';
import 'package:contacts_app/core/utils/app_validator.dart';
import 'package:contacts_app/core/widgets/bottom_sheet_header.dart';
import 'package:contacts_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ContactsBottomSheet extends StatefulWidget {
  final List<Contact> contacts;
  final Function onUserAdded;

  const ContactsBottomSheet({
    super.key,
    required this.contacts,
    required this.onUserAdded,
  });

  @override
  State<ContactsBottomSheet> createState() => _ContactsBottomSheetState();
}

class _ContactsBottomSheetState extends State<ContactsBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<File?> pickedImage = ValueNotifier(null);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(
            emailController: emailController,
            nameController: nameController,
            phoneController: phoneController,
            pickedImage: pickedImage,
          ),
          Form(
            key: formKey,
            child: Column(
              spacing: 8,
              children: [
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Enter User Name ',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (name) => AppValidator.nameValidator(name),
                ),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Enter User Email ',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (email) => AppValidator.emailValidator(email),
                ),
                CustomTextFormField(
                  controller: phoneController,
                  hintText: 'Enter User Phone ',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  validator: (phone) => AppValidator.phoneValidator(phone),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.contacts.add(
                  Contact(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    image: pickedImage.value,
                  ),
                );
                widget.onUserAdded();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
              minimumSize: Size.fromHeight(56),
            ),
            child: Text(
              'Enter User',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
