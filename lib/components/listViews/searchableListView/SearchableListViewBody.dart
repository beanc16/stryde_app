import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SearchableListTile.dart';

class SearchableListViewBody extends StatefulWidget
{
  List<String> _listTileDisplayText = [];
  final double _textSize;
  final Color? _textColor;
  Function(BuildContext, int)? _onTapListTile;
  final Color _onTapColor;
  final double _borderWidth;
  final Color _borderColor;
  final double _spaceBetweenTiles;
  late SearchableListViewBodyState state;

  SearchableListViewBody(this._listTileDisplayText,
                         this._textSize,
                         this._textColor,
                         this._onTapListTile,
                         this._onTapColor,
                         this._borderWidth,
                         this._borderColor,
                         this._spaceBetweenTiles);



  void updateListTileDisplayText(List<String> listTileDisplayText)
  {
    if (this.state != null)
    {
      this.state.updateListTileDisplayText(listTileDisplayText);
    }
  }

  @override
  State<StatefulWidget> createState()
  {
    this.state = SearchableListViewBodyState(
      this._listTileDisplayText, this._textSize, this._textColor,
      this._onTapListTile, this._onTapColor, this._borderWidth,
      this._borderColor, this._spaceBetweenTiles,
    );

    return this.state;
  }
}



class SearchableListViewBodyState extends State<SearchableListViewBody>
{
  List<String> _listTileDisplayText;
  double _textSize;
  Color? _textColor;
  Function(BuildContext, int)? _onTapListTile;
  Color _onTapColor;
  double _borderWidth;
  Color _borderColor;
  double _spaceBetweenTiles;

  SearchableListViewBodyState(this._listTileDisplayText,
                              this._textSize,
                              this._textColor,
                              this._onTapListTile,
                              this._onTapColor,
                              this._borderWidth,
                              this._borderColor,
                              this._spaceBetweenTiles);



  void updateListTileDisplayText(List<String> listTileDisplayText)
  {
    setState(()
    {
      _listTileDisplayText = listTileDisplayText;
    });
  }



  Widget _tryGetListView()
  {
    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 15,
      ),

      child: ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index)
        {
          return Padding(
            padding: EdgeInsets.only(bottom: _spaceBetweenTiles),
          );
        },

        itemCount: _listTileDisplayText.length,
        itemBuilder: (BuildContext context, int index)
        {
          return SearchableListTile(
            _listTileDisplayText[index], _textSize, _textColor,
            _onTapListTile, _onTapColor, index, _borderWidth,
            _borderColor,
          );
        },
      )
    );
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _tryGetListView(),
        ),
      ],
    );
  }
}