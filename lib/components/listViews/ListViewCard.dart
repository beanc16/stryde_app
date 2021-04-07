import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_buddy/components/strydeHelpers/constants/StrydeColors.dart';

class ListViewCard extends StatefulWidget
{
  final Key key;
  final String title;
  final String description;
  bool shouldLeftIndent;
  bool isReorderable = true;
  Function() onDeleteListViewCard;
  Function(BuildContext, dynamic) onTap;
  ListViewCardState state;
  dynamic data;

  ListViewCard(this.title, this.description, this.key,
               this.shouldLeftIndent, this.onDeleteListViewCard,
               {
                 Function(BuildContext, dynamic) onTap,
                 dynamic data
               })
  {
    this.data = data;
    
    if (onTap != null)
    {
      this.onTap = onTap;
    }
    
    else
    {
      this.onTap = (BuildContext, dynamic)
      {
      };
    }
  }

  ListViewCard.notReorderable(this.title, this.description, this.key, 
                              this.shouldLeftIndent,
                              {
                                Function(BuildContext, dynamic) onTap,
                                dynamic data
                              })
  {
    this.isReorderable = false;
    this.data = data;
    
    this.onDeleteListViewCard = ()
    {
      // Do nothing, the delete button won't be displayed
    };
    
    if (onTap != null)
    {
      this.onTap = onTap;
    }

    else
    {
      this.onTap = (BuildContext, dynamic)
      {
      };
    }
  }



  @override
  ListViewCardState createState()
  {
    state = ListViewCardState(
      this.shouldLeftIndent,
      this.isReorderable,
      this.onDeleteListViewCard,
      this.onTap,
      this.data,
    );

    return state;
  }

  void updateIndent(bool shouldIndent)
  {
    this.shouldLeftIndent = shouldIndent;

    if (state != null)
    {
      state.setState(()
      {
        state.shouldLeftIndent = shouldIndent;
      });
    }
  }

  void indentLeft()
  {
    this.shouldLeftIndent = true;

    if (state != null)
    {
      /*
      state.setState(()
      {
        state.shouldLeftIndent = true;
      });
      */
    }
  }

  void dontIndentLeft()
  {
    this.shouldLeftIndent = false;

    if (state != null)
    {
      state.setState(()
      {
        state.shouldLeftIndent = false;
      });
    }
  }

  bool isIndented()
  {
    return state.isIndented();
  }

  void setIsReorderable(bool isReorderable)
  {
    this.isReorderable = isReorderable;

    if (state != null)
    {
      /*
      state.setState(()
      {
        state.isReorderable = isReorderable;
      });
      */
    }
  }
}



class ListViewCardState extends State<ListViewCard>
{
  bool shouldLeftIndent;
  bool isReorderable;
  Function() onDeleteListViewCard;
  Function(BuildContext, dynamic) onTap;
  dynamic data;

  ListViewCardState(this.shouldLeftIndent, this.isReorderable, 
                    this.onDeleteListViewCard, this.onTap, this.data);



  @override
  initState()
  {
    if (shouldLeftIndent == null)
    {
      shouldLeftIndent = false;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    double defaultMargin = 4;
    double leftMargin = defaultMargin;
    //Padding reorderIcon;
    Padding deleteIcon;

    if (widget.shouldLeftIndent)
    {
      leftMargin *= 8;
    }

    if (this.isReorderable)
    {
      //reorderIcon = _getReorderIcon();
      deleteIcon = _getDeleteIcon();
    }
    else
    {
      //reorderIcon = _getNoReorderIcon();
      deleteIcon = _getNoDeleteIcon();
    }

    return Card(
      margin: EdgeInsets.only(
        left: leftMargin,
        right: defaultMargin,
        top: defaultMargin,
        bottom: defaultMargin
      ),
      color: Colors.white,
      child: InkWell(
        splashColor: this._getSplashColor(),

        onTap: () => this.onTap(context, data),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>
          [
            deleteIcon,

            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${widget.title}',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ),
                  /*
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${widget.description}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ),
                  */
                ],
              ),
            ),

            //reorderIcon,
          ],
        ),
      ),
    );
  }

  bool isIndented()
  {
    return shouldLeftIndent;
  }



  /*
  Padding _getReorderIcon()
  {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Icon(
        Icons.reorder,
        color: Colors.grey,
        size: 24.0,
      ),
    );
  }

  Padding _getNoReorderIcon()
  {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    );
  }
   */

  Padding _getDeleteIcon()
  {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.transparent,
          shape: CircleBorder(),
        ),
        child: SizedBox(
          height: 24,
          width: 24,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),

            icon: Icon(
              Icons.cancel_rounded,
              size: 24,
            ),
            color: Colors.red,
            onPressed: ()
            {
              this.onDeleteListViewCard();
            },
          ),
        )
      ),
    );
  }

  Padding _getNoDeleteIcon()
  {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    );
  }

  MaterialColor _getSplashColor()
  {
    if (this.isReorderable)
    {
      // TODO: Update this to return a StrydeColor, but make it a MaterialColor
      return Colors.blue;
    }

    return null;
  }
}
