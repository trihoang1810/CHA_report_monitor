import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';

import 'header_widget.dart';

class DateRangePickerWidget extends StatefulWidget {
  DateTimeRange dateRange;

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  String getFrom() {
    if (widget.dateRange == null) {
      return DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(Duration(hours: 24 * 3)));
    } else {
      return DateFormat('yyyy-MM-dd').format(widget.dateRange.start);
    }
  }

  String getUntil() {
    if (widget.dateRange == null) {
      return DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else {
      return DateFormat('yyyy-MM-dd').format(widget.dateRange.end);
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(getFrom()),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(getUntil()),
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
      start: DateTime.now().subtract(Duration(hours: 24 * 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: widget.dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => widget.dateRange = newDateRange);
  }
}
