import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget
{
  Function(String) _onSearchChangedCallback;
  String _searchBarPlaceholderText;
  double _bottomPadding;

  SearchBar({
    @required Function(String) onSearchChangedCallback,
    String searchBarPlaceholderText = "Search...",
    double bottomPadding = 15,
  })
  {
    this._onSearchChangedCallback = onSearchChangedCallback;
    this._searchBarPlaceholderText = searchBarPlaceholderText;
    this._bottomPadding = bottomPadding;
  }



  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.only(bottom: _bottomPadding),
      child: TextField(
        decoration: InputDecoration(
          hintText: _searchBarPlaceholderText,
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (String text) => _onSearchChangedCallback(text),
      ),
    );
  }
}