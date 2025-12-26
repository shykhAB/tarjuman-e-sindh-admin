import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/custom_widget_controllers/custom_bottom_nav_bar_controller.dart';
import '../../utils/app_colors.dart';

class CustomBottomNavBar extends GetView<CustomBottomNavBarController> {
  const CustomBottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.file_copy, color: Color(0xFF276667),),
          label: "News",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.newspaper, color: Color(0xFFB69B03),),
          label: "E-Paper",
        ),],
      onTap: (index){
        controller.onItemSelect(index);
      },
      unselectedItemColor: kTextColor,
      selectedItemColor: kTextColor,
    );
  }
}
