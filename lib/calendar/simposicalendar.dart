/*
*  calendareventlist.dart
*  Simposi App Designs V4.0
*  Created by Simposi Inc.
*  Copyright ©2018-2021 Simposi Inc. All rights reserved.
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simposi_app_v4/app_router.dart';
import 'package:simposi_app_v4/bloc/rsvp/rsvp_bloc.dart';
import 'package:simposi_app_v4/calendar/week_calendar/utils.dart';
import 'package:simposi_app_v4/eventdetails/cubit/event_edit_cubit.dart';
import 'package:simposi_app_v4/global/theme/appcolors.dart';
import 'package:simposi_app_v4/global/theme/elements/counterbubble.dart';
import 'package:simposi_app_v4/global/theme/elements/simposiappbar.dart';
import 'package:simposi_app_v4/global/widgets/progress.dart';
import 'package:simposi_app_v4/utils/date_utils.dart';

import 'bloc/calendar_bloc.dart';
import 'calendarwidgets/calendarcards.dart';
import 'week_calendar/week_calendar.dart';

class SimposiCalendar extends StatefulWidget {
  const SimposiCalendar({super.key});

  @override
  State createState() => _SimposiCalendarState();
}

class _SimposiCalendarState extends State<SimposiCalendar> {
  late final ItemScrollController _itemScrollController;
  late final ItemPositionsListener _itemPositionsListener;

  CalendarController? _calendarPageController;
  int _firstScrollItemIndex = 0;

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();
    _itemPositionsListener.itemPositions.addListener(() {
      final items = _itemPositionsListener.itemPositions.value.toList();
      items.sort((s1, s2) {
        return s1.index.compareTo(s2.index);
      });

      _firstScrollItemIndex = items.first.index;
      context.read<CalendarBloc>().add(ListScrolled(_firstScrollItemIndex));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimposiAppBar(
        simposiTitle: 'Socials',
        simposiSubTitle: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is CalendarLoaded) {
              return _CalendarHeader(
                focusedDay: state.weekStart,
                clearButtonVisible: false,
              );
            } else {
              return _CalendarHeader(
                focusedDay: DateTime.now(),
                clearButtonVisible: false,
              );
            }
          },
        ),
        simposiAction: Row(
          children: [
            TextButton(
              child: const Text(
                'TODO Refresh',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () => {
                context.read<RsvpBloc>().add(RefreshRequested(
                    DateTime.now().subtract(const Duration(days: 90)),
                    DateTime.now().add(const Duration(days: 90))))
              },
            ),
            TextButton(
              child: const Text(
                'Meet Now',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                context.read<EventEditCubit>().initCreate();
                AutoRouter.of(context).push(const CreateEvent1Route());
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      body: Column(
        children: [
          // Calendar Style & Settings
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: SimposiAppColors.simposiDarkBlue,
            child: BlocBuilder<CalendarBloc, CalendarState>(
              buildWhen: (s1, s2) {
                return s1 is CalendarLoading && s2 is CalendarLoaded;
              },
              builder: (context, state) {
                return WeekCalendar(
                  firstDay: DateTime.now().subtract(const Duration(days: 90)),
                  lastDay: DateTime.now().add(const Duration(days: 90)),
                  focusedDay: SimposiDateUtils.weekStart(
                      DateUtils.dateOnly(DateTime.now())),
                  onPageChanged: (fd) {
                    print("!cal ${fd.day}");
                    context.read<CalendarBloc>().add(WeekSelected(fd));
                  },
                  onCalendarCreated: (c) {
                    _calendarPageController = c;
                  },
                  todayBuilder: fosusedBuilder,
                  defaultBuilder: defaultBuilder,
                  eventChecker: (day) {
                    if (state is CalendarLoaded) {
                      final d = state.events
                          .map((e) => e.normalizedDate.toUtc())
                          .toList()
                          .contains(day.toUtc());
                      return d;
                    } else {
                      return false;
                    }
                  },
                );
              },
            ),
          ),

          // Upcoming Counter Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Text(
                  'Upcoming',
                  style: TextStyle(
                    color: Color(0xFFBBBBBB),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 10),
                BlocBuilder<RsvpBloc, RsvpState>(
                  builder: (context, state) {
                    return SimposiCounterBubble(
                      count: state is RsvpLoaded
                          ? state.accepted.toString()
                          : '0', // TODO: Set Variable for Counter which displays RSVPs where status = Accepted or Created by ELSE display 0
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8.0),
          BlocConsumer<CalendarBloc, CalendarState>(
            listenWhen: (state1, state2) {
              return state1 is CalendarLoaded && state2 is CalendarLoaded;
            },
            listener: (context, state) {
              if (state is CalendarLoaded && state.loadBy == LoadBy.CALENDAR) {
                if (state.scrollPos != _firstScrollItemIndex) {
                  _itemScrollController.scrollTo(
                      index: state.scrollPos,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic);
                }
              } else if (state is CalendarLoaded &&
                  state.loadBy == LoadBy.LIST) {
                if (state.difWeeks != 0) {
                  final cur = _calendarPageController?.getPage().toInt() ?? 0;
                  _calendarPageController?.animateToPage(cur + state.difWeeks,
                      callback: false);
                }
              }
            },
            buildWhen: (state1, state2) {
              if (state1 is CalendarLoaded && state2 is CalendarLoaded) {
                if (state1.events != state2.events) {
                  return true;
                } else {
                  return false;
                }
              }
              return true;
            },
            builder: (context, state) {
              if (state is CalendarLoading) {
                return Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        AppProgressIndicator(),
                      ],
                    ),
                  ),
                );
              } else if (state is CalendarLoaded) {
                return Expanded(
                  child: ScrollablePositionedList.builder(
                    itemCount: state.events.length,
                    itemBuilder: (context, index) {
                      return EventCard(eventModel: state.events[index]);
                    },
                    initialScrollIndex: state.scrollPos,
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                  ),
                );
              } else {
                return const Expanded(
                  child: Text("Error"),
                );
              }
            },
          )
        ],
      ),
    );
  }

  var fosusedBuilder = (context, d1, d2) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: SimposiAppColors.simposiFadedBlue,
          shape: BoxShape.rectangle,
        ),
        child: Text(d1.day.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            )),
      ),
    );
  };
  var defaultBuilder = (context, d1, d2) {
    return Center(
        child: Text(d1.day.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            )));
  };
}

// MONTH AND YEAR IN APP BAR
class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);
    return Row(
      children: [
        SizedBox(
          child: Text(
            headerText,
            style: const TextStyle(
              fontSize: 15,
              color: SimposiAppColors.simposiLightText,
            ),
          ),
        ),
      ],
    );
  }
}
