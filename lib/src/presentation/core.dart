part of 'presentation_test.dart';

// TODO better doc
/// This should be used in tests to mock out subtrees with complex dependencies
/// when the specific test case does not need the subtree.
class MockWidget extends StatelessWidget {
  const MockWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// TODO better doc
extension WidgetTesterX on WidgetTester {
  // TODO fix generics
  Future<void> pumpBlocProvider<T extends StateStreamableSource>(
    BlocProvider provider,
  ) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [provider],
        child: const MockWidget(),
      ),
    );
  }

  // TODO fix generics
  Future<void> pumpBlocListener<T extends StateStreamableSource>(
    BlocListener listener, {
    required T listenTo,
  }) {
    return pumpWidget(
      BlocProvider(
        create: (_) => listenTo,
        child: MultiBlocListener(
          listeners: [listener],
          child: const MockWidget(),
        ),
      ),
    );
  }
}
