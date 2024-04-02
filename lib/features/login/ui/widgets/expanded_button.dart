import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final void Function()? onPressed;
  const ExpandedButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
