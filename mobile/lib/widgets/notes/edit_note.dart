import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final String id;
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
  bool isLoading = false;

  @override
  void initState() {
    _titleController.text = widget.oldTitle;
    _contentController.text = widget.oldContent;
    super.initState();
  }

  void _submitData() async {
    if (!isLoading) {
      isLoading = true;

      final enteredTitle = _titleController.text;
      final enteredContent = _contentController.text;

      if (enteredTitle.isEmpty || enteredContent.isEmpty) {
        isLoading = false;
        return;
      }

      try {
        await widget.editNote(
          docId: widget.id,
          title: enteredTitle,
          content: enteredContent,
        );
        await Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e}')),
        );
      }
      isLoading = false;
    }
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
                key: ValueKey('titleEditNote'),
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
                  onPressed: () async {
                    if (!isLoading) {
                      isLoading = true;
                      try {
                        await widget.deleteNote(widget.id);
                        await Navigator.of(context).pop();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e}')),
                        );
                      }
                      isLoading = false;
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              IconButton(
                key: ValueKey("addEditNoteIcon"),
                onPressed: _submitData,
                icon: Icon(Icons.check),
              )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverToBoxAdapter(
              child: TextField(
                key: ValueKey('contentEditNote'),
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
