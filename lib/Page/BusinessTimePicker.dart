import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RestaurantModel {
  RestaurantModel.empty();

  RestaurantModel(
      {this.id,
      this.googleID,
      this.name,
      this.link,
      this.address,
      this.lat,
      this.lng,
      this.geohash,
      this.phoneNumber,
      this.photoUrl,
      this.creatorID,
      this.ownerID,
      this.updateUserID,
      this.isOpen,
      this.postCount,
      this.rating,
      this.ratingTotal,
      this.reviewTotal,
      this.averageCost,
      this.googleUrl,
      this.distance,
      this.syncDatabase,
      this.orderMealCount,
      this.foodItemCount,
      this.categoryList,
      this.photoUrlList,
      this.businessTime});

  void clone(RestaurantModel srcModel) {
    this.id = srcModel.id;
    this.googleID = srcModel.googleID;
    this.name = srcModel.name;
    this.link = srcModel.link;
    this.address = srcModel.address;
    this.lat = srcModel.lat;
    this.lng = srcModel.lng;
    this.geohash = srcModel.geohash;
    this.phoneNumber = srcModel.phoneNumber;
    this.photoUrl = srcModel.photoUrl;
    this.creatorID = srcModel.creatorID;
    this.ownerID = srcModel.ownerID;
    this.updateUserID = srcModel.updateUserID;
    this.isOpen = srcModel.isOpen;

    this.postCount = srcModel.postCount;

    this.rating = srcModel.rating;
    this.ratingTotal = srcModel.ratingTotal;
    this.reviewTotal = srcModel.reviewTotal;
    this.averageCost = srcModel.averageCost;
    this.googleUrl = srcModel.googleUrl;
    this.distance = srcModel.distance;
    this.syncDatabase = srcModel.syncDatabase;
    this.orderMealCount = srcModel.orderMealCount;
    this.foodItemCount = srcModel.foodItemCount;

    this.categoryList = srcModel.categoryList;
    this.photoUrlList = srcModel.photoUrlList;
    this.businessTime = srcModel.businessTime;
  }

  String? id;
  String? googleID;
  String? name;
  String? link;
  String? address;
  String? lat;
  String? lng;
  String? geohash;
  String? phoneNumber;
  String? photoUrl;
  String? creatorID;
  String? ownerID;
  String? updateUserID;
  bool? isOpen;

  int? postCount;

  double? rating;
  int? ratingTotal;
  int? reviewTotal;
  double? averageCost;
  String? googleUrl;
  double? distance;
  bool? syncDatabase;
  int? orderMealCount;
  int? foodItemCount;

  List<String>? categoryList;
  List<String>? photoUrlList;
  List<List<List<DateTime>>>? businessTime = List.generate(7, (index) => []);

// [7][n][2] --> [7 days][n duration][start & end time]
  List<BusinessHourModel> businessHourList = [];
}

class TimeDurationModel {
  TimeDurationModel({this.startTime, this.endTime});

  TimeOfDay? startTime;
  TimeOfDay? endTime;
}

class BusinessHourModel {
  BusinessHourModel.empty();

  BusinessHourModel(
      {this.day,
      this.date,
      this.startTime,
      this.endTime,
      this.is24Hour: false,
      this.isClosed: true});

  void clone(BusinessHourModel srcModel) {
    this.day = srcModel.day;
    this.date = srcModel.date;
    this.startTime = srcModel.startTime;
    this.endTime = srcModel.endTime;
    this.timeDurationList = srcModel.timeDurationList;
    this.is24Hour = srcModel.is24Hour;
    this.isClosed = srcModel.isClosed;
  }

  int? day;
  DateTime? date;
  TimeOfDay? startTime; // for user select function
  TimeOfDay? endTime; // for user select function
  List<TimeDurationModel> timeDurationList = [];
  bool is24Hour = false;
  bool isClosed = false;
}

DateTime timOfDayToDateTime(TimeOfDay time) {
  return DateTime(2000, 1, 1, time.hour, time.minute);
}

String timOfDayToTimeString(TimeOfDay? time) {
  if (time == null) return "";
  String hour = time.hour.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  return hour + ":" + minute;
}

String dateTimeToTimeString(DateTime dateTime) {
  return dateTime.hour.toString().padLeft(2, '0') +
      ":" +
      dateTime.minute.toString().padLeft(2, '0');
}

