import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {

  static AppLocalizations of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /* -- Semantics related -- */

  String get semantics_schemaMainPage_search => Intl.message(
    "Search category",
    name: "semantics_schemaMainPage_search",
  );

  /* -- SearchRoute related -- */

  String get searchSchema_searchbar => Intl.message(
    "Search...",
    name: "searchSchema_searchbar",
  );

  String get searchSchema_noQuery => Intl.message(
    "Input something to start the search",
    name: "searchSchema_noQuery",
  );

  String get searchSchema_nothingFound => Intl.message(
    "No category found...",
    name: "searchSchema_nothingFound",
  );

  String get searchSchema_filters_title => Intl.message(
    "Search filters",
    name: "searchSchema_filters_title",
  );

  String get searchSchema_filters_case => Intl.message(
    "Case sensitive",
    name: "searchSchema_filters_case",
  );

  String get searchSchema_filters_color => Intl.message(
    "Color filter",
    name: "searchSchema_filters_color",
  );

  String get searchSchema_filters_date => Intl.message(
    "Date filter",
    name: "searchSchema_filters_date",
  );



}