import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v24_student_app/res/icons.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({
    Key? key,
    this.imageUrl,
    this.reverseColor = false,
    this.size = 24,
    this.onTap,
  }) : super(key: key);

  AvatarView.network({
    Key? key,
    String? imageUrl,
    bool reverseColor = false,
    double size = 24,
    VoidCallback? onTap,
  }) : this(
          key: key,
          imageUrl: imageUrl,
          reverseColor: reverseColor,
          size: size,
          onTap: onTap,
        );

  final String? imageUrl;
  final bool reverseColor;
  final double size;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl!,
          width: size,
          height: size,
          placeholder: (_, __) {
            return _buildImagePlaceholder();
          },
          errorWidget: (_, __, ___) {
            return _buildImagePlaceholder();
          },
        ),
      );
    } else {
      return _buildImagePlaceholder();
    }
  }

  Image _buildImagePlaceholder() {
    return const Image(
      image: AppIcons.avatarIconAsset,
      fit: BoxFit.cover,
      width: 36.0,
      height: 36.0,
    );
  }
}
