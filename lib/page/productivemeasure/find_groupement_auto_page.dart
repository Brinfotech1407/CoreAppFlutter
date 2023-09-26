import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:mspmis/model/productive_measure_model.dart';
import 'package:mspmis/page/productivemeasure/groupements_page.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/utils/item_groupements_widget.dart';

import 'package:mspmis/contanst/contanst.dart';

class FindGroupementAutoCompletePage extends StatefulWidget {
  FindGroupementAutoCompletePage({Key key}) : super(key: key);

  @override
  _FindGroupementAutoCompletePageState createState() =>
      _FindGroupementAutoCompletePageState();
}

class _FindGroupementAutoCompletePageState
    extends State<FindGroupementAutoCompletePage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rechercher un groupement"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            width: double.infinity,
            height: 30,
            child: TextFormField(
              //focusNode: focusSearch,
              controller: _controller,
              onTap: () async {
                // should show search screen here
                showSearch(
                  context: context,
                  // we haven't created AddressSearch class
                  // this should be extending SearchDelegate
                  delegate: GroupementSearch(),
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color(0xFF969696), fontSize: 14),
                labelStyle: TextStyle(color: R.color.black, fontSize: 14),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF969696),
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(200)),
          )
        ],
      ),
    );
  }
}

class GroupementSearch extends SearchDelegate<GroupementModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  GroupementModel selectedResult;
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: ItemGroupementWidget(
          groupement: selectedResult,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GroupementsPage(groupement: selectedResult),
              ),
            );
          },
          onDelete: () {
            //notifier.removeAt(index);
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("Query : " + query);
    return FutureBuilder(
      // We will put the api call here
      future: query.isEmpty
          ? null
          : DatabaseHelper.instance.fetchGroupementByName(query),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Entrez le nom du groupe'),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, index) => ListTile(
          // we will display the data returned from our future here
          title: ItemGroupementWidget(
            groupement: snapshot.data[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupementsPage(
                      groupement: snapshot.data[index]),
                ),
              );
            },
            onDelete: () {
              //notifier.removeAt(index);
            },
          ),
          onTap: () {
            GroupementsPage(
                groupement:
                GroupementModel.fromMap(snapshot.data[index]));
          },
        ),
        itemCount: snapshot.data.length,
      )
          : CircularProgressIndicator(),
    );
  }
}
