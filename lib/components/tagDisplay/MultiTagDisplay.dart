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
  MultiTagDisplayState state;

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



  void addTag(String displayStr)
  {
    if (this.state != null)
    {
      this.state.addTag(displayStr);
    }
  }



  @override
  State<StatefulWidget> createState()
  {
    this.state = MultiTagDisplayState(
      this._displayText, this._tagColor, this._textColor,
      this._deleteIconColor, this._spaceBetweenTags,
      this._mainAxisAlignment, this._crossAxisAlignment,
      this._displayAsEnum, this._onDeleteTag
    );

    return this.state;
  }
}



class MultiTagDisplayState extends State<MultiTagDisplay>
{
  List<Tag> _tags;
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
      onDeleted: _onDeleteTag,
      deleteIconColor: _deleteIconColor,
      displayedAs: _displayAsEnum,
    );
  }

  void _onDeleteTag(Key uniqueKey)
  {
    // Get index of tag
    int index = _tags.indexWhere((Widget tag)
    {
      if (tag is Tag)
      {
        return tag.keyEquals(uniqueKey);
      }

    return false;
    });

    // Need the duplicate list, or it throws errors
    setState(()
    {
      // Remove the tag from the list of Strings
      List tempCopy = _displayText.toList();
      String displayStr = tempCopy.removeAt(index);
      _displayText = tempCopy.toList();

      // Remove the tag from the list of Widgets
      tempCopy = _tags.toList();
      tempCopy.removeAt(index);
      _tags = tempCopy.toList();

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

    return null;
  }



  void addTag(String displayStr)
  {
    Key key = UniqueKey();
    EdgeInsets padding;

    if (_displayAsEnum == MultiTagDisplayAs.Row)
    {
      padding = EdgeInsets.only(right: _spaceBetweenTags);
    }
    else if (_displayAsEnum == MultiTagDisplayAs.Column)
    {
      padding = EdgeInsets.only(bottom: _spaceBetweenTags);
    }

    setState(()
    {
      _displayText.add(displayStr);

      _tags.add(Tag(
        key: key,
        displayText: displayStr,
        tagColor: _tagColor,
        textColor: _textColor,
        onDeleted: () => _onDeleteTag(key),
        deleteIconColor: _deleteIconColor,
        padding: padding,
      ));
    });
  }



  @override
  Widget build(BuildContext context)
  {
    print("build _tags: " + _tags.toString());
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: _getTagDisplay(),
    );
  }
}