
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final bool isLoading;
  final bool isListEmpty;
  final String emptyMsg = "No Data Found !";
  const CustomLoadingIndicator({super.key, required this.isLoading, required this.isListEmpty});

  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 100),
          child: const CircularProgressIndicator(color: kPrimaryDarkColor,strokeWidth: 2)
      ) : Visibility(
        visible: isListEmpty,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 100),
          child:  Column(
            children: [
              Image.asset('assets/images/no-data4.png', width: 120,height: 120,),
              Text(emptyMsg, style: const TextStyle(fontSize: 20, color: kLightGreyColor, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
    );
  }
}
