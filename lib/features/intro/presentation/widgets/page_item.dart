import 'package:flutter/material.dart';

class PageItem extends StatelessWidget {
  PageItem(
      {super.key,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.image});
  Color color;
  String title, subtitle, image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image != ""
              ? Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const SizedBox(),
          const SizedBox(
            height: 60,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
