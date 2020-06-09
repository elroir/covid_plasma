import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';



class CardSwiper extends StatelessWidget {


  final height;
  final width;
  final List<Widget> children;

  CardSwiper({@required this.children,this.height, this.width });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

     return Container(
       height: height!=null ? height : _screenSize.height * 0.55,
       child: Swiper(
         pagination: new SwiperPagination(alignment:Alignment.bottomCenter ,builder: SwiperPagination.dots),
         autoplay: false,
         indicatorLayout: PageIndicatorLayout.COLOR,
         itemWidth: width==null ? _screenSize.width * 0.7 : (width),
         itemHeight: height!=null ? height : _screenSize.height * 0.55,
         itemCount: children.length,
         itemBuilder: (BuildContext context,int index){
            return children[index];
          },

        ),
     );

  }
}
