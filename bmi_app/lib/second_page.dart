import 'package:bmi_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key, this.exercisesModel}) : super(key: key);

  ExercisesModel? exercisesModel;
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.network(
          "${widget.exercisesModel?.thumbnail}",
          width: double.infinity,
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Column(
              children: [
                SleekCircularSlider(
                  innerWidget: (Value) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${second.toStringAsFixed(0)} S",
                        style: TextStyle(
                            fontSize: 39,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(progressBarWidth: 10)),
                  min: 3,
                  max: 28,
                  initialValue: second,
                  onChange: (Value) {
                    setState(() {
                      second = Value;
                    });
                  },
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.pink,
                  child: Text("Next"),
                )
              ],
            ))
      ]),
    );
  }

  double second = 3;
}
