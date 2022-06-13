import 'package:flutter/material.dart';
import 'package:flutter_app_test/Page/BusinessTimePicker.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future pushPage(BuildContext context, Widget widget) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}

void showToast(String msg) {
  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
}

// build structured business hour model list
// make user select business hour into a more friendly businessHour structure
// original:
//     - day: 1 / start time: XXX / end time: YYY
//     - day: 2 / start time: MMM / end time: NNN
//     - day: 2 / start time: AAA / end time: BBB
// new:
//     - day: 1 -> start time: XXX / end time: YYY
//     - day: 2 -> start time: MMM / end time: NNN
//              -> start time: AAA / end time: BBB

List<BusinessHourModel> buildBusinessHourDateList(
    List<BusinessHourModel> businessHourList) {
  List<BusinessHourModel> newBusinessHourList = [];

  businessHourList.forEach((businessHour) {
    int idx = newBusinessHourList
        .indexWhere((element) => element.date == businessHour.date);
    if (idx < 0) {
      // the list hasn't exist this day, so we need to add a new one
      BusinessHourModel newBusinessHourModel = BusinessHourModel(
        date: businessHour.date,
      );
      newBusinessHourList.add(newBusinessHourModel);
      idx = newBusinessHourList.length -
          1; // update index to the latest added one
    }

    // add information to corresponding index
    newBusinessHourList[idx].isClosed = businessHour.isClosed;
    newBusinessHourList[idx].is24Hour = businessHour.is24Hour;
    newBusinessHourList[idx].timeDurationList.add(TimeDurationModel(
        startTime: businessHour.startTime, endTime: businessHour.endTime));
  });
  return newBusinessHourList;
}

// merge two structured businessHourList
List<BusinessHourModel> mergeBusinessHourList(
    List<BusinessHourModel> businessHourList1,
    List<BusinessHourModel> businessHourList2, BUSINESS_TIME_TYPE mode) {
  List<BusinessHourModel> mergeBusinessHourList = businessHourList1;

  businessHourList2.forEach((businessHour2) {
    int idx = -1;
    if (mode == BUSINESS_TIME_TYPE.DAY){
      idx = mergeBusinessHourList
          .indexWhere((element) => element.day == businessHour2.day);
    }
    else if (mode == BUSINESS_TIME_TYPE.DATE){
      idx = mergeBusinessHourList
          .indexWhere((element) => element.date == businessHour2.date);
    }
    if (idx < 0) {
      print("NEW");
      // the list hasn't exist this day, so we need to add a new one
      BusinessHourModel newBusinessHourModel = BusinessHourModel(
        day: businessHour2.day,
        date: businessHour2.date,
      );
      mergeBusinessHourList.add(newBusinessHourModel);
      idx = mergeBusinessHourList.length -
          1; // update index to the latest added one
    }
    // add information to corresponding index
    mergeBusinessHourList[idx].isClosed = businessHour2.isClosed;
    mergeBusinessHourList[idx].is24Hour = businessHour2.is24Hour;
    // add directly
    mergeBusinessHourList[idx].timeDurationList +=
        businessHour2.timeDurationList;
  });

  for (int i = 0; i < mergeBusinessHourList.length; i++) {
    mergeBusinessHourList[i] =
        mergeSingleDayBusinessHour(mergeBusinessHourList[i]);
  }
  return mergeBusinessHourList;
}

// merge Business hour list in a single day, to prevent conflict time and logic
// input should be should be structured business hour model
BusinessHourModel mergeSingleDayBusinessHour(BusinessHourModel businessHour) {
  BusinessHourModel mergeBusinessHour = BusinessHourModel.empty();
  mergeBusinessHour.clone(businessHour);

  if (mergeBusinessHour.isClosed || mergeBusinessHour.is24Hour) {
    mergeBusinessHour.timeDurationList = [];
    return mergeBusinessHour;
  }

  // if no time duration, then return original data
  if (mergeBusinessHour.timeDurationList.length == 0) return mergeBusinessHour;

  List<TimeDurationModel> validTimeDurationList =
      []; // with non-null & valid duration data
  List<TimeDurationModel> mergeTimeDurationList =
      []; // with sorting & merging overlap duration data

  // remove null item & duration that end time < start time
  for (int i = 0; i < mergeBusinessHour.timeDurationList.length; i++) {
    // remove null item
    if (mergeBusinessHour.timeDurationList[i].startTime == null ||
        mergeBusinessHour.timeDurationList[i].endTime == null) continue;
    // remove duration that end time < start time
    if (mergeBusinessHour.timeDurationList[i].startTime!.hour * 60 +
            mergeBusinessHour.timeDurationList[i].startTime!.minute >=
        mergeBusinessHour.timeDurationList[i].endTime!.hour * 60 +
            mergeBusinessHour.timeDurationList[i].endTime!.minute) continue;

    validTimeDurationList.add(mergeBusinessHour.timeDurationList[i]);
  }

  // sort list by start time
  validTimeDurationList.sort((a, b) =>
      (a.startTime!.hour * 60 + a.startTime!.minute)
          .compareTo(b.startTime!.hour * 60 + b.startTime!.minute));

//  validTimeDurationList.forEach((timeDuration) {
//    print("${mergeBusinessHour.date} ${mergeBusinessHour.day} ${timeDuration.startTime}  ${timeDuration.endTime}");
//  });
//  print("Processing");

  // if no valid duration list, then return original data will empty time duration list
  if (validTimeDurationList.length == 0) {
    mergeBusinessHour.timeDurationList = [];
    return mergeBusinessHour;
  }

  // merge overlap duration
  mergeTimeDurationList.add(validTimeDurationList[0]);
  for (int i = 1; i < validTimeDurationList.length; i++) {
    // if current start time <= previous end time
    // current        : |----------|
    // cond.A previous:            |-----|
    // cond.B previous:      |---------|
    // cond.C previous:      |--|
    // cond.B to-be   : |--------------|
    if (validTimeDurationList[i].startTime!.hour * 60 +
            validTimeDurationList[i].startTime!.minute <=
        validTimeDurationList[i - 1].endTime!.hour * 60 +
            validTimeDurationList[i - 1].endTime!.minute) {
      mergeTimeDurationList.removeLast();

      TimeDurationModel newDuration = TimeDurationModel();
      newDuration.startTime = validTimeDurationList[i - 1].startTime;
      newDuration.endTime = validTimeDurationList[i].endTime; // cond. A & B

      // cond. C
      if (validTimeDurationList[i].endTime!.hour * 60 +
              validTimeDurationList[i].endTime!.minute <
          validTimeDurationList[i - 1].endTime!.hour * 60 +
              validTimeDurationList[i - 1].endTime!.minute) {
        newDuration.endTime = validTimeDurationList[i - 1].endTime;
      }
      mergeTimeDurationList.add(newDuration);
    } else {
      // if no overlap with previous duration
      mergeTimeDurationList.add(validTimeDurationList[i]);
    }
  }

//  mergeTimeDurationList.forEach((timeDuration) {
//    print("${mergeBusinessHour.date} ${mergeBusinessHour.day} ${timeDuration.startTime}  ${timeDuration.endTime}");
//  });

  mergeBusinessHour.timeDurationList = mergeTimeDurationList;

  return mergeBusinessHour;
}

enum BUSINESS_TIME_TYPE { DAY, DATE }