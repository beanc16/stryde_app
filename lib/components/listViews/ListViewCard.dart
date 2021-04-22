import 'package:Stryde/components/toggleableWidget/EmptyWidget.dart';
import 'package:Stryde/models/ExerciseInformation.dart';
import 'package:Stryde/models/ExerciseMovementType.dart';
import 'package:Stryde/models/ExerciseMuscleType.dart';
import 'package:Stryde/models/ExerciseWeightType.dart';
import 'package:Stryde/models/MuscleGroup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Stryde/components/strydeHelpers/constants/StrydeColors.dart';
import 'package:universal_io/io.dart';

class ListViewCard extends StatefulWidget
{
  late final int? exerciseOrSupersetId;
  late final String title;
  late final String? description;
  late final ExerciseWeightType? exerciseWeightType;
  late final ExerciseMuscleType? exerciseMuscleType;
  late final ExerciseMovementType? exerciseMovementType;
  late final List<MuscleGroup>? muscleGroups;
  late final bool shouldCreate;
  bool shouldDelete;
  late final List<ExerciseInformation> information;

  late final Key key;
  late bool shouldLeftIndent;
  late bool isReorderable = true;
  late Function()? onDeleteListViewCard;
  late Function(BuildContext, dynamic)? onTap;
  late ListViewCardState state;
  late dynamic data;

  ListViewCard(this.exerciseOrSupersetId, this.title, this.description, this.key,
               this.shouldLeftIndent, this.onDeleteListViewCard,
               {
                 Function(BuildContext, dynamic)? onTap,
                 dynamic data,
                 required this.exerciseWeightType,
                 required this.exerciseMuscleType,
                 required this.exerciseMovementType,
                 required this.muscleGroups,
                 required this.shouldCreate,
                 required this.shouldDelete,
                 required this.information,
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

  ListViewCard.notReorderable(this.exerciseOrSupersetId, this.title,
                              this.description, this.key,
                              this.shouldLeftIndent,
                              {
                                Function(BuildContext, dynamic)? onTap,
                                dynamic data,
                                required this.exerciseWeightType,
                                required this.exerciseMuscleType,
                                required this.exerciseMovementType,
                                required this.muscleGroups,
                                required this.shouldCreate,
                                required this.shouldDelete,
                                required this.information,
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

    //if (state != null)
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

    //if (state != null)
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
  Function()? onDeleteListViewCard;
  Function(BuildContext, dynamic)? onTap;
  dynamic data;
  MaterialColor _splashColor = StrydeColors.lightBlueMat;

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
    Widget reorderIcon;
    Widget deleteIcon;

    if (widget.shouldLeftIndent)
    {
      leftMargin *= 8;
    }

    if (this.isReorderable)
    {
      deleteIcon = _getDeleteIcon();

      if (Platform.isIOS || Platform.isAndroid)
      {
        reorderIcon = _getReorderIcon();
      }
      else
      {
        reorderIcon = _getNoReorderIcon();
      }
    }
    else
    {
      reorderIcon = _getEditIcon(context);
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
        splashColor: _splashColor,

        onTap: () => (){},

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

            reorderIcon
          ],
        ),
      ),
    );
  }

  bool isIndented()
  {
    return shouldLeftIndent;
  }



  Padding _getReorderIcon()
  {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Icon(
        Icons.reorder,
        color: StrydeColors.lightGray,
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
            color: Colors.red[600],
            onPressed: ()
            {
              this.onDeleteListViewCard!();
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

  Widget _getEditIcon(BuildContext context)
  {
    if (!isReorderable)
    {
      return Container(
        child: Padding(
          padding: EdgeInsets.zero,
          child: MaterialButton(
            color: StrydeColors.purpleMat[500],
            onPressed: () => this.onTap!(context, this.data),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 14.0,
            ),
            shape: CircleBorder(),
            //padding: EdgeInsets.all(12),
          ),
        )
      );
    }

    else
    {
      return EmptyWidget();
    }
  }
}
