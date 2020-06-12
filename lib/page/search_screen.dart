import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:schema/internal/localizations.dart';
import 'package:schema/model/todo_model.dart';
import 'package:schema/scopedmodel/todo_list_model.dart';

class SearchSchema extends StatefulWidget {

  final List<Todo> todoList;

  SearchSchema({@required this.todoList});

  @override
  _SearchSchemaState createState() =>  new _SearchSchemaState(todoList);
}

class _SearchSchemaState extends State<SearchSchema> {

  List<Todo> todoList;

  _SearchSchemaState(List<Todo> providedSchemaList) {
    this.todoList = providedSchemaList;
  }

  static GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  static String searchTerms = "";

  TextEditingController searchController = TextEditingController(
      text: searchTerms);

  //SearchFiltersProvider searchFilters;

  AppLocalizations locales;

  bool firstRun = true;

  FocusNode mainNode = FocusNode();

  @override
  Widget build(BuildContext context) {
//    locales = AppLocalizations.of(context);

    if(firstRun) {
      FocusScope.of(context).requestFocus(mainNode);

      firstRun = false;
    }

    List<Widget> widgets = SchemaSearchList(context);

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 20,
              right: 20,
              bottom: 60),
            child: searchTerms ==""
              ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.short_text,
                    size: 50.0,
                    color: HSLColor.fromColor(
                      Theme.of(context).textTheme.headline.color)
                      .withAlpha(0.4)
                      .toColor()),
                    Text(
                      locales.searchSchema_noQuery,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: HSLColor.fromColor(
                          Theme.of(context).textTheme.headline.color
                        )
                          .withAlpha(0.4)
                          .toColor(),
                      ),
                    )
                ],
              ),
            )
                :widgets.length == 0
              ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search,
                  size: 50.0,
                    color: HSLColor.fromColor(Theme.of(context)
                      .textTheme
                        .headline
                        .color
                    )
                    .withAlpha(0.4)
                    .toColor(),
                  ),
                  Text(
                    locales.searchSchema_nothingFound,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: HSLColor.fromColor(Theme.of(context)
                        .textTheme
                          .headline
                          .color
                      )
                        .withAlpha(0.4)
                        .toColor(),
                    ),
                  ),
                ],
              ),
            )
                :ListView(
              children: widgets,
            ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              margin: EdgeInsets.all(0),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        tooltip: "Back",
                        onPressed: (){
                          Navigator.pop(context);
                          setState(() => searchTerms = "");
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: locales.searchSchema_searchbar,
                              hintStyle: TextStyle(fontSize: 18),
                            ),
                            focusNode: mainNode,
                            maxLines: 1,
                            onChanged: (text) {
                              setState(() {
                                searchTerms = text;
                                widgets = SchemaSearchList(context);
                              });
                            },
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      IconButton(icon: Icon(Icons.filter_list),
                          tooltip: "Search filters",
                          onPressed: () async {
                            showFiltersScrollableBottomSheet(context);
                          })
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

  }

  List<Widget> SchemaSearchList(BuildContext context) {

  }

  Future<void> showFiltersScrollableBottomSheet(BuildContext context) async {}
}
