import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/task_icon_config.dart';
import 'package:todo_list/model/edit_task_page_model.dart';
import 'package:todo_list/model/main_page_model.dart';

class EditTaskPage extends StatelessWidget {
  final TaskIcon taskIcon;
  final MainPageModel mainPageModel;

  EditTaskPage(this.taskIcon, {this.mainPageModel});

  @override
  Widget build(BuildContext context) {
    final EditTaskPageModel model = Provider.of<EditTaskPageModel>(context);
    model.setContext(context);

    return Scaffold(
      backgroundColor: model.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: taskIcon.color),
        backgroundColor: model.bgColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                color: taskIcon.color,
              ),
              tooltip: "提交",
              onPressed: (){

              })
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 100, left: 50, right: 50),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                },
                child: ListView(
                  children: List.generate(model.taskDetails.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: taskIcon.color,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              model.taskDetails[index],
                              style: TextStyle(
                                color: Color.fromRGBO(130, 130, 130, 1),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: taskIcon.color.withOpacity(0.5),
                            ),
                            onPressed: () => model.logic.removeItem(index),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: model.bgColor,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    TextField(
                      controller: model.textEditingController
                        ..addListener(model.logic.editListener),
                      autofocus: model.taskDetails.length > 0 ? false : true,
                      decoration: InputDecoration(
                          hintText: "添加任务",
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            taskIcon.iconData,
                            color: taskIcon.color,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: model.logic.submitOneItem,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: model.canAddTask
                                      ? taskIcon.color
                                      : Colors.grey.withOpacity(0.4)),
                              child: Icon(
                                Icons.arrow_upward,
                                color: model.bgColor,
                                size: 20,
                              ),
                            ),
                          )),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          model.logic.getIconText(
                            icon: Icon(
                              Icons.date_range,
                              color: taskIcon.color,
                            ),
                            text: "截止日期",
                            onTap: () {},
                          ),
                          model.logic.getIconText(
                            icon: Icon(
                              Icons.notifications_active,
                              color: taskIcon.color,
                            ),
                            text: "提醒我",
                            onTap: () {},
                          ),
                          model.logic.getIconText(
                            icon: Icon(
                              Icons.repeat,
                              color: taskIcon.color,
                            ),
                            text: "重复",
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}