import 'package:flutter/cupertino.dart';


class EmptyWidget extends StatelessWidget
{
  late final Key key;

  EmptyWidget({Key? key})
  {
    if (key == null)
    {
      this.key = UniqueKey();
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return SizedBox.shrink(key: this.key);
  }
}
