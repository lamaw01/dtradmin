import 'package:flutter/widgets.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.s,
    required this.w,
    this.c,
    required this.f,
  });
  final String s;
  final double w;
  final Color? c;
  final int f;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: f,
      fit: FlexFit.loose,
      child: Container(
        color: null,
        width: w,
        child: Center(
          child: Text(
            s,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
