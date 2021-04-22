import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SearchableListTile.dart';

class SearchableListViewBody extends StatefulWidget
{
  List<String> _listTileDisplayText = [];
  final double _textSize;
  final Color? _textColor;
  Function(BuildContext, int, String)? _onTapListTile;
  final Color _onTapColor;
  final double _borderWidth;
  final Color _borderColor;
  final double _spaceBetweenTiles;
  late SearchableListViewBodyState state;
  late String _noResultsStr;

  SearchableListViewBody(this._listTileDisplayText,
                         this._textSize,
                         this._textColor,
                         this._onTapListTile,
                         this._onTapColor,
                         this._borderWidth,
                         this._borderColor,
                         this._spaceBetweenTiles,
                         this._noResultsStr);



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
      this._borderColor, this._spaceBetweenTiles, this._noResultsStr
    );

    return this.state;
  }
}



class SearchableListViewBodyState extends State<SearchableListViewBody>
{
  List<String> _listTileDisplayText;
  double _textSize;
  Color? _textColor;
  Function(BuildContext, int, String)? _onTapListTile;
  Color _onTapColor;
  double _borderWidth;
  Color _borderColor;
  double _spaceBetweenTiles;
  String _noResultsStr;

  SearchableListViewBodyState(this._listTileDisplayText,
                              this._textSize,
                              this._textColor,
                              this._onTapListTile,
                              this._onTapColor,
                              this._borderWidth,
                              this._borderColor,
                              this._spaceBetweenTiles,
                              this._noResultsStr);



  void updateListTileDisplayText(List<String> listTileDisplayText)
  {
    setState(()
    {
      _listTileDisplayText = listTileDisplayText;
    });
  }



  Widget _tryGetListView()
  {
    if (_listTileDisplayText.length > 0)
    {
      return ListView.separated(
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
      );
    }

    else
    {
      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),

        itemCount: 1,
        itemBuilder: (BuildContext context, int index)
        {
          return Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                _noResultsStr,
                style: TextStyle(
                  color: _textColor,
                  fontSize: _textSize,
                  ),
              )
            ),
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 15,
            ),
            child: _tryGetListView(),
          )
        ),
      ],
    );
  }
}