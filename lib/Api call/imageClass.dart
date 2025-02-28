import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? placeholder;
  final String? errorImage;

  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          errorImage ?? 'assets/images/default_image.png', // Default error image
          width: width,
          height: height,
          fit: fit,
        );
      },
    );
  }
}


// CustomNetworkImage(
//   imageUrl: "https://example.com/image.jpg",
//   width: 150,
//   height: 150,
//   fit: BoxFit.cover,
//   placeholder: "assets/images/placeholder.png",
//   errorImage: "assets/images/error.png",
// ),