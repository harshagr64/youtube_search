import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:you_search/src/bloc/search_bloc/youtube_search_bloc.dart';
import 'package:you_search/src/data/data_model.dart';
import 'package:you_search/src/ui/details/detail_page.dart';
import 'package:you_search/src/ui/widgets/centered_message.dart';
import 'package:you_search/src/ui/widgets/search_bar.dart';
// import 'package:you_search/src/bloc/youtube_search_event.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchBloc = kiwi.KiwiContainer().resolve<YoutubeSearchBloc>();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: _buildScaffold(),
    );
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
      ),
      body: BlocBuilder<YoutubeSearchBloc, YoutubeSearchState>(
        // bloc: _searchBloc,
        builder: (context, YoutubeSearchState state) {
          if (state is YoutubeSearchInitial) {
            return CenteredMesaage(
              message: 'Start Searching',
              iconData: Icons.ondemand_video,
            );
          } else if (state is YoutubeSearchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is YoutubeSearchSuccess) {
            // print('sucess');
            return _buildResultList(state);
          } else if (state is YoutubeSearchFailure) {
            return CenteredMesaage(
              message: '${state.error}',
              iconData: Icons.error_outline,
            );
          }
          return Text('hello');
        },
      ),
    );
  }

  Widget _buildResultList(YoutubeSearchSuccess state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _calculatListItemCount(state),
        itemBuilder: (context, index) {
          // print('true');
          return index >= state.searchResult.length
              ? _loadingItems()
              : _buildVideoListItemCard(
                  state.searchResult[index].snippet,
                  state.searchResult[index].id,
                );
        },
      ),
    );
  }

  int _calculatListItemCount(YoutubeSearchSuccess state) {
    // print('item count');
    print('${state.searchResult.length}');
    if (state.hasReachedEndofResults) {
      // print('hers1');
      return state.searchResult.length;
    } else {
      // print('hers');
      return state.searchResult.length + 1;
    }
  }

  Widget _loadingItems() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0)
      _searchBloc.add(FetchNextSerachData());
    return false;
  }

  Widget _buildVideoListItemCard(Snippet searchResult, Id id) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return DetailPage(videoId: id.videoId);
        }));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  searchResult.thumbnails.high.url,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${searchResult.title}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${searchResult.description}',
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
