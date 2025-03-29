import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePickerDialog extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;
  
  const DatePickerDialog({
    Key? key,
    this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  late DateTime selectedDate;
  final dateFormat = DateFormat('EEE, MMM d');
  final monthYearFormat = DateFormat('MMMM yyyy');
  
  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Square corners
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with "Payment Details" title
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              alignment: Alignment.center,
              child: Text(
                'Payment Details',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            // Divider
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            
            // Selected date with edit icon
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateFormat.format(selectedDate),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.edit, size: 20.sp),
                ],
              ),
            ),
            
            // Month selector
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        monthYearFormat.format(selectedDate),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, size: 20.sp),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.chevron_left, size: 24.sp),
                        onPressed: () {
                          setState(() {
                            selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month - 1,
                              selectedDate.day,
                            );
                          });
                        },
                      ),
                      SizedBox(width: 16.w),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.chevron_right, size: 24.sp),
                        onPressed: () {
                          setState(() {
                            selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month + 1,
                              selectedDate.day,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Calendar grid
            Padding(
              padding: EdgeInsets.all(16.w),
              child: _buildCalendarGrid(),
            ),
            
            // Continue button
            Container(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  widget.onDateSelected(selectedDate);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            // Cancel button
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCalendarGrid() {
    // Get the first day of the month
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    // Get the day of week for the first day (0 = Sunday, 1 = Monday, etc.)
    final firstDayWeekday = firstDayOfMonth.weekday;
    // Adjust weekday to start from Sunday=0 (our calendar starts with Sunday)
    final adjustedFirstDay = firstDayWeekday == 7 ? 0 : firstDayWeekday;
    
    // Calculate days in month
    final daysInMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    
    // Create weekday headers
    final weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    
    return Column(
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekdays.map((day) => 
            SizedBox(
              width: 30.w,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ).toList(),
        ),
        SizedBox(height: 16.h),
        
        // Calendar grid
        Column(
          children: List.generate(6, (weekIndex) {
            // Only display weeks that have days in this month
            if (weekIndex * 7 + 1 - adjustedFirstDay > daysInMonth && weekIndex > 0) {
              return SizedBox.shrink();
            }
            
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (dayIndex) {
                // Calculate the day number
                final dayNumber = weekIndex * 7 + dayIndex + 1 - adjustedFirstDay;
                
                // Check if this position has a valid day for this month
                if (dayNumber < 1 || dayNumber > daysInMonth) {
                  return SizedBox(width: 30.w);
                }
                
                // Create a DateTime object for this day
                final day = DateTime(selectedDate.year, selectedDate.month, dayNumber);
                
                // Check if this day is the selected day
                final isSelected = day.year == selectedDate.year && 
                                  day.month == selectedDate.month && 
                                  day.day == selectedDate.day;
                
                // Check if this day is today
                final isToday = day.year == DateTime.now().year && 
                              day.month == DateTime.now().month && 
                              day.day == DateTime.now().day;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = day;
                    });
                  },
                  child: Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.blue : (isToday ? Colors.blue.withOpacity(0.1) : null),
                      border: isToday && !isSelected ? Border.all(color: Colors.blue) : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      dayNumber.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ],
    );
  }
} 