import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/ui/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditAvatarUserProfile extends StatelessWidget {
  final String avatarUser;

  const EditAvatarUserProfile({Key? key, required this.avatarUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  imageUrl: avatarUser,
                  placeholder: (context, url) => const Center(
                    child: AppShimmer(),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.network(AppImages.imageDefaultNetwork),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -8,
                right: -8,
                child: Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SvgPicture.asset(AppImages.icPen),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Upload Image', style: AppTextStyle.blackS16W600)
        ],
      ),
    );
  }
}
