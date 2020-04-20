import 'package:csslib/visitor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';

import '../../src/models/doc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<HtmlDocument>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Html Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => rootBundle
                .loadString('assets/samples/amp.html')
                .then((value) => _model.parse(value)),
          ),
        ],
      ),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Center(
              child: ValueListenableBuilder<StyleSheet>(
                valueListenable: _model.stylesheet,
                builder: (context, style, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (style?.topLevels != null)
                          for (final node in style.topLevels) ...[
                            Text("""
                          ${node?.span?.text}
                          """),
                          ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          VerticalDivider(),
          Flexible(
            flex: 1,
            child: Center(
              child: ValueListenableBuilder<dom.Document>(
                valueListenable: _model.doc,
                builder: (context, doc, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (doc != null)
                          for (final node in doc.head.nodes) ...[
                            if (node is dom.Element &&
                                node.localName == 'style')
                              InkWell(
                                onTap: () {
                                  _model.parseCSS(node.innerHtml);
                                },
                                child: Text("""
                          ${node.innerHtml}
                          """),
                              ),
                          ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
