import 'package:allcon/Pages/Calendar/CalendarMain.dart';
import 'package:allcon/Pages/seat/SeatLayout/CustomFigure/Trapezoid.dart';
import 'package:allcon/Util/Theme.dart';
import 'package:allcon/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class GoyangAram extends StatelessWidget {
  const GoyangAram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            Stage(),
            SizedBox(height: 30),
            Floor(),
            SizedBox(height: 30),
            Second(),
            SizedBox(height: 30),
            Third(),
          ],
        ),
      ),
    );
  }
}

class Stage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: 240,
      height: 30,
      child: Center(
        child: Text(
          'STAGE',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Floor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0.3,
                moveToY: 0,
                lineToX1: 1,
                lineToY1: 0,
                lineToX3: 0.2,
                color: Ground,
              ),
              child: Container(
                width: 80,
                height: 60,
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 160,
              height: 60,
              color: Ground,
            ),
            SizedBox(width: 8),
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0,
                moveToY: 0,
                lineToX1: 0.7,
                lineToY1: 0,
                lineToX2: 0.8,
                color: Ground,
              ),
              child: Container(
                width: 80,
                height: 60,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0.15,
                moveToY: 0,
                lineToX1: 1,
                lineToY1: 0,
                color: Ground,
              ),
              child: Container(
                width: 80,
                height: 100,
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 160,
              height: 100,
              color: Ground,
            ),
            SizedBox(width: 8),
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0,
                moveToY: 0,
                lineToX1: 0.85,
                lineToY1: 0,
                color: Ground,
              ),
              child: Container(
                width: 80,
                height: 100,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0,
                moveToY: 0,
                lineToX1: 1,
                lineToY1: 0,
                lineToX3: 0.3,
                color: Ground,
              ),
              child: Container(
                width: 80,
                height: 40,
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 160,
              height: 40,
              color: Ground,
            ),
            SizedBox(width: 8),
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0,
                moveToY: 0,
                lineToX1: 1,
                lineToY1: 0,
                lineToX2: 0.7,
                color: Ground,
              ),
              child: Container(
                width: 80,
                height: 40,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0.5,
                moveToY: 0,
                lineToX1: 1,
                lineToY1: 0,
                lineToX3: 0.2,
                color: Ground,
              ),
              child: Container(
                width: 120,
                height: 50,
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 160,
              height: 50,
              color: Ground,
            ),
            SizedBox(width: 8),
            CustomPaint(
              painter: TrapezoidPainter(
                moveToX: 0,
                moveToY: 0,
                lineToX1: 0.5,
                lineToY1: 0,
                lineToX2: 0.8,
                color: Ground,
              ),
              child: Container(
                width: 120,
                height: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPaint(
          painter: TrapezoidPainter(
            moveToX: 0.3,
            moveToY: 0,
            lineToX1: 1,
            lineToY1: 0,
            lineToX3: 0.2,
            color: oneFloor,
          ),
          child: Container(
            width: 160,
            height: 50,
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 160,
          height: 50,
          color: oneFloor,
        ),
        SizedBox(width: 8),
        CustomPaint(
          painter: TrapezoidPainter(
            moveToX: 0,
            moveToY: 0,
            lineToX1: 0.7,
            lineToY1: 0,
            lineToX2: 0.8,
            color: oneFloor,
          ),
          child: Container(
            width: 160,
            height: 50,
          ),
        ),
      ],
    );
  }
}

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 130,
          height: 50,
          color: secondFloor,
        ),
        SizedBox(width: 8),
        Container(
          width: 160,
          height: 50,
          color: secondFloor,
        ),
        SizedBox(width: 8),
        Container(
          width: 130,
          height: 50,
          color: secondFloor,
        ),
      ],
    );
  }
}
