import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  
  SearchBarDelegate(this.child);
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.w),
      child: child,
    );
  }
  
  @override
  double get maxExtent => AppSize.s80.h;
  
  @override
  double get minExtent => AppSize.s80.h;
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}