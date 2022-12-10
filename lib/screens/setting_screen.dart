import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  double speedRate;
  double volume;

  SettingScreen({
    Key? key,
    required this.speedRate,
    required this.volume
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // double speedRate = 50;
  // double volume = 50;

  // void increaseSpeedRate () => setState(() {
  //   speedRate += 0.25;
  // });
  //
  // void reduceSpeedRate () => setState(() {
  //   speedRate -= 0.25;
  // });
  //
  // void increaseVolume () => setState(() {
  //   volume += 0.25;
  // });
  //
  // void reduceVolume () => setState(() {
  //   volume -= 0.25;
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/setting_background.png'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 55, top: 150),
            child: Text('Tốc độ đọc',
              style: TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, top: 250),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(80)),
                child: Container(
                  height: 80,
                  width: 370,
                  child: SliderTheme(
                    data: SliderThemeData(
                        trackHeight: 80,
                        activeTrackColor: Color.fromARGB(250, 0, 158, 191),
                        inactiveTrackColor: Colors.white,
                        thumbShape: SliderComponentShape.noThumb,
                        trackShape: RectangularSliderTrackShape(),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 0)),
                    child: Slider(
                        value: widget.speedRate,
                        min: 0,
                        max: 100,
                        onChanged: (newSpeed) {
                          setState(() {
                            widget.speedRate = newSpeed;
                          });
                        }),
                  ),
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, top: 380),
            child: Text('Âm lượng',
              style: TextStyle(
                  fontSize: 58,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, top: 500),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(80)),
                child: Container(
                  height: 80,
                  width: 370,
                  child: SliderTheme(
                    data: SliderThemeData(
                        trackHeight: 80,
                        activeTrackColor: Color.fromARGB(250, 0, 158, 191),
                        inactiveTrackColor: Colors.white,
                        thumbShape: SliderComponentShape.noThumb,
                        trackShape: RectangularSliderTrackShape(),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 0)),
                    child: Slider(
                        value: widget.volume,
                        min: 0,
                        max: 100,
                        onChanged: (newVolume) {
                          setState(() {
                            widget.volume = newVolume;
                            print(widget.volume);
                          });
                        }),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
