import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Draggable getDraggableTextElement(String mainText, Object data)
{
  return Draggable(
    axis: Axis.vertical,

    child: Text(mainText, style: TextStyle(fontSize: 36),),
    feedback: Text(mainText, style: TextStyle(fontSize: 36)),
    childWhenDragging: Text("BEING DRAGGED", style: TextStyle(fontSize: 36)),

    data: data, // Store information about the draggable
  );
}

DragTarget getDragTarget()
{
  return DragTarget(
    builder: (BuildContext context, List candidateData, List rejectedData)
    {
      return Text("TARGET", style: TextStyle(fontSize: 72));
    },
    onAccept: (data)
    {
      print(data);
    },
  );
}