
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pingpong_sample/common/enums/dynamic_result_type.dart';
import 'package:pingpong_sample/common/widgets/reusable_elevated_button.dart';
import 'package:pingpong_sample/common/widgets/reusable_text.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';
import 'package:pingpong_sample/utils/extensions/object_extensions.dart';

final class DynamicResultBottomSheet extends StatelessWidget {
  const DynamicResultBottomSheet({
    required this.status,
    required this.description,
    this.title,
    this.buttonTitle,
    this.onPressed,
    this.enableButtonColor,
    super.key,
  });

  final DynamicResultType status;
  final String? title;
  final String description;
  final String? buttonTitle;
  final void Function()? onPressed;
  final Color? enableButtonColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
       
          if (title.isNotNull) ...[
            ReusableText(
              title!,
              style: context.textStyles.body.b20Semibold.copyWith(
                color: Colors.black,
              ),
            ),
            Gap(20.h),
          ],
    
          Gap(45.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ReusableElevatedButton(
              text: buttonTitle ?? "Okey",
    
              onPressed: () {
                onPressed.isNotNull
                    ? onPressed!.call()
                    : Navigator.of(context).pop();
              },
              enableButtonColor: enableButtonColor,
            ),
          ),
          Gap(context.safeBottomGap),
        ],
      ),
    );
  }


}
