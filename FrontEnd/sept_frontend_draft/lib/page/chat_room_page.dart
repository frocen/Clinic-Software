import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sept_frontend_draft/page/chat_message_entity.dart';

class ChatRoomPage extends StatelessWidget {
  final ConversationEntity conversationData;
  static const String sName = "ChatRoomPage";

  const ChatRoomPage({Key? key, required this.conversationData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          conversationData.name,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      resizeToAvoidBottomInset: false,
      body: ChatRoomView(senderName: conversationData.name),
    );
  }
}

class ChatRoomView extends StatefulWidget {
  final String senderName;
  const ChatRoomView({Key? key, required this.senderName}) : super(key: key);

  @override
  _ChatRoomViewState createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView>
    with SingleTickerProviderStateMixin {
  late StreamSubscription<bool> keyboardSubscription;

  /// scroll control
  ScrollController scrollController = ScrollController();

  /// keyboard detection
  ValueNotifier<bool> keyBoardVisible = ValueNotifier(false);

  ValueNotifier<List<ChatDataEntity>> messages = ValueNotifier([]);

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');
    keyBoardVisible.value = keyboardVisibilityController.isVisible;

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');

      keyBoardVisible.value = visible;
      if (visible) {
        // actionVisible.value = !visible;
      }
    });

    messages.value = [
      ChatDataEntity('1', 'Hello', MsgDirection.send),
      ChatDataEntity('2', 'Hi', MsgDirection.receive),
      ChatDataEntity('3', 'How are you?', MsgDirection.send),
      ChatDataEntity(
          '4', 'I am fine, thank you. And you?', MsgDirection.receive),
    ];
  }

  double calculateTextHeight(
    BuildContext context,
    BoxConstraints constraints, {
    String text = '',
    required TextStyle textStyle,
    List<InlineSpan> children = const [],
  }) {
    final span = TextSpan(text: text, style: textStyle, children: children);

    final richTextWidget = Text.rich(span).build(context) as RichText;
    final renderObject = richTextWidget.createRenderObject(context);
    renderObject.layout(constraints);
    return renderObject.computeMinIntrinsicHeight(constraints.maxWidth);
  }

  double calculateMsgHeight(
      BuildContext context, BoxConstraints constraints, ChatDataEntity entity) {
    return 30 +
        calculateTextHeight(
          context,
          constraints,
          text: 'My',
          textStyle: TextStyle(
            fontSize: 12,
          ),
        ) +
        calculateTextHeight(
          context,
          constraints.copyWith(
            maxWidth: 200,
          ),
          text: entity.text,
          textStyle: TextStyle(
            fontSize: 14,
          ),
        ) +
        34;
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFFF2F2F2),
      child: Column(
        children: [
          Expanded(
              child: ValueListenableBuilder<List<ChatDataEntity>>(
                  valueListenable: messages,
                  builder: (context, value, child) {
                    return LayoutBuilder(builder: (context, constraints) {
                      return NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          if (notification is UserScrollNotification) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                          return false;
                        },
                        child: CustomScrollView(
                          controller: scrollController,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final item = value[index];
                                  return ChatTextItem(
                                    messageEntity: item,
                                    senderName: widget.senderName,
                                  );
                                },
                                childCount: value.length,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  })),
          ChatInputToolWidget(
            keyBoardVisible: keyBoardVisible,
            msgSendCallBack: (String value) {
              final list = messages.value;
              list.add(
                ChatDataEntity((int.parse(list.last.messageId) + 1).toString(),
                    value, MsgDirection.send),
              );
              messages.value = list;
              // scrollController.animateTo(scrollController.position.maxScrollExtent,
              //     duration: const Duration(milliseconds: 150), curve: Curves.linear);
            },
          ),
          // ChatActionWidget(viewModel: viewModel),
        ],
      ),
    );
  }
}

class ChatInputToolWidget extends StatefulWidget {
  final ValueChanged<String> msgSendCallBack;
  final ValueNotifier<bool> keyBoardVisible;

  const ChatInputToolWidget(
      {Key? key, required this.msgSendCallBack, required this.keyBoardVisible})
      : super(key: key);

  @override
  _ChatInputToolWidgetState createState() => _ChatInputToolWidgetState();
}

class _ChatInputToolWidgetState extends State<ChatInputToolWidget> {
  /// edit control
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.keyBoardVisible,
      builder: (context, value, child) {
        double scrollOffset = 0;
        if (value == true) {
          /// keyboard show
          scrollOffset = MediaQuery.of(context).viewInsets.bottom;
        } else {
          /// keyboard dismiss
          scrollOffset = MediaQuery.of(context).padding.bottom;
        }
        return Stack(
          children: [
            AnimatedContainer(
              alignment: Alignment.topCenter,
              height: scrollOffset + 56,
              padding: EdgeInsets.fromLTRB(16, 13, 16, 13),
              width: double.infinity,
              color: Colors.white,
              curve: Curves.decelerate,
              duration: Duration(milliseconds: 150),
              child: Row(
                children: <Widget>[
                  GestureDetector(onTap: () {}, child: Icon(Icons.ac_unit)),
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.send,
                        controller: editingController,
                        onSubmitted: (value) {
                          if (value.trim().isEmpty) {
                            return;
                          }
                          editingController.clear();
                          FocusManager.instance.primaryFocus?.unfocus();
                          widget.msgSendCallBack.call(value);
                        },
                        onEditingComplete: () {},
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 16),
                          hintText: "Please input your message...",
                          hintStyle: TextStyle(
                            color: Color(0xFF979797),
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF979797), width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF979797), width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.emoji_emotions),
                  Icon(Icons.add_circle_outlined)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChatTextItem extends StatelessWidget {
  final ChatDataEntity messageEntity;
  final String senderName;
  const ChatTextItem(
      {Key? key, required this.messageEntity, required this.senderName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: (messageEntity.messageType == MsgDirection.receive
            ? MainAxisAlignment.start
            : MainAxisAlignment.end),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
                messageEntity.messageType == MsgDirection.receive
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                messageEntity.messageType == MsgDirection.receive
                    ? senderName
                    : ' Me',
                style: TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 12,
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 206),
                margin: EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        messageEntity.messageType == MsgDirection.receive
                            ? 0
                            : 20),
                    topRight: Radius.circular(
                        messageEntity.messageType == MsgDirection.receive
                            ? 20
                            : 0),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: (messageEntity.messageType == MsgDirection.receive
                      ? Colors.white
                      : Color(0xFF2571EA)),
                ),
                padding: EdgeInsets.all(17),
                child: Text(
                  messageEntity.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: messageEntity.messageType == MsgDirection.receive
                        ? Color(0xFF000000)
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
