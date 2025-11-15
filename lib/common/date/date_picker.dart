import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/dob.dart';

class DatePicker extends StatelessWidget {
  final Function(int?)? date;
  final Function(int?)? year;
  final Function(String?)? month;

  const DatePicker({super.key, this.date, this.year, this.month});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _dropdown<int>(
          context,
          hint: 'Date',
          items: DOBItems.dates,
          onChanged: date,
        ),
        SizedBox(width: 12.w),
        _dropdown<String>(
          context,
          hint: 'Month',
          items: DOBItems.months,
          onChanged: month,
        ),
        SizedBox(width: 12.w),
        _dropdown<int>(
          context,
          hint: 'Year',
          items: DOBItems.years,
          onChanged: year,
        ),
      ],
    );
  }

  Widget _dropdown<T>(
    BuildContext context, {
    required String hint,
    required List<T> items,
    required Function(T?)? onChanged,
  }) {
    return Expanded(
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        isExpanded: true,
        hint: Text(
          hint,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        items: items.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(
              value.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
