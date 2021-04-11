import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/tagDisplay/MultiTagDisplayAs.dart';
import 'package:Stryde/components/tagDisplay/Tag.dart';


class MultiTagDisplay extends StatefulWidget
{
  late List<String> _displayText;
  late final Color _tagColor;
  late final Color _textColor;
  late final Color _deleteIconColor;
  late final double _spaceBetweenTags;
  late final MainAxisAlignment _mainAxisAlignment;
  late final CrossAxisAlignment _crossAxisAlignment;
  late final MultiTagDisplayAs _displayAsEnum;
  late Function(int, String)? _onDeleteTag;
  late MultiTagDisplayState state;
  late bool _canDeleteTags;

  MultiTagDisplay({
    required List<String> displayText,
    Color tagColor = Colors.grey,
    Color textColor = Colors.black,
    Color deleteIconColor = Colors.black,
    double spaceBetweenTags = 5,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MultiTagDisplayAs multiTagDisplayAs = MultiTagDisplayAs.Row,
    Function(int, String)? onDeleteTag,
    bool canDeleteTags = true,
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
    this._canDeleteTags = canDeleteTags;
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
      this._displayAsEnum, this._onDeleteTag,
      this._canDeleteTags,
    );

    return this.state;
  }
}



class MultiTagDisplayState extends State<MultiTagDisplay>
{
  late List<Tag> _tags;
  List<String> _displayText;
  Color _tagColor;
  Color _textColor;
  Color _deleteIconColor;
  double _spaceBetweenTags;
  MainAxisAlignment _mainAxisAlignment;
  CrossAxisAlignment _crossAxisAlignment;
  MultiTagDisplayAs _displayAsEnum;
  Function(int, String)? _onDeleteTagCallback;
  bool _canDeleteTags;

  MultiTagDisplayState(this._displayText, this._tagColor,
                       this._textColor, this._deleteIconColor,
                       this._spaceBetweenTags, this._mainAxisAlignment,
                       this._crossAxisAlignment, this._displayAsEnum,
                       this._onDeleteTagCallback, this._canDeleteTags);

  @override
  void initState()
  {
    super.initState();

    Function(Key)? tempOnDeleteTag;

    if (_canDeleteTags)
    {
      tempOnDeleteTag = _onDeleteTag;
    }

    _tags = Tag.generateList(
      displayText: _displayText,
      tagColor: _tagColor,
      textColor: _textColor,
      spaceBetweenTags: _spaceBetweenTags,
      onDeleted: tempOnDeleteTag,
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
      List<String> tempCopy = _displayText.toList();
      String displayStr = tempCopy.removeAt(index);
      _displayText = tempCopy.toList();

      // Remove the tag from the list of Widgets
      List<Tag> tempCopy2 = _tags.toList();
      tempCopy2.removeAt(index);
      _tags = tempCopy2.toList();

      if (_onDeleteTagCallback != null)
      {
        _onDeleteTagCallback!(index, displayStr);
      }
    });
  }

  Widget? _getTagDisplay()
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
    UniqueKey key = UniqueKey();
    EdgeInsets padding = EdgeInsets.zero;

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: _getTagDisplay(),
    );
  }
}