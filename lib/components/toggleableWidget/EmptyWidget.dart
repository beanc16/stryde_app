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
    //return SizedBox(key: this.key, child: Text("Empty")); // For testing
    return SizedBox.shrink(key: this.key);
  }
}
