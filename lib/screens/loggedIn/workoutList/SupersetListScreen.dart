import 'package:flutter/cupertino.dart';


class SupersetListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return SupersetListState();
  }
}



class SupersetListState extends State<SupersetListScreen> with
    AutomaticKeepAliveClientMixin<SupersetListScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Text("Superset list");
  }

  @override
  bool get wantKeepAlive => true;
}