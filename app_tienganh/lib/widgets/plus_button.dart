import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlusButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PlusButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0), 
        child: IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            'assets/img/plus.svg',
            width: 25, 
            height: 25,
          ),
        ),
      ),
    );
  }
}


//Cach dung
//Gọi button trong stack để đảm bảo vị trí của button
// PlusButton(
//   onPressed: () {
//   },
// ),