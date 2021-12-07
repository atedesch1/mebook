import 'package:flutter/material.dart';
import 'package:mebook/models/news_model.dart';

class NewsTile extends StatefulWidget {
  NewsTile(this._article);
  final News _article;

  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  bool _isExpanded = false;

  void _expandTile() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget._article.content == null ||
            widget._article.description == null ||
            widget._article.urlToImage == null)
        ? SizedBox.shrink()
        : Material(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                InkWell(
                  onTap: _expandTile,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    height: 140,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget._article.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget._article.description,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(_isExpanded
                            ? Icons.expand_less
                            : Icons.expand_more),
                      ],
                    ),
                  ),
                ),
                if (_isExpanded)
                  Container(
                    color: Colors.grey[50],
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(widget._article.urlToImage),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget._article.content,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Divider(
                  height: 1,
                ),
              ],
            ),
          );
  }
}
