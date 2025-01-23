import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: Colors.transparent),
        ),
        Center(
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3097ff)),
          ),
        ),
      ],
    );
  }
}
