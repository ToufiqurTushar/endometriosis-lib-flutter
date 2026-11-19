import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../config/color_config.dart';
import '../dto/content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../dto/data.dart';
import 'item_image_with_label.dart';

class ItemCarousal extends StatefulWidget {
  final Content content;
  final BuildContext context;
  final dynamic form;
  final double elevation;
  final double padding;
  const ItemCarousal(this.content, this.context, this.form, {this.elevation = 0, this.padding = 0, super.key});

  @override
  State<ItemCarousal> createState() => _ItemCarousalState();
}

class _ItemCarousalState extends State<ItemCarousal> {
  var carouselCurrentIndex = 0;
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        CarouselSlider(
            options: CarouselOptions(
                height: 192,
                viewportFraction: .6,
                autoPlay: false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  carouselCurrentIndex = index;
                  setState(() {});
                }
            ),
            items: widget.content.options!.map<Widget>((Data data) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ItemImageWithLabel(data),
            )).toList()
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.content.options!.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: (){},
              child: Container( width: 12.0, height: 12.0, margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0), decoration: BoxDecoration( shape: BoxShape.circle, color: ColorConfig.textFieldIconColor.withOpacity(carouselCurrentIndex == entry.key ? 1 : 0.2)), ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],),
    );
  }
}
