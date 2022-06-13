import 'package:flutter/material.dart';
import 'package:phonon_github/api/api_service.dart';
import 'package:phonon_github/api/api_url.dart';
import 'package:phonon_github/helpers/utilities.dart';
import 'package:phonon_github/model/repository.dart';
import 'package:phonon_github/widget/app_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Repository> _repositories = [];
  bool _startLoading = false;

  @override
  void initState() {
    super.initState();

    _getAllRepositories("");
  }

//MARK: make netork call
  void _getAllRepositories(String searchText) {
    setState(() {
      _startLoading = true;
    });
    var url = ApiUrl().getRepositoryUrl(searchText);
    ApiService().getData(url).then((value) {
      _repositories.clear();
      var items = value["items"];
      for (var item in items) {
        var repo = Repository.fromJson(item);
        _repositories.add(repo);
      }
      setState(() {});
    }).whenComplete(() {
      setState(() {
        _startLoading = false;
      });
    }).onError((error, stackTrace) {});
  }

//MARK: search for the respository by name
  void searchList(String text) {
    _getAllRepositories(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.primaryAppBar(),
      body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: TextField(
                    onChanged: (value) {
                      searchList(value.toLowerCase());
                    },
                    decoration: const InputDecoration(
                        labelText: 'Search by username',
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
                _startLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.black,
                          );
                        },
                        itemCount: _repositories.length,
                        itemBuilder: (context, index) {
                          return _singleRowItem(_repositories[index]);
                        })
              ])),
    );
  }

  //MARK: build the repository widget
  Widget _singleRowItem(Repository repository) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: ListTile(
        leading: ClipOval(
          child: Image.network(repository.avatar, width: 50, height: 50),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(repository.login),
        ),
        subtitle: Row(
          children: [
            Chip(
              padding: const EdgeInsets.all(4),
              backgroundColor: Colors.blue,
              label: Text(Utilities.pluralise(repository.score),
                  style: const TextStyle(color: Colors.white)),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
