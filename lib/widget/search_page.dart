import 'package:flutter/material.dart';
import 'package:phonon_github/api/api_response.dart';
import 'package:phonon_github/api/repository_block.dart';
import 'package:phonon_github/helpers/utilities.dart';
import 'package:phonon_github/model/repository.dart';
import 'package:phonon_github/widget/app_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late RepositoryBloc _repositoryBloc;

  @override
  void initState() {
    super.initState();

    _repositoryBloc = RepositoryBloc("");
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
                      _repositoryBloc.fetchRepositories(value);
                    },
                    decoration: const InputDecoration(
                        labelText: 'Search by username',
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () => _repositoryBloc.fetchRepositories(""),
                  child: StreamBuilder<ApiResponse<List<Repository>>>(
                    stream: _repositoryBloc.githubRepoStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case Status.COMPLETED:
                            return _movieList(snapshot.data!.data);
                          case Status.ERROR:
                            return _errorView(snapshot.data!.message);
                        }
                      }
                      return Container();
                    },
                  ),
                )
              ]),
        ));
  }

  //MARK: present error message
  Widget _errorView(String message) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(message),
    );
  }

//MARK: show list of  repos
  Widget _movieList(List<Repository> repositories) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black,
          );
        },
        itemCount: repositories.length,
        itemBuilder: (context, index) {
          return _singleRowItem(repositories[index]);
        });
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

  @override
  void dispose() {
    _repositoryBloc.dispose();
    super.dispose();
  }
}
