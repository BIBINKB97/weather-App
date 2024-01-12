import 'package:flutter/material.dart';
import 'package:weather_app/data/image_path.dart';
import 'package:weather_app/utils/apptext.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40, right: 20, bottom: 20, left: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(background[0]),
        )),
        child: Stack(children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            data: 'Dubai',
                            color: Colors.white,
                            size: 18,
                            fw: FontWeight.w700,
                          ),
                          AppText(
                            data: 'Good Morning',
                            color: Colors.white,
                            size: 14,
                            fw: FontWeight.w400,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 32,
                    ))
              ],
            ),
          ),
          Align(
              alignment: Alignment(0, -0.7), child: Image.asset(imagePath[6])),
          Align(
            alignment: Alignment(0, 0),
            child: SizedBox(
              height: 130,
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    data: '21 °C ',
                    color: Colors.white,
                    fw: FontWeight.bold,
                    size: 32,
                  ),
                  AppText(
                    data: 'Cloudy',
                    color: Colors.white,
                    fw: FontWeight.w600,
                    size: 26,
                  ),
                  AppText(
                    data: DateTime.now().toString(),
                    color: Colors.white,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Column(
              children: [
                Row(
                  children: [
                    
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
