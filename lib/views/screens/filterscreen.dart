/* import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  DateTime? startDate, endDate;
  String? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: PopupMenuButton<String>(
                      icon: Icon(Icons.filter_alt_outlined),
                      initialValue: selectedMenu,
                      // Callback that sets the selected popup menu item.
                      onSelected: (SampleItem item) {
                        setState(() {
                          selectedMenu = item;
                        });
                        if (selectedMenu == SampleItem.Custom) {
                          selectDateRange();
                          viewModel.setDateFilter(startDate, endDate);
                        }

                        viewModel.setFilterSelection(selectedMenu.toString());
                        viewModel.addToFilteredList();
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<SampleItem>>[
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.Today,
                          child: Text('Today'),
                        ),
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.Tomorrow,
                          child: Text('Tomorrow'),
                        ),
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.Custom,
                          child: Text('Custom Date'),
                        ),
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.Clear,
                          child: Text('Clear Filter'),
                        ),
                      ],
                    ),
                  ),
  }
}
 */