import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SensorWidget extends StatefulWidget {
  const SensorWidget({Key? key}) : super(key: key);

  @override
  State<SensorWidget> createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: SfRadialGauge(
          title: GaugeTitle(
              text: 'hhhgff',
          ),
    axes: <RadialAxis>[
            RadialAxis(
                axisLabelStyle: const GaugeTextStyle(
                    fontFamily: 'IranSans'),
                tickOffset: 30,
                labelOffset: 30,
                showAxisLine: false,
                useRangeColorForAxis: true,
                minimum: 0,
                maximum: 1,
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 10,
                      color: Colors.green,
                      startWidth: 0,
                      endWidth: 10),
                  GaugeRange(
                      startValue: 0,
                      endValue: 10,
                      color: Colors.orange,
                      startWidth: 10,
                      endWidth: 20),
                  GaugeRange(
                      startValue:
                      10,
                      endValue:
                      10,
                      color: Colors.red,
                      startWidth: 20,
                      endWidth: 30)
                ],
                pointers: <GaugePointer>[
                  const NeedlePointer(
                      value: 12)
                ],
                annotations: <GaugeAnnotation>[
                  const GaugeAnnotation(
                      widget: Text(
                          '123',
                          ),
                      angle: 90,
                      positionFactor: 0.5)
                ])
          ]),
    );
  }
}
