import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';

import '../../../config/color_config.dart';
import '../dto/content.dart';
import '../dto/data.dart';
import 'form/simple_button.dart';
import 'item_image_with_label.dart';

Widget ItemLabel(Content content) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Column(
      crossAxisAlignment: content.labelAtCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if( content.label != null)
        RichText(
          text: TextSpan(
            text: content.getLabel()!,
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: content.labelAtCenter ? 20 : 16, color: content.labelAtCenter ? Colors.purple : Colors.black),
            children: <TextSpan>[
              if(content.required) const TextSpan(text: '', style: TextStyle(color: Colors.red),),
            ],
          ),
        ),
        const SizedBox(height: 4,),
        if((content.figures?.isNotEmpty??false) && !content.readOnly)
        Column(
          children: [
            const SizedBox(height: 5,),
            if(content.figuresColumn==3)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                child: Row(
                  children: content.figures!.getRange(0, 4).map<Widget>((Data data){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(width:Get.width*0.4, child: ItemImageWithLabel(data)),
                    );
                  }).toList(),
                ),
              ),
            ),

            if(content.figuresColumn==3)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                child: Row(
                  children: content.figures!.getRange(4, content.figures!.length).map<Widget>((Data data){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 12),
                      child: SizedBox(width:Get.width*0.4, child: ItemImageWithLabel(data)),
                    );
                  }).toList(),
                ),
              ),
            ),

            if(content.figuresColumn==2)
            GridView.count(
              crossAxisCount: content.figuresColumn??2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.9,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: content.figures!.map<Widget>((Data data){
                return ItemImageWithLabel(data);
              }).toList(),
            ),
          ],
        ),
        if(content.figure != null && !content.readOnly)
        Column(
          children: [
            const SizedBox(height: 5,),
            ItemImageWithLabel(content.figure!),
          ],
        ),
      ],
    ),
  ) ;
}

