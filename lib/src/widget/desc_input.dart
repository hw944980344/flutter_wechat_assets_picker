import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comment_input.dart';

class DescInput extends StatefulWidget {
  const DescInput({super.key});

  @override
  State<DescInput> createState() => _DescInputState();
}

class _DescInputState extends State<DescInput> {
  final _controller = TextEditingController();
  bool show = false;

  Future<void> _saveText() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('media_desc', _controller.text);
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          show = prefs.getBool('media_desc_show') ?? false;
        });
      }
    });
    final text = prefs.getString('media_desc');
    if ((text ?? '').isEmpty) {
      return;
    }
    _controller.text = text ?? '';
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return const SizedBox();
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, .2),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, .2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: _controller,
          onTap: () {
            // setState(() {
            //   show = false;
            // });
            Navigator.push(
              context,
              PopRoute(
                child: CommentInput(
                  text: _controller.text,
                  onSend: (val) {
                    _controller.text = val;
                    _saveText();
                    // setState(() {
                    //   show = true;
                    // });
                  },
                ),
              ),
            );
          },
          readOnly: true,
          autofocus: true,
          minLines: 1,
          maxLines: 10,
          textInputAction: TextInputAction.send,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            hintText: '请输入描述',
            hintStyle: TextStyle(
              fontSize: 15,
              // color: Color(0xFF333333),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
