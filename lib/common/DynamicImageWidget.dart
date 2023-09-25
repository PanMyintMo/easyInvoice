import 'dart:io';

import 'package:flutter/material.dart';

class DynamicImageWidget extends StatelessWidget {
  final File? image;
  final VoidCallback? onTap;
 const DynamicImageWidget({required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Image.file(
      image!,
      fit: BoxFit.cover,
    )
        : InkWell(
      onTap: onTap,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload,
            size: 40,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'Upload Image',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}