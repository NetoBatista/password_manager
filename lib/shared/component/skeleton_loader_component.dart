import 'package:flutter/material.dart';
import 'package:password_manager/core/interface/itheme_service.dart';
import 'package:password_manager/core/provider/dependency_provider.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoaderComponent extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonLoaderComponent({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    IThemeService themeService = DependencyProvider.get();
    var currentTheme = themeService.getCurrent().value;
    var baseColor = Colors.grey.shade300;
    var highlightColor = Colors.white;

    if (currentTheme == ThemeMode.dark) {
      baseColor = Colors.grey.shade800;
      highlightColor = Colors.grey.shade600;
    }

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
