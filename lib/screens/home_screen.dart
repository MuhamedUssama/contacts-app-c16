import 'package:contacts_app/core/utils/app_assets.dart';
import 'package:contacts_app/core/utils/app_colors.dart';
import 'package:contacts_app/core/widgets/contacts_bottom_sheet.dart';
import 'package:contacts_app/core/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: SvgPicture.asset(AppImages.logo),
      ),
      body: const EmptyListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openModalBottomSheet();
        },
        backgroundColor: AppColors.gold,
        child: Icon(Icons.add_rounded, color: AppColors.darkBlue),
      ),
    );
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
          child: ContactsBottomSheet(),
        );
      },
    );
  }
}