String dateTimeToDateString(DateTime dateTime){
  return "$dateTime".split(' ')[0];
}

class SelectRestaurantBusinessTimePage extends StatefulWidget {
  SelectRestaurantBusinessTimePage(this.mode);

  final BUSINESS_TIME_TYPE mode; // 0: choose by day, 1: choose by date

  @override
  _SelectRestaurantBusinessTimePageState createState() =>
      _SelectRestaurantBusinessTimePageState();
}

class _SelectRestaurantBusinessTimePageState
    extends State<SelectRestaurantBusinessTimePage> {
  static const int DAYS_A_WEEK = 7;

  late RestaurantModel _restaurantModel;
  late DateTime? dateTime;

//  DatabaseService databaseService = AWSDatabaseService();

  // global variable for choosing checkbox in bottom sheet
  bool _is24Hour = false;
  bool _isClosed = false;

  List<bool> _daySelectList = List.filled(DAYS_A_WEEK,
      false); // to determine the choice chip day widget is selected or not
  List<DateTime> _dateSelectList = [];


  bool isInitDayNameList = false;
  late List<String> dayNameList;
  late List<String> dayNameAbbrevList;

//  List<ExpandableDayItem> _expandableDayList = generateItems(DAYS_A_WEEK);

  @override
  void initState() {
    _restaurantModel = RestaurantModel.empty();
    super.initState();
  }

  void initDayNameList(BuildContext context) {
    dayNameList = <String>[
      "禮拜一",
      "禮拜二",
      "禮拜三",
      "禮拜四",
      "禮拜五",
      "禮拜六",
      "禮拜日",
//      AppLocalizations.of(context)!.monday,
//      AppLocalizations.of(context)!.tuesday,
//      AppLocalizations.of(context)!.wednesday,
//      AppLocalizations.of(context)!.thursday,
//      AppLocalizations.of(context)!.friday,
//      AppLocalizations.of(context)!.saturday,
//      AppLocalizations.of(context)!.sunday,
    ];
    dayNameAbbrevList = <String>[
      "一",
      "二",
      "三",
      "四",
      "五",
      "六",
      "日",
//      AppLocalizations.of(context)!.monday_abbrev,
//      AppLocalizations.of(context)!.tuesday_abbrev,
//      AppLocalizations.of(context)!.wednesday_abbrev,
//      AppLocalizations.of(context)!.thursday_abbrev,
//      AppLocalizations.of(context)!.friday_abbrev,
//      AppLocalizations.of(context)!.saturday_abbrev,
//      AppLocalizations.of(context)!.sunday_abbrev,
    ];
  }

  Widget timeDurationInfo(String text, Function() deleteFunc,
      {bool noData: false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(fontSize: 15)),
          SizedBox(
            width: 10,
          ),
          Visibility(
            visible: !noData,
            child: IconButton(
              onPressed: deleteFunc,
              icon: Icon(Icons.delete_outline),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _businessTimeWidgetList() {
    List<Widget> widgetList = [];
//    for (int idx = 6; idx < DAYS_A_WEEK + 6; idx++) {
    // loop through a week
    late List titleList;
    if (widget.mode == BUSINESS_TIME_TYPE.DAY)
      titleList = dayNameList;
    else if (widget.mode == BUSINESS_TIME_TYPE.DATE) titleList = _dateSelectList;
    for (int idx = 0; idx < titleList.length; idx++) {
//      int dayIdx = idx;
      List<Widget> durationWidgetList = [];

      late int businessHourIndex;
      late String textTitle;
      if (widget.mode == BUSINESS_TIME_TYPE.DAY) {
        businessHourIndex = _restaurantModel.businessHourList
            .indexWhere((businessHour) => businessHour.day == idx);
        textTitle = dayNameList[idx];
      }
      else if (widget.mode == BUSINESS_TIME_TYPE.DATE) {
        businessHourIndex = _restaurantModel.businessHourList
            .indexWhere((businessHour) =>
        businessHour.date == _dateSelectList[idx]);
        textTitle = dateTimeToDateString(_dateSelectList[idx]);
      }

      if (businessHourIndex >= 0) {
        // if there exist any data of this day
        // if is24Hour or isClosed is true, then these two property should be the first priority
        if (_restaurantModel.businessHourList[businessHourIndex].is24Hour ||
            _restaurantModel.businessHourList[businessHourIndex].isClosed) {
          String text = "";
          if (_restaurantModel.businessHourList[businessHourIndex].is24Hour)
            text = "24小時營業";
          else if (_restaurantModel
              .businessHourList[businessHourIndex].isClosed) text = "不營業";
          Function() deleteFunc = () {
            setState(() {
              // remove result when press delete button
              _restaurantModel.businessHourList.removeAt(businessHourIndex);
            });
          };
          durationWidgetList.add(timeDurationInfo(text, deleteFunc));
        } else {
          // add time duration to UI widget
          for (TimeDurationModel timeDuration in _restaurantModel
              .businessHourList[businessHourIndex].timeDurationList) {
            // loop through a day
            String text = timOfDayToTimeString(timeDuration.startTime) +
                " ~ " +
                timOfDayToTimeString(timeDuration.endTime);

            Function() deleteFunc = () {
              setState(() {
                // remove result when press delete button
                _restaurantModel
                    .businessHourList[businessHourIndex].timeDurationList
                    .remove(timeDuration);
                if (_restaurantModel.businessHourList[businessHourIndex]
                        .timeDurationList.length ==
                    0) {
                  // remove empty businessHour item
                  _restaurantModel.businessHourList.removeAt(businessHourIndex);
                }
              });
            };
            durationWidgetList.add(timeDurationInfo(text, deleteFunc));
          }
        }
      }

      if (durationWidgetList.length == 0) {
        // if no data
        durationWidgetList.add(timeDurationInfo("無資料", () {}, noData: true));
      }



      widgetList.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textTitle,
              style: TextStyle(fontSize: 15),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: durationWidgetList,
            ),
          ],
        ),
      ));
    }
    return Column(
      children: widgetList,
    );
  }

