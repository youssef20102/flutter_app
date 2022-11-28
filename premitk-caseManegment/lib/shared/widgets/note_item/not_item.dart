// @dart=2.9

// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable, use_key_in_widget_constructors, deprecated_member_use


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


import 'package:html/dom.dart' as dom;
import 'package:primitk_crm/shared/style/color.dart';
import 'package:url_launcher/url_launcher.dart';


class NoteItem extends StatelessWidget {

  final int id;
  final String note;
  final String createdOn;
  final String createdBy;





  const NoteItem({  this.id, this.note, this.createdOn, this.createdBy});

  @override
  Widget build(BuildContext context) {



    var html = Html(

      shrinkWrap: true,
        data: note,

        onLinkTap: (String url, RenderContext context, Map<String, String> attributes, dom.Element element) {
          //open URL in webview, or launch URL in browser, or any other logic here
          launch(url);
        },
        onImageTap: (String url, RenderContext context, Map<String, String> attributes, dom.Element element) {
          //open image in webview, or launch image in browser, or any other logic here
          launch(url);




        },

    );

    // var customer = HomeLayoutCubit.get(context).customerItems.firstWhere((element) => element.id == customerId);
    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15,
          child: Text(createdBy[0],style: const TextStyle(color: Colors.white),),
          backgroundColor:  Colors.pink[700],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Expanded(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(createdBy,style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,color: selectedColor),),
              const SizedBox(height: 10,),
              Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey[100],
                  ),
                  child: SingleChildScrollView(
                      child: html)),
            ],
          ),
        ),
      ],
    );
  }
}
