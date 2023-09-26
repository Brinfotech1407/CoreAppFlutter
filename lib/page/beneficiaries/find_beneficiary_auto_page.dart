import 'package:mspmis/helpers/DatabaseHelper.dart';
import 'package:mspmis/model/beneficiary_model.dart';
import 'package:mspmis/page/beneficiaries/beneficiaries_page.dart';
import 'package:flutter/material.dart';
import 'package:mspmis/utils/item_beneficiaries_widget.dart';

import 'package:mspmis/contanst/contanst.dart';

class FindBeneficiaryAutoCompletePage extends StatefulWidget {
  FindBeneficiaryAutoCompletePage({Key key}) : super(key: key);

  @override
  _FindBeneficiaryAutoCompletePageState createState() =>
      _FindBeneficiaryAutoCompletePageState();
}

class _FindBeneficiaryAutoCompletePageState
    extends State<FindBeneficiaryAutoCompletePage> {
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
        title: Text("Find Beneficiary"),
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
                  delegate: BeneficiarySearch(),
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

class BeneficiarySearch extends SearchDelegate<BeneficiaryModel> {
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

  BeneficiaryModel selectedResult;
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: ItemBeneficiaryWidget(
          beneficiary: selectedResult,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BeneficiariesPage(beneficiary: selectedResult),
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
          : DatabaseHelper.instance.fetchBeneficairyByName(query),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your full name'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    // we will display the data returned from our future here
                    title: ItemBeneficiaryWidget(
                      beneficiary: snapshot.data[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BeneficiariesPage(
                                beneficiary: snapshot.data[index]),
                          ),
                        );
                      },
                      onDelete: () {
                        //notifier.removeAt(index);
                      },
                    ),
                    onTap: () {
                      BeneficiariesPage(
                          beneficiary:
                              BeneficiaryModel.fromMap(snapshot.data[index]));
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : CircularProgressIndicator(),
    );
  }
}
