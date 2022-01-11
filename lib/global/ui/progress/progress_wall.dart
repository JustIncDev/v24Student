import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/colors.dart';

enum ProgressWallType { lite, dark }

class ProgressWall extends StatelessWidget {
  const ProgressWall({Key? key, this.progressWallType = ProgressWallType.lite}) : super(key: key);

  final ProgressWallType progressWallType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparent,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: 120,
          width: 120,
          child: Stack(children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                height: 120,
                width: 120,
                color: progressWallType == ProgressWallType.lite
                    ? AppColors.white30
                    : AppColors.black.withOpacity(0.7),
              ),
            ),
            Center(
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.white),
                child: SizedBox(
                  height: 58,
                  width: 58,
                  child: CircularProgressIndicator(
                    backgroundColor: progressWallType == ProgressWallType.lite
                        ? AppColors.black30
                        : AppColors.white30,
                    strokeWidth: 6,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
