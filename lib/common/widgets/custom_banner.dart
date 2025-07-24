import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingpong_sample/common/widgets/reusable_text.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';

class CustomBanner extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback? onButtonTap;
  final String? imageUrl;

  const CustomBanner({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    this.onButtonTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  title,
                  style: context.textStyles.body.b16Regular.copyWith(
                    color: Colors.white,
                  ),
                ),
                Gap(8),
                ReusableText(
                  description,
                  style: context.textStyles.body.b16Regular.copyWith(
                    color: Colors.white,
                  ),
                ),
                Gap(16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: onButtonTap,
                  child: ReusableText(
                    buttonText,
                    style: context.textStyles.body.b16Regular.copyWith(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
