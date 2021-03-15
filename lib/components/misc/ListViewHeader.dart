import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewHeader extends StatefulWidget
{
  final Key key;
  final String title;
  bool isDeleteable;
  Function() onDeleteListViewHeader;
  ListViewHeaderState state;

  ListViewHeader(this.title, this.key, this.isDeleteable,
                 this.onDeleteListViewHeader);

  ListViewHeader.notDeletable(this.title, this.key)
  {
    this.isDeleteable = false;
    onDeleteListViewHeader = ()
    {
      // Do nothing, the delete button won't be displayed
    };
  }



  @override
  ListViewHeaderState createState()
  {
    state = ListViewHeaderState(
      this.isDeleteable,
      this.onDeleteListViewHeader
    );

    return state;
  }

  void setIsDeleteable(bool isDeleteable)
  {
    this.isDeleteable = isDeleteable;

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



class ListViewHeaderState extends State<ListViewHeader>
{
  bool isDeleteable;
  Function() onDeleteListViewHeader;

  ListViewHeaderState(this.isDeleteable, this.onDeleteListViewHeader);



  @override
  Widget build(BuildContext context)
  {
    Padding deleteIcon;

    if (this.isDeleteable)
    {
      deleteIcon = _getDeleteIcon();
    }
    else
    {
      deleteIcon = _getNoDeleteIcon();
    }



    return Card(
      margin: EdgeInsets.all(4),
      color: Colors.white,
      child: InkWell(
        splashColor: this._getSplashColor(),

        onTap: (()
        {
        }),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>
          [
            deleteIcon,

            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${widget.title}',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            ),
          ],
        ),
      ),
    );
  }



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
              this.onDeleteListViewHeader();
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
    if (this.isDeleteable)
    {
      return Colors.blue;
    }

    return null;
  }
}
