import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/image_path.dart';
import 'package:weather_app/services/location_provider.dart';
import 'package:weather_app/services/weather_service_provider.dart';
import 'package:weather_app/utils/apptext.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceProvider>(context, listen: false)
              .fetchWeatherDateByCity(city);
        }
      }
    });

    // Provider.of<LocationProvider>(context, listen: false).determinePosition();
    // Provider.of<WeatherServiceProvider>(context, listen: false)
    //     .fetchWeatherDateByCity("dubai");

    super.initState();
  }

  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController _cityController = TextEditingController();
    @override
    void dispose() {
      _cityController.dispose();
      super.dispose();
    }

    final locationProvider = Provider.of<LocationProvider>(context);
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);

    int sunriseTimeStap = weatherProvider.weather?.sys?.sunrise ?? 0;
    int sunsetTimeStap = weatherProvider.weather?.sys?.sunset ?? 0;

    DateTime sunriseDateTime =
        DateTime.fromMicrosecondsSinceEpoch(sunriseTimeStap);

    DateTime sunsetDateTime =
        DateTime.fromMicrosecondsSinceEpoch(sunsetTimeStap);

    String formattedSunrise = DateFormat.Hm().format(sunriseDateTime);
    String formattedSunset = DateFormat.Hm().format(sunsetDateTime);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(top: 40, right: 20, bottom: 20, left: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
              background[weatherProvider.weather?.weather![0].main ?? "N/A"] ??
                  "assets/img/clouds.jpg"),
        )),
        child: Stack(children: [
          SizedBox(
              height: 50,
              child: Consumer<LocationProvider>(
                  builder: (context, locationProvider, widget) {
                var locationCity;
                if (locationProvider.currentLocationName != null) {
                  locationCity = locationProvider.currentLocationName!.locality;
                } else {
                  locationCity = "Unknown Location";
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
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
                                data: locationCity,
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
                      icon: Icon(
                        Icons.search,
                        size: 32,
                      ),
                      onPressed: () {
                        setState(() {
                          _clicked = !_clicked;
                        });
                      },
                    )
                  ],
                );
              })),
          Align(
              alignment: Alignment(0, -0.7),
              child: Image.asset(imagePath[
                      weatherProvider.weather?.weather![0].main ?? "N/A"] ??
                  "assets/img/snow.png")),
          Align(
            alignment: Alignment(0, 0),
            child: SizedBox(
              height: 150,
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    data:
                        "${weatherProvider.weather!.main!.temp?.toStringAsFixed(0)}\u00B0 C",
                    color: Colors.white,
                    fw: FontWeight.bold,
                    size: 32,
                  ),
                  AppText(
                    data: weatherProvider.weather!.name ?? "N/A",
                    color: Colors.white,
                    fw: FontWeight.w600,
                    size: 22,
                  ),
                  AppText(
                    data: weatherProvider.weather!.weather![0].main ?? "N/A",
                    color: Colors.white,
                    fw: FontWeight.w600,
                    size: 26,
                  ),
                  AppText(
                    data: DateFormat("hh:mm:a").format(DateTime.now()),
                    color: Colors.white,
                    fw: FontWeight.w600,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.4)),
              height: 150,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/img/temperature-high.png',
                            height: 55,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data: 'Temp Max',
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 14,
                              ),
                              AppText(
                                data:
                                    "${weatherProvider.weather?.main!.tempMax?.toStringAsFixed(0) ?? "N/A"}\u00B0 C",
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 14,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/img/temperature-low.png',
                            height: 55,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data: 'Temp Min',
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 14,
                              ),
                              AppText(
                                data:
                                    "${weatherProvider.weather?.main!.tempMin?.toStringAsFixed(0) ?? "N/A"}\u00B0 C",
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 14,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 1.5,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/img/sun.png',
                            height: 55,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data: 'Sunrise',
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 14,
                              ),
                              AppText(
                                data: "${formattedSunrise}AM",
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 14,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/img/moon.png',
                            height: 55,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data: 'Sunset',
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 14,
                              ),
                              AppText(
                                data: "${formattedSunset}PM",
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 14,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _clicked == true
              ? Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              hintText: "Search by city",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              weatherProvider
                                  .fetchWeatherDateByCity(_cityController.text);
                            },
                            icon: Icon(Icons.search))
                      ],
                    ),
                  ))
              : Container(),
        ]),
      ),
    );
  }
}
