import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapp/features/presentation/constants/colorconstants.dart';

import '../../../viewmodel/appviewmodel.dart';


class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return TextField(
        style:  TextStyle(color: primaryclr4),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          viewModel.addToQueryList(value);
          viewModel.queryval = value;
         
        },
        controller: _searchcontroller,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
              onPressed: () {
                viewModel.queryval = '';
                _searchcontroller.clear();
                viewModel.addToQueryList('');
                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: const Icon(
                Icons.clear,
                size: 20,
              )),
          suffixIconColor: primaryclr4,
          fillColor: primaryclr4,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle:  TextStyle(color: primaryclr4),
          labelText: "Search",
          prefixIcon:  Icon(
            Icons.search,
            color: primaryclr4,
            size: 20,
          ),
        ),
      );
    });
  }
}
