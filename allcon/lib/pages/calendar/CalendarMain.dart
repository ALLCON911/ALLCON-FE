import 'dart:convert';
import 'package:allcon/pages/calendar/SelectConcertList.dart';
import 'package:flutter/material.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/concertService.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'CalendarDate.dart';
import './controller/selecetedDay_controller.dart';
import 'package:get/get.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final SelectedDayController selectedDayController =
      Get.put(SelectedDayController());

  @override
  void initState() {
    super.initState();
    fetchPerformancesByDate(DateTime.now());
  }

  Future<void> fetchPerformancesByDate(DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    List<Performance> performances =
        await ConcertService.getPerformanceByDate(formattedDate);
    selectedDayController.setPerformances(performances);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "달력",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CalendarDate(),
            const SizedBox(height: 20),
            SelectConcertList(),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
    );
  }
}
