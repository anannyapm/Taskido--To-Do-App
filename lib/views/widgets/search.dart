import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodel/appviewmodel.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return TextField(
        style: const TextStyle(color: Colors.white),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          viewModel.addToQueryList(value);
          viewModel.queryval = value;
          debugPrint(viewModel.queryResultList.toString());
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
          suffixIconColor: Colors.white,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: const TextStyle(color: Colors.white),
          labelText: "Search",
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
    });
  }
}