//  Widget _buildListPanel() {
//    return ExpansionPanelList(
//        expansionCallback: (int index, bool isExpanded) {
//          setState(() {
//            _expandableDayList[index].isExpanded = !isExpanded;
//          });
//        },
//        children: [
//          for (var dayIndex = 0; dayIndex < DAYS_A_WEEK; dayIndex++)
//            ExpansionPanel(
//              headerBuilder: (BuildContext context, bool isExpanded) {
//                return ListTile(title: Text(DAY_NAME[dayIndex]));
//              },
//              body: Column(
//                children: [
//                  // show business hour result according to dayIndex
//                  for (var result in _restaurantModel.businessTime![dayIndex])
//                    ListTile(
//                      title:
//                          Text(dateTimeDurationToTimeString(context, result)),
//                      trailing: Icon(Icons.delete),
//                      onTap: () {
//                        setState(() {
//                          // remove result when press delete button
//                          _restaurantModel.businessTime![dayIndex]
//                              .remove(result);
//                        });
//                      },
//                    )
//                ],
//              ),
//              isExpanded: _expandableDayList[dayIndex].isExpanded,
//            )
//        ]);
//  }

  _dayButton(
      StateSetter setBottomState, String title, int index, Function func) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: ChoiceChip(
            label: Text(title, textAlign: TextAlign.center),
            labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
            selected: _daySelectList[index],
            backgroundColor: Colors.grey[300],
            selectedColor: Colors.yellow,
            onSelected: (bool isSelected) {
              setBottomState(() {
                _daySelectList[index] = isSelected;
              });
            },
          )),
    );
  }

  void showBottomMenu({required BuildContext context}) {
    // initialize global variable

//    List<List<TimeOfDay?>> timeDurationList = [
//      [null, null]
//    ];
    List<BusinessHourModel> businessHourList = [BusinessHourModel()];
    _is24Hour = false;
    _isClosed = false;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10))),
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setBottomState) {
              return bottomMenuWidget(setBottomState, businessHourList);
            }));
  }

  Widget timeDurationSelectRow(StateSetter setBottomState,
      List<BusinessHourModel> businessHourList, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 5),
            child: OutlinedButton(
              child: Text(
                businessHourList[index].startTime?.format(context) ?? "營業開始時間",
                style: TextStyle(
                    color: businessHourList[index].startTime != null
                        ? Colors.black
                        : Colors.grey),
              ),
              onPressed: () {
                pickTime(context).then((value) {
                  if (value == null) return;
                  // if user choose a time
                  setBottomState(() {
                    businessHourList[index].startTime = value;
                  });
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 5),
            child: OutlinedButton(
              child: Text(
                businessHourList[index].endTime?.format(context) ?? "營業結束時間",
                style: TextStyle(
                    color: businessHourList[index].endTime != null
                        ? Colors.black
                        : Colors.grey),
              ),
              onPressed: () {
                pickTime(context).then((value) {
                  if (value == null) return;
                  // if user choose a time
                  setBottomState(() {
                    businessHourList[index].endTime = value;
                  });
                });
              },
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              setBottomState(() {
                businessHourList.removeAt(index);
              });
            },
            icon: Icon(Icons.clear))
      ],
    );
  }

  // generate structured business hour list
  List<BusinessHourModel> genUserSelectBusinessHour(
      List<bool> daySelectList, List<BusinessHourModel> businessHourList) {
    List<BusinessHourModel> _selectBusinessHourList = [];
    List<BusinessHourModel> _businessHourList = [];
    if (_isClosed || _is24Hour) {
      _selectBusinessHourList.add(BusinessHourModel(
        is24Hour: _is24Hour,
        isClosed: _isClosed,
      ));
    } else {
      for (int i = 0; i < businessHourList.length; i++) {
        // TODO: process time duration
        BusinessHourModel businessHourModel = BusinessHourModel(
          startTime: businessHourList[i].startTime,
          endTime: businessHourList[i].endTime,
          is24Hour: _is24Hour,
          isClosed: _isClosed,
        );
        _selectBusinessHourList.add(businessHourModel);
      }
    }

    switch (widget.mode) {
      case BUSINESS_TIME_TYPE.DAY:
        for (int day = 0; day < DAYS_A_WEEK; day++) {
          if (!daySelectList[day]) continue;

          BusinessHourModel businessHourModel = BusinessHourModel(day: day);
          for (int i = 0; i < _selectBusinessHourList.length; i++) {
            businessHourModel.isClosed = _selectBusinessHourList[i].isClosed;
            businessHourModel.is24Hour = _selectBusinessHourList[i].is24Hour;
            businessHourModel.timeDurationList.add(TimeDurationModel(
                startTime: _selectBusinessHourList[i].startTime,
                endTime: _selectBusinessHourList[i].endTime));
          }
          _businessHourList.add(businessHourModel);
        }
        break;
      case BUSINESS_TIME_TYPE.DATE:
        if (!_dateSelectList.contains(selectedDate)) {
          _dateSelectList.add(selectedDate);
        }
        BusinessHourModel businessHourModel =
            BusinessHourModel(date: selectedDate);
        for (int i = 0; i < _selectBusinessHourList.length; i++) {
          businessHourModel.isClosed = _selectBusinessHourList[i].isClosed;
          businessHourModel.is24Hour = _selectBusinessHourList[i].is24Hour;
          businessHourModel.timeDurationList.add(TimeDurationModel(
              startTime: _selectBusinessHourList[i].startTime,
              endTime: _selectBusinessHourList[i].endTime));
//          print(
//              "${businessHourModel.date}  ${_selectBusinessHourList[i].startTime}, ${_selectBusinessHourList[i].endTime}, ${_selectBusinessHourList[i].is24Hour}, ${_selectBusinessHourList[i].isClosed}");
//          print(_dateList);
        }
        _businessHourList.add(businessHourModel);
        break;
      default:
        break;
    }

//    if (widget.mode == BUSINESS_TIME_TYPE.DATE) {
//      if (!_dateList.contains(selectedDate)) {
//        _dateList.add(selectedDate);
//      }
//      BusinessHourModel businessHourModel =
//          BusinessHourModel(date: selectedDate);
//      for (int i = 0; i < _selectBusinessHourList.length; i++) {
//        businessHourModel.isClosed = _selectBusinessHourList[i].isClosed;
//        businessHourModel.is24Hour = _selectBusinessHourList[i].is24Hour;
//        businessHourModel.timeDurationList.add(TimeDurationModel(
//            startTime: _selectBusinessHourList[i].startTime,
//            endTime: _selectBusinessHourList[i].endTime));
//        print(
//            "${businessHourModel.date}  ${_selectBusinessHourList[i].startTime}, ${_selectBusinessHourList[i].endTime}, ${_selectBusinessHourList[i].is24Hour}, ${_selectBusinessHourList[i].isClosed}");
//        print(_dateList);
//      }
//      _businessHourList.add(businessHourModel);
//    }

//    for (int day = 0; day < DAYS_A_WEEK; day++) {
//      if (!daySelectList[day]) continue;
//
//      BusinessHourModel businessHourModel = BusinessHourModel(day: day);
//      for (int i = 0; i < _selectBusinessHourList.length; i++) {
//        businessHourModel.isClosed = _selectBusinessHourList[i].isClosed;
//        businessHourModel.is24Hour = _selectBusinessHourList[i].is24Hour;
//        businessHourModel.timeDurationList.add(TimeDurationModel(
//            startTime: _selectBusinessHourList[i].startTime,
//            endTime: _selectBusinessHourList[i].endTime));
////        print(
////            "$i  ${_selectBusinessHourList[i].startTime}, ${_selectBusinessHourList[i].endTime}");
//      }
//      _businessHourList.add(businessHourModel);
//    }
//    _businessHourUIList
//    print(_businessHourList.length);
//    var data = _businessHourList.where((element) => element.day == 1);
//    print(data.length);
//    data.forEach((element) {
//      print(
//          "${element.day}, ${element.timeDurationList[0]?.startTime}, ${element.timeDurationList[0]?.endTime}, ${element.isClosed}, ${element.is24Hour}");
//    });

    return _businessHourList;
  }

  Widget bottomMenuWidget(
      StateSetter setBottomState, List<BusinessHourModel> businessHourList) {
    Widget selectWidget = SizedBox.shrink();
    switch (widget.mode) {
      case BUSINESS_TIME_TYPE.DAY:
        selectWidget = selectDayWidget(setBottomState);
        break;
      case BUSINESS_TIME_TYPE.DATE:
        selectWidget = selectDateWidget(setBottomState);
        break;
      default:
        break;
    }
    return SingleChildScrollView(
      child: Wrap(
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            selectWidget,
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Checkbox(
                      value: _is24Hour,
                      onChanged: (value) {
                        // we can only choose either 24Hour or closed
                        setBottomState(() {
                          _isClosed = false;
                          _is24Hour = !_is24Hour;
                        });
                      },
                    ),
                    title: Text(
                      "24小時營業",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Checkbox(
                      value: _isClosed,
                      onChanged: (value) {
                        setBottomState(() {
                          // we can only choose either 24Hour or closed
                          _is24Hour = false;
                          _isClosed = !_isClosed;
                        });
                      },
                    ),
                    title: Text(
                      "不營業",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: !(_isClosed || _is24Hour),
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: businessHourList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: timeDurationSelectRow(
                              setBottomState, businessHourList, index),
                        );
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: OutlinedButton(
                      child: Text("新增營業時間"),
                      onPressed: () {
                        setBottomState(() {
                          businessHourList.add(BusinessHourModel());
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  child: Text("取消"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                OutlinedButton(
                  child: Text("確認"),
                  onPressed: () {
                    print("Confirm");
                    setState(() {
                      List<BusinessHourModel> newBusinessHourList =
                          genUserSelectBusinessHour(
                              _daySelectList, businessHourList);
                      _restaurantModel.businessHourList = mergeBusinessHourList(
                          _restaurantModel.businessHourList,
                          newBusinessHourList,
                          widget.mode);

                      Navigator.pop(context);
                    });
//                        Navigator.pop(context);
//                    if (false) {
//                      showToast("請選擇時間");
//                    } else {
//                      setState(() {
//                        for (var index = 0; index < DAYS_A_WEEK; index++) {
//                          List<DateTime> timeDuration; // [start time, end time]
//                          if (_is24Hour) {
//                            // timeDuration = [00:00, 23:59]
//                            timeDuration = [
//                              timOfDayToDateTime(TimeOfDay(hour: 0, minute: 0)),
//                              timOfDayToDateTime(
//                                  TimeOfDay(hour: 23, minute: 59))
//                            ];
//                          } else if (_isClosed) {
//                            // timeDuration = [00:00, 00:00]
//                            timeDuration = [
//                              timOfDayToDateTime(TimeOfDay(hour: 0, minute: 0)),
//                              timOfDayToDateTime(TimeOfDay(hour: 0, minute: 0))
//                            ];
//                          } else {
//                            // timeDuration = [_startTime, _endTime]
////                            timeDuration = [
////                              timOfDayToDateTime(_startTime!),
////                              timOfDayToDateTime(_endTime!)
////                            ];
//                          }
//                          // to check which day is selected now
//                          if (_daySelectList[index]) {
//                            // assign timeDuration to every day user select
////                            _restaurantModel.businessTime![index]
////                                .add(timeDuration);
//                          }
//                        }
//                        Navigator.pop(context);
//                      });
//                    }
                  },
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  selectDayWidget(StateSetter setBottomState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _dayButton(setBottomState, dayNameAbbrevList[0], 0, () {}),
          _dayButton(setBottomState, dayNameAbbrevList[1], 1, () {}),
          _dayButton(setBottomState, dayNameAbbrevList[2], 2, () {}),
          _dayButton(setBottomState, dayNameAbbrevList[3], 3, () {}),
          _dayButton(setBottomState, dayNameAbbrevList[4], 4, () {}),
          _dayButton(setBottomState, dayNameAbbrevList[5], 5, () {}),
          _dayButton(setBottomState, dayNameAbbrevList[6], 6, () {}),
        ],
      ),
    );
  }

  selectDateWidget(StateSetter setBottomState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.date_range),
          SizedBox(
            width: 5,
          ),
          OutlinedButton(
            child: Text(dateTimeToDateString(selectedDate)),
            onPressed: () {
              _openDatePicker(context, setBottomState);
              setBottomState(() {});
            },
          ),
        ],
      ),
    );
  }

  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime(2022, 05, 5), end: DateTime(2022, 08, 1));
  DateTime selectedDate = DateTime.now();
  final firstDate = DateTime(1911, 1);
  final lastDate = DateTime(2100, 12);

  _openDatePicker(BuildContext context, StateSetter setBottomState) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (date != null) {
      setBottomState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitDayNameList) {
      initDayNameList(context);
      isInitDayNameList = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Time"),
        actions: [
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                print(_restaurantModel.businessHourList.length);
//                showWaitingDialog(context, "新增資料中");
//                databaseService
//                    .addRestaurantBusinessHour(
//                    restaurantModel: _restaurantModel)
//                    .then((value) {
//                  Navigator.pop(context); // Pop showWaitingDialog
//                  Navigator.pop(context); // Pop selectBusinessTimePage
//                });
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // clear time data user filled in
          // keep the select-day data
//          _startTimeController.text = "";
//          _endTimeController.text = "";
//          _startTime = null;
//          _endTime = null;
          showBottomMenu(context: context);
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
//            SizedBox(
//              height: 30,
//            ),
//            selectDayWidget(),
//            SizedBox(
//              height: 30,
//            ),
            _businessTimeWidgetList(),
//            _buildListPanel(),
            SizedBox(
              height: 80,
            ),
//          OutlineButton(
//            child: Text("Date"),
//            onPressed: () => pickDate(context),
//          ),
//          OutlineButton(
//            child: Text("Time"),
//            onPressed: () => pickTime(context),
//          ),
//          OutlineButton(
//            child: Text("Show Date"),
//            onPressed: () {
//              print(dateTime.toString());
//              showToast(dateTime.toString());
//            },
//          ),
//          OutlineButton(
//            child: Text("Show Time"),
//            onPressed: () {
//              print(time.toString());
//              showToast(time.toString());
//            },
//          ),
          ],
        ),
      ),
    );
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(),
            child: child!,
          );
        });

    if (newTime == null) return null; // if user didn't pick a Time
    return newTime;
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        locale: Locale('zh', 'TW'),
        initialDate: dateTime ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(),
            child: child!,
          );
        });

    if (newDate == null) return;

    dateTime = newDate;
    return dateTime;
  }
}

class ExpandableDayItem {
  String title;
  bool isExpanded;

  ExpandableDayItem({required this.title, this.isExpanded = true});
}

List<ExpandableDayItem> generateItems(int length) {
  return List.generate(length, (index) {
    return ExpandableDayItem(title: "$index");
  });
}
