import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/tagDisplay/MultiTagDisplayAs.dart';
import 'package:workout_buddy/components/tagDisplay/Tag.dart';


class MultiTagDisplay extends StatefulWidget
{
  List<String> _displayText;
  Color _tagColor;
  Color _textColor;
  Color _deleteIconColor;
  double _spaceBetweenTags;
  MainAxisAlignment _mainAxisAlignment;
  CrossAxisAlignment _crossAxisAlignment;
  MultiTagDisplayAs _displayAsEnum;
  Function(int, String) _onDeleteTag;

  MultiTagDisplay({
    @required List<String> displayText,
    Color tagColor = Colors.grey,
    Color textColor = Colors.black,
    Color deleteIconColor = Colors.black,
    double spaceBetweenTags = 5,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MultiTagDisplayAs multiTagDisplayAs = MultiTagDisplayAs.Row,
    Function(int, String) onDeleteTag,
  })
  {
    this._displayText = displayText;
    this._tagColor = tagColor;
    this._textColor = textColor;
    this._deleteIconColor = deleteIconColor;
    this._spaceBetweenTags = spaceBetweenTags;
    this._mainAxisAlignment = mainAxisAlignment;
    this._crossAxisAlignment = crossAxisAlignment;
    this._displayAsEnum = multiTagDisplayAs;
    this._onDeleteTag = onDeleteTag;
  }



  @override
  State<StatefulWidget> createState()
  {
    return MultiTagDisplayState(this._displayText, this._tagColor,
                                this._textColor, this._deleteIconColor,
                                this._spaceBetweenTags,
                                this._mainAxisAlignment,
                                this._crossAxisAlignment,
                                this._displayAsEnum,
                                this._onDeleteTag);
  }
}



class MultiTagDisplayState extends State<MultiTagDisplay>
{
  List<Widget> _tags;
  List<String> _displayText;
  Color _tagColor;
  Color _textColor;
  Color _deleteIconColor;
  double _spaceBetweenTags;
  MainAxisAlignment _mainAxisAlignment;
  CrossAxisAlignment _crossAxisAlignment;
  MultiTagDisplayAs _displayAsEnum;
  Function(int, String) _onDeleteTagCallback;

  MultiTagDisplayState(this._displayText, this._tagColor,
                       this._textColor, this._deleteIconColor,
                       this._spaceBetweenTags, this._mainAxisAlignment,
                       this._crossAxisAlignment, this._displayAsEnum,
                       this._onDeleteTagCallback);

  @override
  void initState()
  {
    super.initState();

    _tags = Tag.generateList(
      displayText: _displayText,
      tagColor: _tagColor,
      textColor: _textColor,
      spaceBetweenTags: _spaceBetweenTags,
      onDeleted: (String displayStr) => _onDeleteTag(displayStr),
      deleteIconColor: _deleteIconColor,
      displayedAs: _displayAsEnum,
    );
  }

  void _onDeleteTag(String displayStr)
  {
    // Need the duplicate list, or it throws errors
    setState(()
    {
      // Get index of tag
      List tempCopy = _displayText.toList();
      int index = tempCopy.indexOf(displayStr);

      // Remove the tag from the list of Strings
      tempCopy.removeAt(index);
      _displayText = tempCopy;

      // Remove the tag from the list of Widgets
      tempCopy = _tags.toList();
      tempCopy.removeAt(index);
      _tags = tempCopy;

      if (_onDeleteTagCallback != null)
      {
        _onDeleteTagCallback(index, displayStr);
      }
    });
  }

  Widget _getTagDisplay()
  {
    if (_displayAsEnum == MultiTagDisplayAs.Row)
    {
      return Row(
        mainAxisAlignment: _mainAxisAlignment,
        crossAxisAlignment: _crossAxisAlignment,
        children: _tags,
      );
    }
    else if (_displayAsEnum == MultiTagDisplayAs.Column)
    {
      return Column(
        mainAxisAlignment: _mainAxisAlignment,
        crossAxisAlignment: _crossAxisAlignment,
        children: _tags,
      );
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: _getTagDisplay(),
    );
  }
}