import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';

import '../../../../../core/constants/dimens.dart';
import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/styles.dart';

class SensorWidget extends StatefulWidget {
  SensorWidget({required this.title, required this.type, Key? key})
      : super(key: key);

  String? title;
  String? type;

  @override
  State<SensorWidget> createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              Images.right,
              width: MediaQuery.sizeOf(context).width / 3,
              color: CustomColors.foregroundColor,
            ),
            Text(
              widget.type == '1'
                  ? 'سنسور دما'
                  : widget.type == '2'
                      ? 'سنسور رطوبت'
                      : widget.type == '3'
                          ? 'سنسور گاز'
                          : 'سنسور خاک',
              style: AppStyles.style1,
            ),
            SvgPicture.asset(
              Images.left,
              width: MediaQuery.sizeOf(context).width / 3,
              color: CustomColors.foregroundColor,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 4,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            image: const DecorationImage(
                image: AssetImage(Images.logo),
                fit: BoxFit.cover,
                opacity: 0.05),
          ),
          child: SfRadialGauge(
              title: GaugeTitle(
                text: widget.title ?? '',
              ),
              axes: <RadialAxis>[
                RadialAxis(
                    axisLabelStyle:
                        const GaugeTextStyle(fontFamily: 'IranSans'),
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
                          color: CustomColors.foregroundColor,
                          startWidth: 10,
                          endWidth: 20),
                      GaugeRange(
                          startValue: 10,
                          endValue: 10,
                          color: Colors.red,
                          startWidth: 20,
                          endWidth: 30)
                    ],
                    pointers: <GaugePointer>[
                      const NeedlePointer(value: 12)
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
        ),
      ],
    );
  }
}
