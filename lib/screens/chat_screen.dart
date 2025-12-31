import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orcal_ai_flutter/actions/chat_actions.dart';
import 'package:orcal_ai_flutter/blocs/chat_bloc.dart';
import 'package:orcal_ai_flutter/network/firebase/dtos/chat_message.dart';
import 'package:orcal_ai_flutter/network/firebase/dtos/firestore_user.dart';
import 'package:orcal_ai_flutter/states/chat_state.dart';
import 'package:orcal_ai_flutter/utils/colors.dart';
import 'package:orcal_ai_flutter/utils/dimens.dart';
import 'package:orcal_ai_flutter/utils/images.dart';
import 'package:orcal_ai_flutter/utils/routes.dart';
import 'package:orcal_ai_flutter/utils/strings.dart';
import 'package:orcal_ai_flutter/utils/widget_utils.dart';
import 'package:orcal_ai_flutter/widgets/orcal_textfield_external_text.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: ChatScreenBody(),
    );
  }
}

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({super.key});

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  final ScrollController _scrollController = ScrollController();

  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    /// Scroll to bottom initially
    scrollToBottom();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels <= 0) {
        context.read<ChatBloc>().onAction(OnChatListEndReached());
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
    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (prev, curr) => prev.events != curr.events,
      listener: (context, state) {
        switch (state.events) {
          case ChatEvents.initial:
            break;
          case ChatEvents.clearChatBox:
            break;
          case ChatEvents.showLoading:
            break;
          case ChatEvents.dismissLoading:
            break;
          case ChatEvents.showError:
            showErrorDialog(
              context: context,
              errorMessage: state.errorMessage,
              onTapOk: () {
                context.read<ChatBloc>().onAction(OnDismissDialog());
              },
            );
            break;
          case ChatEvents.scrollToBottom:
            scrollToBottom();
            break;
          case ChatEvents.navigateToKnowledgeBase:
            context.pushNamed(kAddKnowledgeBaseOneRoute);
            break;
          case ChatEvents.showLogoutDialog:
            showLogoutDialog(
              context: context,
              onTapOk: () {
                context.read<ChatBloc>().onAction(OnTapConfirmLogout());
              },
              onTapCancel: (){
                context.read<ChatBloc>().onAction(OnDismissDialog());
              }
            );
            break;
          case ChatEvents.navigateToLogin:
            context.goNamed(kLoginRoute);
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: BlocSelector<ChatBloc, ChatState, FirestoreUser?>(
            selector: (state) => state.user,
            builder: (context, user) => Text(
              (user != null) ? "Hi... ${user.userName}" : "",
              style: TextStyle(
                color: Colors.white,
                fontSize: kTextRegular3X,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                context.read<ChatBloc>().onAction(OnTapEditKnowledgeBase());
              },
              icon: Image.asset(
                Images.kKnowledgeBaseLogo,
                width: kMargin28,
                height: kMargin28,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<ChatBloc>().onAction(OnTapLogout());
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
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      /// Loading Header
                      BlocSelector<ChatBloc, ChatState, bool>(
                        selector: (state) => state.isLoadingMoreMessages,
                        builder: (context, isLoadingMoreMessages) =>
                            (isLoadingMoreMessages)
                            ? SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: kMarginMedium,
                                  ),
                                  child: LoadingMoreChatMessages(),
                                ),
                              )
                            : SliverToBoxAdapter(child: SizedBox.shrink()),
                      ),

                      /// Chat Body
                      BlocSelector<ChatBloc, ChatState, List<ChatMessage>>(
                        selector: (state) => state.messages,
                        builder: (context, chatMessages) =>
                            (chatMessages.isNotEmpty)
                            ? SliverPadding(
                                padding: EdgeInsets.fromLTRB(
                                  kMarginMedium2,
                                  kMarginMedium2,
                                  kMarginMedium2,
                                  120.0,
                                ),
                                sliver: SliverList.separated(
                                  itemCount: chatMessages.length,
                                  itemBuilder: (context, index) {
                                    return ChatListItem(
                                      chatMessage: chatMessages[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: kMarginLarge),
                                ),
                              )
                            : SliverToBoxAdapter(child: SizedBox.shrink()),
                      ),

                      BlocSelector<ChatBloc, ChatState, bool>(
                        selector: (state) => state.isAILoading,
                        builder: (context, isAILoading) {
                          if (isAILoading) {
                            return SliverPadding(
                              padding: EdgeInsets.only(
                                left: kMarginMedium2,
                                top: kMarginMedium2,
                                right: kMarginMedium2,
                                bottom: 120.0,
                              ),
                              sliver: SliverToBoxAdapter(
                                child: AILoadingView(),
                              ),
                            );
                          } else {
                            return SliverToBoxAdapter(child: SizedBox.shrink());
                          }
                        },
                      ),
                    ],
                  ),
                ),

                /// Loading Indicator
                Align(
                  alignment: Alignment.center,
                  child: BlocSelector<ChatBloc, ChatState, ChatEvents>(
                    selector: (state) => state.events,
                    builder: (context, chatEvent) {
                      if (chatEvent == ChatEvents.showLoading) {
                        return Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: kLoadingIndicatorSize,
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),

                /// Empty View.
                Align(
                  alignment: Alignment.center,
                  child: BlocSelector<ChatBloc, ChatState, ChatEvents>(
                    selector: (state) => state.events,
                    builder: (context, event) =>
                        BlocSelector<ChatBloc, ChatState, List<ChatMessage>>(
                          selector: (state) => state.messages,
                          builder: (context, messages) {
                            if (messages.isEmpty &&
                                event != ChatEvents.showLoading) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: kChatEmptyViewMarginBottom,
                                ),
                                child: ChatEmptyView(),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                  ),
                ),

                /// Chat Bar
                Align(alignment: Alignment.bottomCenter, child: ChatBar()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AILoadingView extends StatelessWidget {
  const AILoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: kMarginCardMedium2,
      children: [
        LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.white,
          size: kChatLoadingIndicatorSize,
        ),
        Text(
          kGenerating,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: kMarginCardMedium2,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Images.kAppLogo,
            width: kChatEmptyLogoSize,
            height: kChatEmptyLogoSize,
          ),
          Text(
            kChatEmptyText,
            style: TextStyle(color: Colors.white, fontSize: kTextLarge),
          ),
        ],
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

class ChatBar extends StatefulWidget {
  const ChatBar({super.key});

  @override
  State<ChatBar> createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  final TextEditingController _controller = TextEditingController();
  late VoidCallback _listener;
  bool isSendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _listener = () {
      context.read<ChatBloc>().onAction(
        OnUserMessageChanged(userMessage: _controller.text),
      );
      setState(() {
        isSendButtonEnabled = _controller.text.isNotEmpty;
      });
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(_listener);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (prev, curr) => prev.events != curr.events,
      listener: (context, state) {
        if (state.events == ChatEvents.clearChatBox) {
          _controller.clear();
        }
      },
      child: Container(
        height: kChatBarHeight,
        padding: EdgeInsets.all(kMarginCardMedium2),
        color: kBackgroundColor,
        child: Stack(
          children: [
            Positioned.fill(
              child: BlocSelector<ChatBloc, ChatState, bool>(
                selector: (state) => state.isAILoading,
                builder: (context, isAILoading) => OrcalTextFieldExternalText(
                  controller: _controller,
                  hint: kChatHint,
                  isEnabled: !isAILoading,
                  innerPadding: EdgeInsets.only(right: kMarginXXLarge),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                padding: EdgeInsets.all(kMarginCardMedium2),
                onPressed: () {
                  /// Will notify bloc only if send button is enabled.
                  if (isSendButtonEnabled) {
                    context.read<ChatBloc>().onAction(OnTapSendUserMessage());
                  }
                },
                icon: Image.asset(
                  Images.kSend,
                  width: kMarginXLarge,
                  height: kMarginXLarge,
                  color: (isSendButtonEnabled) ? null : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
