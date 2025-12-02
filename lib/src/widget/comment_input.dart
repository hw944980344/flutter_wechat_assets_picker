import 'package:flutter/material.dart';

//评论框
class CommentInput extends StatefulWidget {
  const CommentInput({
    required this.focusNode,
    this.text = '',
    this.onSend,
    super.key,
  });

  final FocusNode focusNode;

  //键盘点击发送事件
  final Function(String)? onSend;
  final String text;

  @override
  State<StatefulWidget> createState() {
    return _CommentInputState();
  }
}

class _CommentInputState extends State<CommentInput> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    Navigator.pop(context);
    widget.onSend?.call(_controller.text);
  }

  @override
  void initState() {
    _controller.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _submit,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff262626),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff1E1E1E),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      onEditingComplete: _submit,
                      controller: _controller,
                      cursorColor: Colors.white,
                      autofocus: true,
                      minLines: 1,
                      maxLines: 10,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        hintText: '请输入描述',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _submit,
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff1E1E1E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: const Text(
                      '完成',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopRoute extends PopupRoute {
  PopRoute({required this.child});

  final Duration _duration = const Duration(milliseconds: 300);
  Widget child;

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
