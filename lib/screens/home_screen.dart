import 'package:contacts_app/core/models/contact_model.dart';
import 'package:contacts_app/core/utils/app_assets.dart';
import 'package:contacts_app/core/utils/app_colors.dart';
import 'package:contacts_app/core/widgets/contacts_bottom_sheet.dart';
import 'package:contacts_app/core/widgets/contacts_card.dart';
import 'package:contacts_app/core/widgets/empty_list_widget.dart';
import 'package:contacts_app/core/widgets/home_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: SvgPicture.asset(AppImages.logo),
      ),
      body: contacts.isEmpty
          ? const EmptyListWidget()
          : GridView.builder(
              itemCount: contacts.length,
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .65,
              ),
              itemBuilder: (context, index) {
                return ContactsCard(
                  contact: contacts[index],
                  removeContact: () => _removeContact(index),
                );
              },
            ),
      floatingActionButton: HomeActionButtons(
        contacts: contacts,
        addContact: _openModalBottomSheet,
        removeContact: _removeLastContact,
      ),
    );
  }

  void _removeContact(int index) {
    contacts.removeAt(index);
    setState(() {});
  }

  void _removeLastContact() {
    contacts.removeLast();
    setState(() {});
  }

  void _openModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBlue,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: ContactsBottomSheet(
            contacts: contacts,
            onUserAdded: () {
              setState(() {});
            },
          ),
        );
      },
    );
  }
}
