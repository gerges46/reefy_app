import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fonSize,FontWeight fontWeight,Color color){
  return TextStyle(
    fontSize: fonSize,
    fontFamily: FontConstants.fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}
// regular style
TextStyle regularStyle({double fontSize=FontSize.s16,required Color color,}){
  return _getTextStyle(fontSize,FontWeightManager.regular,color );
}
// medium style
TextStyle mediumStyle({double fontSize=FontSize.s12,required Color color,}){
  return _getTextStyle(fontSize,FontWeightManager.medium,color );
}
// bold style
TextStyle boldStyle({double fontSize=FontSize.s12,required Color color,}){
  return _getTextStyle(fontSize,FontWeightManager.bold,color );
}
// semiBold style
TextStyle semiBold({double fontSize=FontSize.s18,required Color color,}){
  return _getTextStyle(fontSize,FontWeightManager.semiBold,color );
}
// light style
TextStyle light({double fontSize=FontSize.s12,required Color color,}){
  return _getTextStyle(fontSize,FontWeightManager.light,color );
}