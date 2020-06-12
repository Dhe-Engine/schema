import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schema/component/todo_badge.dart';
import 'package:schema/model/hero_id_model.dart';
import 'package:schema/model/todo_model.dart';
import 'package:schema/scopedmodel/todo_list_model.dart';
import 'package:schema/utils/color_utils.dart';
import 'package:scoped_model/scoped_model.dart';

class AddToScreen extends StatefulWidget {
  
  final String taskId;
  final HeroId heroIds;
  
  AddToScreen({
    @required this.taskId,
    @required this.heroIds,
});
  
  @override
  State<StatefulWidget> createState() {
    return _AddToScreenState();
  } 
}

class _AddToScreenState extends State<AddToScreen> {
  
  String newTask;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      newTask = '';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext context, Widget child, TodoListModel model) {
        if(model.tasks.isEmpty){
          return Container(
            color: Colors.white,
          );
        }
        
        var _task = model.tasks.firstWhere((it) => it.id == widget.taskId);
        var _color = ColorUtils.getColorFrom(id: _task.color);
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'New Task',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What taskare you planning to perform?',
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0
                  ),
                ),
                Container(
                  height: 16.0,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      newTask = text;
                    });
                  },
                  cursorColor: _color,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your Task...',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 36.0
                  ),
                ),
                Container(
                  height: 26.0,
                ),
                Row(
                  children: [
                    TodoBadge(
                      codePoint: _task.codePoint,
                      color: _color,
                      id: widget.heroIds.codePointId,
                      size: 20.0,
                    ),
                    Container(
                      width: 16.0,
                    ),
                    Hero(
                      child: Text(
                        _task.name,
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      tag: "not_using_right_now",
                    ),
                  ],
                )
              ],
            ),
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                  heroTag: 'fab_new_task',
                  icon: Icon(Icons.add),
                  backgroundColor: _color,
                  label: Text('Create Task'),
                  onPressed: (){
                    if(newTask.isEmpty) {
                      final snackBar = SnackBar(
                        content: Text(
                            'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
                        backgroundColor: _color,
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                    else{
                      model.addTodo(Todo(
                        newTask,
                        parent: _task.id,
                      ));
                      Navigator.pop(context);
                    }
                  }
               );
            },
          ),
        );
      },
    );
  }
}
