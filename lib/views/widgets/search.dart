import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/appviewmodel.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return TextField(
        style: TextStyle(color: Colors.white),
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
              icon: Icon(
                Icons.clear,
                size: 20,
              )),
          suffixIconColor: Colors.white,
          fillColor: Colors.white,
          floatingLabelBehavior:FloatingLabelBehavior.never,
          labelStyle: TextStyle(color: Colors.white),
          labelText: "Search",
          /* hintStyle: TextStyle(color: Colors.white),
          hintText: "Search", */
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
            size: 20,
          ),
          /* border: OutlineInputBorder(
          
            borderRadius: BorderRadius.all(Radius.circular(25.0))) */
        ),
      );
    });
  }
}
