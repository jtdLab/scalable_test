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

// TODO doc
class RouterProvider extends StatelessWidget {
  final StackRouter router;
  final Widget child;

  const RouterProvider({
    Key? key,
    required this.router,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StackRouterScope(
      controller: router,
      stateHash: 0,
      child: child,
    );
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

  // TODO fix generics + assert at least one provider
  Future<void> pumpBlocListener<T extends StateStreamableSource>(
    BlocListener listener, {
    required List<BlocProvider> providers,
    StackRouter? router,
  }) async {
    final multiBlocProvider = MultiBlocProvider(
      providers: providers,
      child: MultiBlocListener(
        listeners: [listener],
        child: const MockWidget(),
      ),
    );

    if (router == null) {
      pumpWidget(multiBlocProvider);
    } else {
      pumpWidget(
        StackRouterScope(
          controller: router,
          stateHash: 0,
          child: multiBlocProvider,
        ),
      );
    }
  }
}
