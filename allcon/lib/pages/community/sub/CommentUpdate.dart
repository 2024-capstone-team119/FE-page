import 'package:flutter/material.dart';

class CommentUpdate extends StatefulWidget {
  final String content;

  const CommentUpdate({
    super.key,
    required this.content,
  });

  @override
  State<CommentUpdate> createState() => _CommentUpdateState();
}

class _CommentUpdateState extends State<CommentUpdate> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
