import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final int id;
  final String oldTitle;
  final String oldContent;
  final Function editNote;
  final Function deleteNote;

  EditNote({
    this.id,
    this.oldTitle,
    this.oldContent,
    @required this.editNote,
    this.deleteNote,
  });

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.oldTitle;
    _contentController.text = widget.oldContent;
    super.initState();
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredContent = _contentController.text;

    if (enteredTitle.isEmpty || enteredContent.isEmpty) {
      return;
    }

    widget.editNote(
      id: widget.id,
      title: enteredTitle,
      content: enteredContent,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 20),
              title: TextField(
                maxLines: null,
                maxLength: 40,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.all(0),
                  hintText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
            ),
            expandedHeight: 150,
            onStretchTrigger: () {
              return Future<void>.value();
            },
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              if (widget.id != null)
                IconButton(
                  onPressed: () => {
                    widget.deleteNote(widget.id),
                    Navigator.of(context).pop(),
                  },
                  icon: Icon(Icons.delete),
                ),
              IconButton(
                onPressed: _submitData,
                icon: Icon(Icons.check),
              )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverToBoxAdapter(
              child: TextField(
                minLines: 10,
                maxLines: null,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Content',
                ),
                controller: _contentController,
                onSubmitted: (_) => _submitData(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
