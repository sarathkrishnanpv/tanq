// Custom slide button implementation
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Controller for the slider button using GetX
class SlideButtonController extends GetxController {
  final RxDouble position = 0.0.obs;
  final RxBool isCompleted = false.obs;
  double maxWidth = 0.0;
  double lastHapticPosition = 0.0;
  final double hapticInterval = 50.0; // Interval for haptic feedback during slide
  
  void setMaxWidth(double width) {
    maxWidth = width;
  }
  
  void updatePosition(double delta, VoidCallback onComplete) {
    position.value += delta;
    
    if (position.value < 0) {
      position.value = 0;
    } else if (position.value > maxWidth) {
      position.value = maxWidth;
      // Check if button reached end
      if (position.value >= maxWidth - 5 && !isCompleted.value) {
        HapticFeedback.mediumImpact(); // Strong feedback on completion
        isCompleted.value = true;
        onComplete();
      }
    }
    
    // Provide haptic feedback during sliding at intervals
    if ((position.value - lastHapticPosition).abs() >= hapticInterval) {
      HapticFeedback.selectionClick();
      lastHapticPosition = position.value;
    }
  }
  
  void finishSlide(VoidCallback onComplete) {
    if (position.value < maxWidth - 20) {
      position.value = 0;
      HapticFeedback.lightImpact(); // Light feedback when returning to start
    } else {
      position.value = maxWidth;
      if (!isCompleted.value) {
        HapticFeedback.mediumImpact(); // Strong feedback on completion
        isCompleted.value = true;
        onComplete();
      }
    }
  }
  
  void reset() {
    position.value = 0;
    isCompleted.value = false;
    lastHapticPosition = 0.0;
  }
}

class CustomSlideButton extends StatefulWidget {
  final VoidCallback onSlideComplete;
  final String text;
  final Color? buttonColor;
  final Color? textColor;

  const CustomSlideButton({
    Key? key,
    required this.onSlideComplete,
    required this.text,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  State<CustomSlideButton> createState() => _CustomSlideButtonState();
}

class _CustomSlideButtonState extends State<CustomSlideButton> {
  // Create a unique instance of the controller for each button
  late final SlideButtonController controller;
  
  @override
  void initState() {
    super.initState();
    // Use unique ID to prevent controller conflicts
    controller = Get.put(SlideButtonController(), tag: 'slider_${DateTime.now().millisecondsSinceEpoch}');
    // Reset controller on init
    controller.reset();
  }
  
  @override
  void dispose() {
    // Clean up controller when widget is disposed
    Get.delete<SlideButtonController>(tag: controller.toString());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56, // Fixed height for the button
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          controller.setMaxWidth(constraints.maxWidth - 56.w);
          
          return Stack(
            children: [
              // Slide track with gradient
              Container(
                height: 56, // Match parent height
                padding: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 56.w), // Space for the button
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Slide indicator - fills as you drag
              Obx(() => Container(
                width: controller.position.value + 56.w,
                height: 56, // Match parent height
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              )),
              
              // Draggable button
              Obx(() => Positioned(
                left: controller.position.value,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    controller.updatePosition(details.delta.dx, widget.onSlideComplete);
                  },
                  onPanEnd: (details) {
                    controller.finishSlide(widget.onSlideComplete);
                  },
                  child: Container(
                    height: 56, // Match parent height
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: widget.buttonColor ?? Colors.black,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              )),
            ],
          );
        },
      ),
    );
  }
} 