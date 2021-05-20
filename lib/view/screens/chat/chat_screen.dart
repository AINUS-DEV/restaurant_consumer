import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_consumer/localization/language_constrants.dart';
import 'package:restaurant_consumer/provider/chat_provider.dart';
import 'package:restaurant_consumer/provider/profile_provider.dart';
import 'package:restaurant_consumer/utill/color_resources.dart';
import 'package:restaurant_consumer/utill/dimensions.dart';
import 'package:restaurant_consumer/utill/images.dart';
import 'package:restaurant_consumer/utill/styles.dart';
import 'package:restaurant_consumer/view/base/custom_app_bar.dart';
import 'package:restaurant_consumer/view/base/custom_snackbar.dart';
import 'package:restaurant_consumer/view/screens/chat/widget/message_bubble.dart';
import 'package:restaurant_consumer/view/screens/chat/widget/message_bubble_shimmer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final ImagePicker picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context, listen: false).getChatList(context);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('message', context)),
      body: Consumer<ChatProvider>(
        builder: (context, chat, child) {
          return Column(children: [

            Expanded(
              child: chat.chatList != null ? chat.chatList.length > 0 ? ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                itemCount: chat.chatList.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return MessageBubble(chat: chat.chatList[index], addDate: chat.showDate[index]);
                },
              ) : SizedBox() : ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                itemCount: 20,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) {
                  return MessageBubbleShimmer(isMe: index % 2 == 0);
                },
              ),
            ),

            // Bottom TextField
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Provider.of<ChatProvider>(context).imageFile != null ? Padding(
                  padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.file(Provider.of<ChatProvider>(context).imageFile, height: 70, width: 70, fit: BoxFit.cover),
                      Positioned(
                        top: -2, right: -2,
                        child: InkWell(
                          onTap: () => Provider.of<ChatProvider>(context, listen: false).setImage(null),
                          child: Icon(Icons.cancel, color: ColorResources.COLOR_WHITE),
                        ),
                      ),
                    ],
                  ),
                ) : SizedBox.shrink(),

                Container(
                  height: 100,
                  color: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 30),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(children: [
                      InkWell(
                        onTap: () async {
                          final PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            Provider.of<ChatProvider>(context, listen: false).setImage(File(pickedFile.path));
                          } else {
                            print('No image selected.');
                          }
                        },
                        child: Image.asset(Images.image, width: 25, height: 25, color: ColorResources.getGreyBunkerColor(context)),
                      ),
                      SizedBox(
                        height: 25,
                        child: VerticalDivider(width: 40, thickness: 1, color: ColorResources.getGreyBunkerColor(context)),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          textCapitalization: TextCapitalization.sentences,
                          style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: getTranslated('type_message_here', context),
                            hintStyle: rubikRegular.copyWith(color: ColorResources.getGreyBunkerColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                          ),
                          onChanged: (String newText) {
                            if(newText.isNotEmpty && !Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                              Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                            }else if(newText.isEmpty && Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                              Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                            }
                          },
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          if(Provider.of<ChatProvider>(context, listen: false).isSendButtonActive){
                            Provider.of<ChatProvider>(context, listen: false).sendMessage(
                              _controller.text, '',
                              Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString(), context,
                            );
                            _controller.text = '';
                          }else {
                            showCustomSnackBar('Write something', context);
                          }
                        },
                        child: Image.asset(
                          Images.send,
                          width: 25, height: 25,
                          color: Provider.of<ChatProvider>(context).isSendButtonActive ? Theme.of(context).primaryColor : ColorResources.getGreyBunkerColor(context),
                        ),
                      ),
                    ]),
                  ),
                ),

              ],
            ),


          ]);
        },
      ),
    );
  }
}
