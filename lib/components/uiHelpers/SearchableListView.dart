import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/utilities/UiHelpers.dart';


class SearchableListView extends StatefulWidget
{
  List<String> _listTileDisplayText;
  String _searchBarPlaceholderText;
  double _textSize;
  Color _textColor;
  Function _onTapListTile;
  double _borderWidth;
  Color _borderColor;
  double _spaceBetweenTiles;

  SearchableListView(this._listTileDisplayText, {
    String searchBarPlaceholderText = "Search Here...",
    double textSize = 20,
    Color textColor,
    Function onTapListTile,
    double borderWidth = 0,
    Color borderColor = Colors.black,
    double spaceBetweenTiles = 5
  })
  {
    this._searchBarPlaceholderText = searchBarPlaceholderText;
    this._textSize = textSize;
    this._textColor = textColor;
    this._onTapListTile = onTapListTile;
    this._borderWidth = borderWidth;
    this._borderColor = borderColor;
    this._spaceBetweenTiles = spaceBetweenTiles;

    if (onTapListTile == null)
    {
      this._onTapListTile = (context, index) =>
          _defaultOnTapListView(context, index);
    }
  }

  void _defaultOnTapListView(context, index)
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
                                   _borderWidth,
                                   _borderColor,
                                   _spaceBetweenTiles);
  }
}


class SearchableListViewState extends State<SearchableListView>
{
  // TODO: Implement search functionality with a Trie instead of a list
  List<String> _listTileDisplayText = [];
  List<String> _listTileAllText = [];
  String _searchBarPlaceholderText;
  int _prevSearchLength;
  bool _isLoading;
  double _textSize;
  Color _textColor;
  Function _onTapListTile;
  double _borderWidth;
  Color _borderColor;
  double _spaceBetweenTiles;

  SearchableListViewState(this._listTileAllText,
                          this._searchBarPlaceholderText,
                          this._textSize,
                          this._textColor,
                          this._onTapListTile,
                          this._borderWidth,
                          this._borderColor,
                          this._spaceBetweenTiles)
  {
    this._listTileDisplayText = this._listTileAllText.toList();
    this._prevSearchLength = 0;
  }

  @override
  void initState()
  {
    super.initState();

    if (_listTileAllText.length == 0)
    {
      setIsLoading(true);
    }

    else
    {
      setIsLoading(false);
    }
  }



  void setIsLoading(bool isLoading)
  {
    setState(()
    {
      _isLoading = isLoading;
    });
  }



  Widget _getSearchBar()
  {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
          hintText: _searchBarPlaceholderText,
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text)
        {
          _filterListView(text);
        }
      ),
    );
  }

  Widget _getDisplay()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _tryGetListView(),
      ],
    );
  }

  Widget _tryGetListView()
  {
    if (_isLoading)
    {
      return Center(
        child: getCircularProgressIndicatorCentered(),
      );
    }

    else
    {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 15,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index)
            {
              return Padding(
                padding: EdgeInsets.only(bottom: _spaceBetweenTiles),
              );
            },

            itemCount: _listTileDisplayText.length,
            itemBuilder: (BuildContext context, int index)
            {
              return Container(
                // Border
                decoration: BoxDecoration(
                  border: Border.all(
                    width: _borderWidth,
                    color: _borderColor,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),

                // ListTile
                child: ListTile(
                  contentPadding: EdgeInsets.all(5),
                  title: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      _listTileDisplayText[index],
                      style: TextStyle(
                        color: _textColor,
                        fontSize: _textSize
                      ),
                    ),
                  ),

                  onTap: _onTapListTile(context, index),
                )
              );
            },
          )
        )
      );
    }
  }



  void _filterListView(String searchedText)
  {
    if (searchedText.isEmpty)
    {
      setState(()
      {
        _listTileDisplayText.clear();
        _listTileDisplayText = _listTileAllText.toList();
      });
    }

    else
    {
      final List<String> tempFilteredText = _getTempSearchResults(searchedText);

      setState(()
      {
        _listTileDisplayText.clear();
        _listTileDisplayText = tempFilteredText.toList();
      });
    }
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
          _getSearchBar(),
          Expanded(
            flex: 1,
            child: _getDisplay(),
          ),
        ],
      )
    );
  }
}
