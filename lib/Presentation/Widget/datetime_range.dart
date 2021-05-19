import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';

import 'header_widget.dart';

class DateRangePickerWidget extends StatefulWidget {
  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'Từ ngày';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Đến ngày';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.end);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: HeaderWidget(
          title: 'Chọn khoảng thời gian',
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Constants.mainColor),
                    ),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Text(getFrom()),
                        SizedBox(width: 30),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                    onPressed: () => pickDateRange(context),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                color: Constants.mainColor,
                size: 40,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Constants.mainColor,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(getUntil()),
                        SizedBox(width: 30),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                    onPressed: () => pickDateRange(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }
}
