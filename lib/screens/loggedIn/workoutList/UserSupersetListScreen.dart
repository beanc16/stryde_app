import 'package:flutter/cupertino.dart';


class UserSupersetListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return SupersetListState();
  }
}



class SupersetListState extends State<UserSupersetListScreen> with
    AutomaticKeepAliveClientMixin<UserSupersetListScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Text("Superset list");
  }

  @override
  bool get wantKeepAlive => true;
}