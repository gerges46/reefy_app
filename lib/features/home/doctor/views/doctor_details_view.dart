import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/doctor_model.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailScreen(this.doctor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تفاصيل الطبيب"),
      backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الاسم: ${doctor.userName ?? 'غير متوفر'}', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Text('العنوان: ${doctor.address ?? 'غير متوفر'}', style: TextStyle(fontSize: 18.sp)),
            SizedBox(height: 10.h),
            Text('المنطقة: ${doctor.region ?? 'غير متوفرة'}', style: TextStyle(fontSize: 18.sp)),
            SizedBox(height: 10.h),
            Text('المحافظة: ${doctor.governorate ?? 'غير متوفرة'}', style: TextStyle(fontSize: 18.sp)),
            SizedBox(height: 10.h),
            Text('الهاتف: ${doctor.phone ?? 'غير متوفر'}', style: TextStyle(fontSize: 18.sp)),
            SizedBox(height: 16.h),
            Text("التقييم:", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Row(
              children: List.generate(5, (i) {
                return Icon(
                  i < 3 ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 22.sp,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
