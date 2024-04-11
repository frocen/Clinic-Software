import 'package:flutter/material.dart';
import 'package:sept_frontend_draft/page/chat_message_entity.dart';
import 'package:sept_frontend_draft/page/chat_room_page.dart';

class ConversationPage extends StatefulWidget {
  static const String sName = "ConversationPage";

  const ConversationPage({Key? key}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late List<ConversationEntity> list;

  @override
  void initState() {
    super.initState();

    list = [
      ConversationEntity('Toby', 'Hello', '2022-10-14 21:01', '1'),
      ConversationEntity('Yezi', 'Hello', '2022-10-14 19:32', '2'),
      ConversationEntity('HuiKai', 'Hello', '2022-10-14 17:54', '3'),
      ConversationEntity('Ning', 'Hello', '2022-10-12 15:33', '4'),
      ConversationEntity('Yuxiang', 'Hello', '2022-10-12 15:32', '5'),
      ConversationEntity('Bin Laden', 'Hello', '2001-9-11 8:59', '6'),
      ConversationEntity('Gorbachev', 'Hello', '1991-12-25 23:59', '7'),
      ConversationEntity('John F. Kennedy', 'Hello', '1963-11-22 18:30', '8'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversation List',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Color(0xFFF5F4FB),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ConversationItem(
              entity: list[index],
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 0.5,
              thickness: 0.5,
              indent: 24,
              color: Color(0xFFF2F2F2),
            );
          },
          itemCount: list.length,
        ),
      ),
    );
  }
}

class ConversationItem extends StatelessWidget {
  final ConversationEntity entity;

  const ConversationItem({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ChatRoomPage.sName, arguments: entity);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.fromLTRB(21, 14, 16, 14),
        color: Colors.white,
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(
                Icons.face_outlined,
                size: 40,
              ),
              radius: 20.0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 11, right: 16),
                padding: EdgeInsets.only(top: 5, bottom: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.name,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      entity.laseMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF979797),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  entity.receiverTime,
                  style: TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
