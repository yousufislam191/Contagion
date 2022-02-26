import 'dart:io';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  // final bool isEdit;
  // final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    // this.isEdit = false,
    // required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return CircleAvatar(
      radius: 55,
      child: buildImage(),
      // Positioned(
      //   bottom: 0,
      //   right: 4,
      //   // child: buildEditIcon(color),
      // ),
    );
  }

  Widget buildImage() {
    final image = imagePath.contains('assets/')
        ? AssetImage(imagePath)
        : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 168,
          height: 168,
          // child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }
}
