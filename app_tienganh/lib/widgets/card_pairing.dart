import 'package:app_tienganh/core/app_colors.dart';
import 'package:flutter/material.dart';

class CardPairing extends StatelessWidget {
  static const String defaultState = 'defaultState';
  static const String select = 'select';
  static const String correct = 'correct';
  static const String wrong = 'wrong';

  // Properties to customize the box
  final String state;
  final String text;
  final TextStyle? textStyle;
  final double boxHeight;
  final double boxWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  const CardPairing({
    Key? key,
    this.state = defaultState,
    this.text = 'text',
    this.textStyle,
    this.boxHeight = 121,
    this.boxWidth = 100,
    this.padding,
    this.margin,
    this.onTap,
  }) : super(key: key);

  // Method to get color based on state
  Color _getColorByState() {
    switch (state) {
      case defaultState:
        return AppColors.background;
      case select:
        return AppColors.lightblue;
      case correct:
        return AppColors.green;
      case wrong:
        return AppColors.red;
      default:
        return AppColors.background;
    }
  }

  // Method to get text color based on state
  Color _getTextColorByState() {
    switch (state) {
      case defaultState:
        return AppColors.textPrimary;
      case select:
        return AppColors.textPrimary;
      case correct:
        return AppColors.text;
      case wrong:
        return AppColors.text;
      default:
        return AppColors.textPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: boxHeight,
        width: boxWidth,
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
        padding: padding ?? const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _getColorByState(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue, // Viền màu xanh cố định
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style:
                textStyle ??
                TextStyle(
                  color: _getTextColorByState(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}

// cách sử dụng
// class _MyAppState extends State<MyApp> {
//   // State for first example (default → select → correct)
//   String _firstBoxState = CardPairing.defaultState;

//   // State for second example (default → select → wrong)
//   String _secondBoxState = CardPairing.defaultState;

//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // First example: default → select → correct
//               CardPairing(
//                 state: _firstBoxState,
//                 text: 'Correct Path', chữ trong ô
//                 onTap: () {
//                   setState(() {
//                     switch (_firstBoxState) {
//                       case CardPairing.defaultState:
//                         _firstBoxState = CardPairing.select;
//                         break;
//                       case CardPairing.select:
//                         _firstBoxState = CardPairing.correct;
//                         break;
//                       case CardPairing.correct:
//                         // _firstBoxState = ConsequenceBox.defaultState;
//                         break;
//                       // default:
//                       //   _firstBoxState = ConsequenceBox.defaultState;
//                     }
//                   });
//                 },
//               ),
//               SizedBox(height: 20), // Khoảng cách giữa các ô
//               // Second example: default → select → wrong
//               CardPairing(
//                 state: _secondBoxState,
//                 text: 'Wrong Path',

//                 onTap: () {
//                   setState(() {
//                     switch (_secondBoxState) {
//                       case CardPairing.defaultState:
//                         _secondBoxState = CardPairing.select;
//                         break;
//                       case CardPairing.select:
//                         _secondBoxState = CardPairing.wrong;
//                         break;
//                       case CardPairing.wrong:
//                         _secondBoxState = CardPairing.defaultState;
//                         break;
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
