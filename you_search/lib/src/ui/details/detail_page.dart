import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:you_search/src/bloc/detail_bloc/detail_bloc.dart';
import 'package:you_search/src/data/video_data_model.dart';
import 'package:you_search/src/ui/widgets/centered_message.dart';

class DetailPage extends StatefulWidget {
  final String videoId;

  const DetailPage({
    this.videoId,
  }) : super();
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _detailBloc = kiwi.KiwiContainer().resolve<DetailBloc>();

  @override
  void initState() {
    _detailBloc.add(FetchDetails(widget.videoId));
    super.initState();
  }

  @override
  void dispose() {
    _detailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailBloc,
      child: Scaffold(
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: _buildScaffoldContent,
        ),
      ),
    );
  }

  Widget _buildScaffoldContent(BuildContext context, DetailState state) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 178,
          pinned: true,
          flexibleSpace: _buildSliverAppBarContent(state),
        ),
        _buildPageBody(state),
      ],
    );
  }

  Widget _buildSliverAppBarContent(DetailState state) {
    if (state is DetailLoading) {
      return FlexibleSpaceBar();
    } else if (state is DetailSuccess) {
      return FlexibleSpaceBar(
        title: Text(
          state.data[0].snippet.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              state.data[0].snippet.thumbnails.high.url,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.15, 0.5],
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else if (state is DetailFailure) {
      return FlexibleSpaceBar(
        background: CenteredMesaage(
          message: state.message,
          iconData: Icons.error_outline,
        ),
      );
    }
    return Text('hello');
  }

  Widget _buildPageBody(DetailState state) {
    print(state);
    if (state is DetailLoading) {
      return SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is DetailSuccess) {
      return _buildVideoDetailList(state.data[0].snippet);
    } else if (state is DetailFailure) {
      return SliverFillRemaining(
        child: CenteredMesaage(
          message: state.message,
          iconData: Icons.error_outline,
        ),
      );
    }
    return SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildVideoDetailList(Snippet snippet) {
    return SliverPadding(
      padding: EdgeInsets.all(8),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SizedBox(height: 5),
            Text(
              snippet.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width * 2,
                child: Wrap(
                  spacing: 10,
                  children: _getTagsAsChipWidgets(snippet),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Description',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 5),
            Text(snippet.description),
          ],
        ),
      ),
    );
  }

  _getTagsAsChipWidgets(Snippet snippet) {
    return snippet.tags.map((tag) {
      return Chip(
        label: Text(tag),
      );
    }).toList();
  }
}
