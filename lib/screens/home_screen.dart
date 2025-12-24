import 'package:flutter/material.dart';
import 'package:orcal_ai_flutter/mock/mock_data.dart';
import 'package:orcal_ai_flutter/network/firebase/dtos/chat_message.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart';
import 'package:orcal_ai_flutter/widgets/orcal_textfield_with_label.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    /// Scroll to bottom initially
    scrollToBottom();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels <= 0) {
        if (!isLoadingMore) {
          print("Loading more chat.");
          setState(() {
            isLoadingMore = true;
          });
          await Future.delayed(Duration(seconds: 5));
          setState(() {
            isLoadingMore = false;
          });
        }
      }
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          "Hi... Zaw Htet Naing",
          style: TextStyle(
            color: Colors.white,
            fontSize: kTextRegular3X,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              /// TODO: - Notify bloc for knowledge base
            },
            icon: Image.asset(
              Images.kKnowledgeBaseLogo,
              width: kMargin28,
              height: kMargin28,
            ),
          ),
          IconButton(
            onPressed: () {
              /// TODO: - Notify Bloc for knowledge base.
            },
            icon: Image.asset(
              Images.kLogoutLogo,
              width: kMargin28,
              height: kMargin28,
            ),
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              /// Chat Messages
              Positioned.fill(
                child: Column(
                  children: [
                    /// Loading Header
                    if(isLoadingMore)
                      Padding(
                          padding: EdgeInsets.only(top: kMarginMedium),
                          child: LoadingMoreChatMessages(),
                        ),


                    /// Chat Body
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.fromLTRB(
                          kMarginMedium2,
                          kMarginMedium2,
                          kMarginMedium2,
                          120.0,
                        ),
                        itemCount: MockData.getConversation().length,
                        itemBuilder: (context, index) {
                          return ChatListItem(
                            chatMessage: MockData.getConversation()[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: kMarginLarge),
                      ),
                    ),
                  ],
                ),
              ),

              /// Chat Bar
              Align(alignment: Alignment.bottomCenter, child: ChatBar()),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingMoreChatMessages extends StatelessWidget {
  const LoadingMoreChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        SizedBox(
          width: kMarginLarge,
          height: kMarginLarge,
          child: CircularProgressIndicator(color: kPrimaryColor),
        ),
        Padding(
          padding: EdgeInsets.only(left: kMarginCardMedium2),
          child: Text(
            "Loading chat history...",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: kTextRegular,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class ChatListItem extends StatelessWidget {
  final ChatMessage chatMessage;

  const ChatListItem({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    if (chatMessage.isUser()) {
      /// User Chat Message
      return Padding(
        padding: EdgeInsets.only(left: kMarginXXLarge),
        child: Container(
          padding: EdgeInsets.all(kMarginCardMedium2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMarginCardMedium2),
            color: kUserChatBackground,
          ),
          child: Text(
            chatMessage.content,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else if (chatMessage.isModel()) {
      /// Model Chat Message
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: kMarginMedium,
        children: [
          Image.asset(
            Images.kAppLogo,
            width: kChatLogoSize,
            height: kChatLogoSize,
          ),
          Text(
            chatMessage.content,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return Text("Unknown Speaker");
    }
  }
}

class ChatBar extends StatelessWidget {
  const ChatBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kChatBarHeight,
      padding: EdgeInsets.all(kMarginCardMedium2),
      color: kBackgroundColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: OrcalTextField(
              onTextChanged: (chat) {},
              hint: "Say Something...",
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              padding: EdgeInsets.all(kMarginCardMedium2),
              onPressed: () {
                /// TODO: - Notify Bloc to send messages
              },
              icon: Image.asset(
                Images.kSend,
                width: kMarginXLarge,
                height: kMarginXLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
