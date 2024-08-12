import 'package:flutter/widgets.dart';

class SliverSizedBox extends StatelessWidget {
  final double? width;
  final double? height;

  const SliverSizedBox({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(width: width, height: height,),);
  }
}
