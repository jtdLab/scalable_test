part of 'presentation_test.dart';

// better doc
final iosDevices = [
  const Device(size: Size(320, 568), name: 'iPhone SE 1st'),
  const Device(size: Size(375, 667), name: 'iPhone 8'),
  const Device(size: Size(414, 896), name: 'iPhone 11'),
  const Device(size: Size(428, 926), name: 'iPhone 13 Pro Max'),
];

// TODO
final androidDevices = [
  const Device(size: Size(320, 568), name: 'iPhone SE 1st'),
  const Device(size: Size(375, 667), name: 'iPhone 8'),
  const Device(size: Size(414, 896), name: 'iPhone 11'),
  const Device(size: Size(428, 926), name: 'iPhone 13 Pro Max'),
];

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
