

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


import '../../../../core/utils/constants/color_manager.dart';

class CustomPinCodeField extends StatelessWidget {
  const CustomPinCodeField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        borderWidth: 1,
        fieldWidth: 50,
    
        activeColor: ColorManager.customButtonColor,
        activeFillColor: Colors.white,
        inactiveColor: ColorManager.activeDotsColor,
        inactiveFillColor: Colors.white,
        selectedColor: ColorManager.customButtonColor,
        selectedFillColor: Colors.white,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      // errorAnimationController: errorController,
      // controller: textEditingController,
      onCompleted: (code) {},
      onChanged: (value) {
        print(value);
      },
    
      // beforeTextPaste: (text) {
      //   print("Allowing to paste $text");
      //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
      //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
      //   return true;
      // },
    );
  }
}
