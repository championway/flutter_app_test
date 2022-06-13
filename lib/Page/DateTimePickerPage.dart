import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerPage extends StatefulWidget {
  @override
  _DateTimePickerPageState createState() => _DateTimePickerPageState();
}

class _DateTimePickerPageState extends State<DateTimePickerPage> {
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime(2022, 05, 5), end: DateTime(2022, 08, 1));
  DateTime selectedDate = DateTime.now();
  final firstDate = DateTime(1911, 1);
  final lastDate = DateTime(2030, 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date/Time Picker"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "$selectedDate".split(' ')[0],
              style: TextStyle(fontSize: 24),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () => _openDatePicker(context),
                child: Text('Select date')),
            Divider(),
            CalendarDatePicker(initialDate: selectedDate, firstDate: firstDate, lastDate: lastDate, onDateChanged: (newDate){
              print("New date $newDate");
              setState(() {
                selectedDate = newDate;
              });
            }),
            Divider(),
            Container(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (newDate){
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );

    /*final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    return Scaffold(
      appBar: AppBar(title: Text("Date Time Picker")),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text(DateFormat('yyyy/MM/dd').format(start)),
                    onPressed: pickDateRange,
                  )),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    child: Text('${end.year}/${end.month}/${end.day}'),
                    onPressed: pickDateRange,
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );*/
  }

  _openDatePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: lastDate);
    print('Date $date');
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateTimeRange,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100));

    if (newDateRange == null) return; // pressed 'X'

    setState(() {
      dateTimeRange = newDateRange;
    });
  }
}
