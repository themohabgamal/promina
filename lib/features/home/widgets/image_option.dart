import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageOption extends StatelessWidget {
  final IconData icon;
  final String title;
  const ImageOption({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 246, 202, 255),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            weight: 150,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ))
        ],
      ),
    );
  }
}
