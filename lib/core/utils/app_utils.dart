import 'package:doctor_finder_app/components/sizedbox.dart';
import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:doctor_finder_app/core/constants/textstyle_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static Widget networkImageWidget(
    String imageUrl, {
    double? width,
    double? height,
    BoxFit? fit,
    Widget? placeholder,
    Widget? errorWidget,
    bool showLoadingProgress = true,
    bool enableDebug = false,
    Color? progressColor,
  }) {
    if (enableDebug) {
      print('Loading network image: $imageUrl');
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        if (enableDebug) {
          print(
            'Image loading progress: ${loadingProgress.cumulativeBytesLoaded}/${loadingProgress.expectedTotalBytes}',
          );
        }

        return placeholder ??
            Container(
              width: width,
              height: height,
              child: Center(
                child: showLoadingProgress
                    ? CupertinoActivityIndicator(
                        color: progressColor ?? Colors.blue,
                      )
                    : const CupertinoActivityIndicator(),
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) {
        if (enableDebug) {
          print('Image loading error: $error');
          print('Stack trace: $stackTrace');
        }
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.error, color: Colors.red, size: 30),
              ),
            );
      },
    );
  }

  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static Widget customContainer(
    BuildContext context,
    Function() onTap,
    String title,
    Color color,
    double height,
    double width,
    double borderRadius,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
      ),
    );
  }

  static loadingWidget(BuildContext context, double? size) {
    return SizedBox(
      height: size,
      child: const Center(child: CupertinoActivityIndicator(radius: 10.0)),
    );
  }

  static noDataFound(String headingText, String subText, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              headingText,
              style: TextStyleClass.primaryFont700(14, ColorClass.textSoft400),
              textAlign: TextAlign.center,
            ),
            kHeight(8),
            Text(
              subText,
              style: TextStyleClass.primaryFont400(12, ColorClass.textSub500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
