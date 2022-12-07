import 'package:ditonton/common/body_state_enum.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeNotifier provider;
  late int notifyListeners;

  setUp(() {
    notifyListeners = 0;
    provider = HomeNotifier()..addListener(() => notifyListeners += 1);
  });

  test('should state is Movie when first called', () {
    expect(provider.bodyState, BodyState.Movie);
    expect(notifyListeners, 0);
  });

  test('should change state when setBody new value is Movie', () {
    // arrange

    // act
    provider.changeToMovie();
    // assert
    expect(provider.bodyState, BodyState.Movie);
    expect(notifyListeners, 1);
  });

  test('should change state when setBody new value is Tv', () {
    // arrange

    // act
    provider.changeToTv();
    // assert
    expect(provider.bodyState, BodyState.Tv);
    expect(notifyListeners, 1);
  });
}
