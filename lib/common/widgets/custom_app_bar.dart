import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingpong_sample/common/widgets/reusable_text.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? userImageUrl;
  final String? subtitle;
  final VoidCallback? onLogout;

  const CustomAppBar({
    super.key,
    required this.userName,
    this.userImageUrl,
    this.subtitle,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: userImageUrl != null
                  ? NetworkImage(userImageUrl!)
                  : null,
              child: userImageUrl == null
                  ? const Icon(Icons.person, size: 28)
                  : null,
            ),
            Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                    'Merhaba, $userName',
                    style: context.textStyles.title.t18Semibold,
                  ),
                  if (subtitle != null)
                    ReusableText(
                      subtitle!,
                      style: context.textStyles.body.b16Regular.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: context.colors.generalText.text.primary,
              ),
              onPressed: onLogout,
              tooltip: 'Çıkış Yap',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
