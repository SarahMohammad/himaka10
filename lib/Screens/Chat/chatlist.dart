import 'package:cached_network_image/cached_network_image.dart';
import 'chatroom.dart';

// import 'file:///home/asmaa/Desktop/himaka-main/lib/Screens/Chat/firebaseController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:himaka/Screens/Chat/utils.dart';

import 'firebaseController.dart';

class ChatList extends StatefulWidget {
  ChatList(this.myID, this.serviceProviderUserId, this.myName);

  String myID, serviceProviderUserId;
  String myName;

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    FirebaseController.instanace.getUnreadMSGCount();
    super.initState();
  }

  int _noService = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          centerTitle: true,
        ),
        body: VisibilityDetector(
          key: Key("1"),
          onVisibilityChanged: ((visibility) {
            print('ChatList Visibility code is ' +
                '${visibility.visibleFraction}');
            if (visibility.visibleFraction == 1.0) {
              FirebaseController.instanace.getUnreadMSGCount();
            }
          }),
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                    color: Colors.white.withOpacity(0.7),
                  );
                } else {
                  return countChatListUsers(widget.myID,
                              widget.serviceProviderUserId, snapshot) >
                          0
                      ? ListView(
                          children: snapshot.data.documents.map((data) {
                          if (data['userId'] == widget.myID &&
                              data['userId'] != widget.serviceProviderUserId) {
                            return Container();
                          } else {
                            return StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document(widget.myID)
                                    .collection('chatlist')
                                    .where('chatWith',
                                        isEqualTo: data['userId'])
                                    .snapshots(),
                                builder: (context, chatListSnapshot) {
                                  if (chatListSnapshot.hasData &&
                                      chatListSnapshot.data.documents.length ==
                                          0) {
                                    _noService += 1;
                                  }

                                  return chatListSnapshot.connectionState ==
                                          ConnectionState.active
                                      ? chatListSnapshot.hasData &&
                                              chatListSnapshot
                                                      .data.documents.length >
                                                  0
                                          ? listTile(chatListSnapshot, data)
                                          : isServiceProvider(
                                              data,
                                              chatListSnapshot
                                                  .data.documents.length)
                                      : Container();

//                                data['userId'] ==
//                                                widget.serviceProviderUserId
//                                            ? InkWell(
//                                                child:
//                                                    Text('move to chat room'),
//                                                onTap: () {
//                                                  _moveTochatRoom(
//                                                      data['FCMToken'],
//                                                      widget
//                                                          .serviceProviderUserId,
//                                                      //serviceProviderName
//                                                      data['name']);
//                                                },
//                                              )
//                                            : Text("");
                                });
                          }
                        }).toList())
                      : Container(
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.forum,
                                color: Colors.grey[700],
                                size: 64,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'There are no users except you.',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[700]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )),
                        );
                }
              }),
        ));
  }

  Future<void> _moveTochatRoom(
      selectedUserToken, selectedUserID, selectedUserName) async {
    try {
      String chatID = makeChatId(widget.myID, selectedUserID);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatRoom(
                  widget.myID,
                  widget.myName,
                  selectedUserID,
                  widget.serviceProviderUserId,
                  chatID,
                  selectedUserName)));
    } catch (e) {
      print(e.message);
    }
  }

  listTile(chatListSnapshot, data) {
    _noService = 1;
    print('from listTile');
    print(chatListSnapshot.data.documents.length.toString());
    print(chatListSnapshot.data.documents.toString());
    return ListTile(
      leading: Icon(Icons.person),
//                                  leading: ClipRRect(
//                                    borderRadius: BorderRadius.circular(15),
//                                    child: CachedNetworkImage(
//                                      imageUrl: data['userImageUrl'],
//                                      placeholder: (context, url) => Container(
//                                        transform:
//                                            Matrix4.translationValues(0, 0, 0),
//                                        child: Container(
//                                            width: 60,
//                                            height: 80,
//                                            child: Center(
//                                                child:
//                                                    new CircularProgressIndicator())),
//                                      ),
//                                      errorWidget: (context, url, error) =>
//                                          new Icon(Icons.error),
//                                      width: 60,
//                                      height: 80,
//                                      fit: BoxFit.cover,
//                                    ),
//                                  ),
      title: Text(data['name']),
//                                  subtitle: Text((chatListSnapshot.hasData &&
//                                          chatListSnapshot
//                                                  .data.documents.length >
//                                              0)
//                                      ? chatListSnapshot.data.documents[0]
//                                          ['lastChat']
//                                      : data['intro']),
      trailing: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 4, 4),
          child: (chatListSnapshot.hasData &&
                  chatListSnapshot.data.documents.length > 0)
              ? StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('chatroom')
                      .document(chatListSnapshot.data.documents[0]['chatID'])
                      .collection(chatListSnapshot.data.documents[0]['chatID'])
                      .where('idTo', isEqualTo: widget.myID)
                      .where('isread', isEqualTo: false)
                      .snapshots(),
                  builder: (context, notReadMSGSnapshot) {
                    return Container(
                      width: 60,
                      height: 50,
                      child: Column(
                        children: <Widget>[
                          Text(
                            (chatListSnapshot.hasData &&
                                    chatListSnapshot.data.documents.length > 0)
                                ? readTimestamp(chatListSnapshot
                                    .data.documents[0]['timestamp'])
                                : '',
                            style: TextStyle(fontSize: 12),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: CircleAvatar(
                                radius: 9,
                                child: Text(
                                  (chatListSnapshot.hasData &&
                                          chatListSnapshot
                                                  .data.documents.length >
                                              0)
                                      ? ((notReadMSGSnapshot.hasData &&
                                              notReadMSGSnapshot
                                                      .data.documents.length >
                                                  0)
                                          ? '${notReadMSGSnapshot.data.documents.length}'
                                          : '')
                                      : '',
                                  style: TextStyle(fontSize: 10),
                                ),
                                backgroundColor: (notReadMSGSnapshot.hasData &&
                                        notReadMSGSnapshot
                                                .data.documents.length >
                                            0 &&
                                        notReadMSGSnapshot.hasData &&
                                        notReadMSGSnapshot
                                                .data.documents.length >
                                            0)
                                    ? Colors.red[400]
                                    : Colors.transparent,
                                foregroundColor: Colors.white,
                              )),
                        ],
                      ),
                    );
                  })
              : Text('')),
      onTap: () {
        _moveTochatRoom(
          data['FCMToken'],
          data['userId'],
          data['name'],
        );
      },
    );
  }

  isServiceProvider(data, length) {
    print('from isServiceProvider');
    print(length.toString());
    print(data.toString());
    if (widget.myID == widget.serviceProviderUserId && _noService == 0) {
      return Container(
        child: Center(child: Text("no requests on your service yet")),
      );
    } else if (_noService == 1) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Center(
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'move to chat room',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))),
        ),
        onTap: () {
          Navigator.pop(context);
          _moveTochatRoom(
              data['FCMToken'],
              widget.serviceProviderUserId,
              //serviceProviderName
              data['name']);
        },
      );
    } else if (_noService == 0) {
      return Container(child: Text('dkkkkk'));
    } else {
      return Container();
    }
  }
}
