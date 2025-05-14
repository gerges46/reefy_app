// import 'package:checkin/core/utils/constants/values_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SearchBarDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
  
//   SearchBarDelegate(this.child);
  
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.all(8.w),
//       child: child,
//     );
//   }
  
//   @override
//   double get maxExtent => AppSize.s80.h;
  
//   @override
//   double get minExtent => AppSize.s80.h;
  
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
// }
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:checkin/features/home/doctor/views/widgets/custom_search_bar.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final CustomSearchField searchField;

  SearchBarDelegate(this.searchField);

  @override
  double get minExtent => AppSize.s80.h;

@override
  double get maxExtent => AppSize.s80.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // تأكد من أن القيمة `maxExtent` غير تتجاوز الـ `minExtent` في حالة التمرير
    double screenHeight = MediaQuery.of(context).size.height;
    double dynamicMaxExtent = screenHeight * 0.2;

    // التأكد من أن maxExtent لا يتجاوز حجم الشاشة
    if (dynamicMaxExtent < minExtent) {
      dynamicMaxExtent = minExtent;
    }

    // Return the searchField widget inside a container for styling
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.w),
      child: searchField,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false; // تحسين الأداء بتقليل عمليات الإعادة غير الضرورية
  }
}

