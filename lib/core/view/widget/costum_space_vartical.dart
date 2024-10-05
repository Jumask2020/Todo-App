import 'package:flutter/cupertino.dart';

class CostumSpaceVartical extends StatelessWidget {
  const CostumSpaceVartical({super.key,this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??10,
    );
  }
}
