import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SearchBar.dart';
import 'SearchableListViewBody.dart';


class SearchableListView extends StatefulWidget
{
  List<String> _listTileDisplayText;
  late final String _searchBarPlaceholderText;
  late final double _textSize;
  late Color? _textColor;
  late Function(BuildContext, int, String)? _onTapListTile;
  late final Color _onTapColor;
  late final double _borderWidth;
  late final Color _borderColor;
  late final double _spaceBetweenTiles;
  late final String _noResultsStr;

  SearchableListView(this._listTileDisplayText, {
    String searchBarPlaceholderText = "Search Here...",
    double textSize = 20,
    Color? textColor,
    Function(BuildContext, int, String)? onTapListTile,
    Color onTapColor = Colors.lightBlue,
    double borderWidth = 0,
    Color borderColor = Colors.black,
    double spaceBetweenTiles = 5,
    String noResultsStr = "No Results...",
  })
  {
    this._searchBarPlaceholderText = searchBarPlaceholderText;
    this._textSize = textSize;
    this._textColor = textColor;
    this._onTapListTile = onTapListTile;
    this._onTapColor = onTapColor;
    this._borderWidth = borderWidth;
    this._borderColor = borderColor;
    this._spaceBetweenTiles = spaceBetweenTiles;
    this._noResultsStr = noResultsStr;

    if (onTapListTile == null)
    {
      this._onTapListTile = (context, index, displayStr) =>
          _defaultOnTapListView(context, index, displayStr);
    }
  }

  void _defaultOnTapListView(context, index, displayStr)
  {
  }



  @override
  State<StatefulWidget> createState()
  {
    return SearchableListViewState(_listTileDisplayText,
                                   _searchBarPlaceholderText,
                                   _textSize,
                                   _textColor,
                                   _onTapListTile,
                                   _onTapColor,
                                   _borderWidth,
                                   _borderColor,
                                   _spaceBetweenTiles,
                                   _noResultsStr);
  }
}


class SearchableListViewState extends State<SearchableListView>
{
  // TODO: Implement search functionality with a Trie instead of a list
  List<String> _listTileDisplayText = [];
  List<String> _listTileAllText = [];
  String _searchBarPlaceholderText;
  late int _prevSearchLength;
  double _textSize;
  Color? _textColor;
  Function(BuildContext, int, String)? _onTapListTile;
  Color _onTapColor;
  double _borderWidth;
  Color _borderColor;
  double _spaceBetweenTiles;
  late SearchableListViewBody _searchableListViewBody;
  String _noResultsStr;

  SearchableListViewState(this._listTileAllText,
                          this._searchBarPlaceholderText,
                          this._textSize,
                          this._textColor,
                          this._onTapListTile,
                          this._onTapColor,
                          this._borderWidth,
                          this._borderColor,
                          this._spaceBetweenTiles,
                          this._noResultsStr)
  {
    this._listTileDisplayText = this._listTileAllText.toList();
    this._prevSearchLength = 0;

    this._searchableListViewBody = SearchableListViewBody(
      this._listTileDisplayText, this._textSize, this._textColor,
      this._onTapListTile, this._onTapColor, this._borderWidth,
      this._borderColor, this._spaceBetweenTiles, this._noResultsStr
    );
  }



  // Search functionality
  void _filterListView(String searchedText)
  {
    if (searchedText.isEmpty)
    {
      _listTileDisplayText.clear();
      _listTileDisplayText = _listTileAllText.toList();
    }

    else
    {
      final List<String> tempFilteredText = _getTempSearchResults(searchedText);

      _listTileDisplayText.clear();
      _listTileDisplayText = tempFilteredText.toList();
    }

    _searchableListViewBody.updateListTileDisplayText(_listTileDisplayText);
  }

  List<String> _getTempSearchResults(String searchedText)
  {
    List<String> tempFilteredText = [];

    // Search text is shorter than the previous search
    if (_newSearchIsShorterThanPrevSearch(searchedText))
    {
      // Search all possible results since the new results could
      // include text that the previous results didn't contain
      for (int i = 0; i < _listTileAllText.length; i++)
      {
        String curText = _listTileAllText[i];

        if (curText.toLowerCase().contains(searchedText.toLowerCase()))
        {
          tempFilteredText.add(curText);
        }
      }
    }

    // Search text is longer than the previous search
    else
    {
      // Search the currently displayed results since the number of
      // results could only make the current results smaller.
      for (int i = 0; i < _listTileDisplayText.length; i++)
      {
        String curText = _listTileDisplayText[i];

        if (curText.toLowerCase().contains(searchedText.toLowerCase()))
        {
          tempFilteredText.add(curText);
        }
      }
    }

    _prevSearchLength = searchedText.length;
    return tempFilteredText;
  }

  bool _newSearchIsShorterThanPrevSearch(String searchedText)
  {
    return (searchedText.length < _prevSearchLength);
  }



  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: Column(
        children: [
          SearchBar(
            onSearchChangedCallback: (String text) => _filterListView(text),
            searchBarPlaceholderText: _searchBarPlaceholderText,
          ),
          Expanded(
            flex: 1,
            child: _searchableListViewBody,
          ),
        ],
      )
    );
  }
}
