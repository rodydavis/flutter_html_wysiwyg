import 'package:csslib/parser.dart' as cssParse;
import 'package:csslib/visitor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';

class HtmlDocument {
  final _document = ValueNotifier<Document>(null);
  ValueListenable<Document> get doc => _document;
  final _stylesheet = ValueNotifier<StyleSheet>(null);
  ValueListenable<StyleSheet> get stylesheet => _stylesheet;
  void parse(String source) {
    var _doc = Document.html(source);
    _document.value = _doc;
  }

  void parseCSS(String source) {
    var _doc = cssParse.parse(source);
    _stylesheet.value = _doc;
  }
}
