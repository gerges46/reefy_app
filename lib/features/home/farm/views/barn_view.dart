// import 'package:checkin/features/auth/views/widgets/custom_textform_field.dart';
// import 'package:checkin/features/home/farm/view_model/cubit/farm_managment_cubit.dart';
// import 'package:checkin/features/home/view_model/cubit/home_cubit.dart';
// import 'package:checkin/features/home/view_model/cubit/home_state.dart';
// import 'package:checkin/features/home/farm/widgets/custom_radio_dialog.dart';
// import 'package:checkin/shared/custom_button.dart';
// import 'package:checkin/shared/server_locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/utils/constants/app_strings.dart';
// import '../../../../core/utils/constants/color_manager.dart';
// import '../../../../core/utils/constants/values_manager.dart';
// import '../model/checken_type_model.dart';
// import '../view_model/cubit/farm_managment_state.dart';

// class BarnView extends StatelessWidget {
//   const BarnView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => FarmManagmentCubit(sl())..loadChickenTypes(),
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: BlocConsumer<HomeCubit, HomeState>(
//               listener: (context, state) {},

//               builder: (context, state) {
//                 return Column(
//                   children: [
//                     SizedBox(height: AppSize.s22.h),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(right: AppPadding.p16.h),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: ColorManager.sideFillColor,
//                                 width: 1.w,
//                               ),
//                               borderRadius: BorderRadius.circular(AppSize.s6.r),
//                             ),
//                             child: IconButton(
//                               onPressed: () {},
//                               icon: Icon(Icons.arrow_back_ios_new),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: AppSize.s16),
//                         Text(AppStrings.addBrain),
//                       ],
//                     ),
//                     CustomTextFormField(
//                       controller: TextEditingController(),
//                       hint: "اسم العنبر",
//                     ),
//                     CustomTextFormField(
//                       controller: TextEditingController(),
//                       hint: "نوع العنبر",
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.arrow_drop_down),
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder:
//                                 (_) => CustomRadioDialog(
//                                   title: "نوع العنبر",
//                                   options: ["عنبر مفتوح", "عنبر مغلق"],
//                                   selectedValue:
//                                       context.read<HomeCubit>().barnType,
//                                   onChanged: (val) {
//                                     context.read<HomeCubit>().setBarnType(val);
//                                   },
//                                 ),
//                           );
//                         },
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () => _showChickenTypeDialog(context),
//                       child: Text("إدارة أنواع الدجاج"),
//                     ),

                
//                     BlocBuilder<FarmManagmentCubit, FarmManagmentState>(
//                       builder: (context, state) {
//                         if (state is FarmChickenTypesLoaded) {
//                           final chickenTypes = state.chickenTypes;
//                           return DropdownButtonFormField<String>(
//                             decoration: InputDecoration(
//                               hintText: 'نوع الطيور',
//                               border: OutlineInputBorder(),
//                             ),
//                             items:
//                                 chickenTypes.map((e) {
//                                   return DropdownMenuItem<String>(
//                                     value: e.chickenTypeName,
//                                     child: Text(e.chickenTypeName),
//                                   );
//                                 }).toList(),
//                             onChanged: (val) {
//                               // احفظ القيمة المختارة حسب اللي انت عايزه
//                             },
//                           );
//                         } else if (state is FarmManagmentError) {
//                           return Text('خطأ: ${state.message}');
//                         }
//                         return CircularProgressIndicator();
//                       },
//                     ),

//                     CustomTextFormField(
//                       controller: TextEditingController(),
//                       hint: "ملاحظات",
//                     ),
//                     SizedBox(height: AppSize.s160.h),
//                     CustomButton(
//                       title: "تاكيد",
//                       color: ColorManager.customButtonColor,
//                       textColor: Colors.white,
//                       onPressed: () {},
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// void _showChickenTypeDialog(BuildContext context, {ChickenTypeModel? type}) {
//   final controller = TextEditingController(text: type?.chickenTypeName);
//   showDialog(
//     context: context,
//     builder:
//         (_) => AlertDialog(
//           title: Text(type == null ? "إضافة نوع" : "تعديل النوع"),
//           content: TextField(
//             controller: controller,
//             decoration: InputDecoration(hintText: "اسم نوع الدجاج"),
//           ),
//           actions: [
//             TextButton(
//               child: Text("إلغاء"),
//               onPressed: () => Navigator.pop(context),
//             ),
//             ElevatedButton(
//               child: Text("تأكيد"),
//               onPressed: () {
//                 final cubit = context.read<FarmManagmentCubit>();
//                 if (type == null) {
//                   cubit.addType(controller.text);
//                 } else {
//                   cubit.updateType(type.id, controller.text);
//                 }
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//   );
// }














