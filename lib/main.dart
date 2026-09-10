// import 'dart:io' show Platform;
// import 'dart:async' show runZonedGuarded;

// import 'package:dartnative/dartnative.dart';
// import 'package:dartnative_skia/dartnative_skia.dart';
// import 'package:dartnative_sqlite/dartnative_sqlite.dart';
// import 'package:dartnative_firebase/dartnative_firebase.dart';
// import 'package:dartnative_notifications/dartnative_notifications.dart';

// import 'dartnative_plugin_registrant.dart';
// import 'screens/chat_screen_demo.dart';
// import 'screens/media/chatgpt_picker_demo.dart';
// import 'screens/home/demo_ui.dart' show playgroundOverlayStyle;
// import 'screens/home/home_shell.dart';
// import 'screens/grid_demo.dart';
// import 'screens/image_demo.dart';
// import 'screens/canvas_demo.dart';
// import 'screens/text_field_demo.dart';
// import 'screens/text_rendering_demo.dart';
// import 'screens/state_menu_screen.dart';
// import 'screens/state_basics_demo.dart';
// import 'screens/state_store_demo.dart';
// import 'screens/storage_menu_screen.dart';
// import 'screens/storage_demo.dart';
// import 'screens/system_connectivity_demo.dart';
// import 'screens/social_sign_in_demo.dart';
// import 'screens/notifications_demo.dart';
// import 'screens/animated_size_demo.dart';
// import 'screens/liquid_glass/liquid_glass_menu.dart';
// import 'screens/liquid_glass/glass_merge_demo.dart';
// import 'screens/liquid_glass/morphing_buttons_demo.dart';
// import 'screens/liquid_glass/zoom_morph_demo.dart';
// import 'screens/liquid_glass/bar_actions_demo.dart';
// import 'screens/liquid_glass/large_title_demo.dart';
// import 'screens/liquid_glass/floating_tab_bar_demo.dart';
// import 'screens/liquid_glass/bar_surfaces_demo.dart';
// import 'screens/material3/material3_menu.dart';
// import 'screens/material3/m3_hide_on_scroll_demo.dart';
// import 'screens/material3/m3_badges_demo.dart';
// import 'screens/material3/m3_large_top_bar_demo.dart';
// import 'screens/material3/m3_dynamic_color_demo.dart';
// import 'screens/material3/m3_search_demo.dart';
// import 'screens/material3/m3_search_appbar_demo.dart';
// import 'screens/material3/m3_menus_demo.dart';
// import 'screens/music/music_demo.dart';
// import 'screens/color_picker_demo.dart';
// import 'screens/carousel_demo.dart';
// import 'screens/text_typewriter_demo.dart';

// void main() {
//   runZonedGuarded(() {
//     // `verbose: true` enables framework debug logs (mutations, setState,
//     // scroll events, …). Invaluable for debugging, but the logging I/O has a
//     // real performance cost — use `verbose: false, saveToFile: false` when
//     // measuring scroll performance or shipping.
//     DartNativeLogger.run(() async {
//       // Registers platform bindings (iOS/Android) AND loads FFI symbols for
//       // every dartnative_* plugin in pubspec.yaml. Single source of truth —
//       // regenerate via `dn pub get`.
//       DartNativePluginRegistrant.registerAll();
//       registerSkiaFactories();
//       // Pre-warm SQLite FFI linkage so all panels can open databases
//       // immediately without lazy-init overhead.
//       Sqlite.ensureInitialized();
//       if (Platform.isIOS) {
//         // Register pubspec-declared fonts (assets/fonts/*.ttf|.otf) with UIKit
//         // so `IconData(0xXXXX, fontFamily: 'CustomFamily')` and
//         // `TextStyle(fontFamily: 'CustomFamily')` resolve correctly.
//         DartNativeFontRegistrant.registerAll();
//       }
//       // Firebase loads symbols + initializes the default app from the
//       // platform config (GoogleService-Info.plist / google-services.json),
//       // then installs the FCM delegate. Done here so the token is ready
//       // before any screen opens.
//       try {
//         await Firebase.initializeApp();
//         FirebaseMessaging.setup();
//       } catch (e, st) {
//         dnLog(
//             '[main] Firebase init failed — continuing without Firebase: $e\n$st');
//       }
//       try {
//         DartNativeNotifications.setup(onTap: (payload) {
//           // TODO: route to the relevant screen based on payload.
//         });
//       } catch (e, st) {
//         dnLog('[main] Notifications init failed: $e\n$st');
//       }
//       registerRoutes({
//         '/chat': (_) => const ChatScreenDemo(),
//         '/chatgpt-picker': (_) => const ChatGptPickerDemo(),
//         '/music': (_) => const MusicDemo(),
//         '/color-picker': (_) => const ColorPickerDemo(),
//         '/carousel': (_) => const CarouselDemo(),
//         '/live-text': (_) => const TextTypewriterDemo(),
//         '/grid': (_) => const GridDemo(),
//         '/image': (_) => const ImageDemo(),
//         '/text-field': (_) => const TextFieldDemo(),
//         '/text-rendering': (_) => const TextRenderingDemo(),
//         '/canvas': (_) => const CanvasDemo(),
//         '/state': (_) => const StateMenuScreen(),
//         '/state-basics': (_) => const StateBasicsDemo(),
//         '/state-store': (_) => const StateStoreDemo(),
//         '/storage': (_) => const StorageMenuScreen(),
//         '/storage-prefs': (_) =>
//             const StorageDemo(initialTab: StorageTab.preferences),
//         '/storage-secure': (_) =>
//             const StorageDemo(initialTab: StorageTab.secureStorage),
//         '/storage-cache': (_) => const StorageDemo(initialTab: StorageTab.hive),
//         '/storage-sqlite': (_) =>
//             const StorageDemo(initialTab: StorageTab.sqlite),
//         '/system-connectivity': (_) => const SystemConnectivityDemo(),
//         '/social-sign-in': (_) => const SocialSignInDemo(),
//         '/notifications': (_) => const NotificationsDemo(),
//         '/animated-size': (_) => const AnimatedSizeDemo(),
//         '/liquid-glass': (_) => const LiquidGlassMenuScreen(),
//         '/liquid-glass-merge': (_) => const GlassMergeDemo(),
//         '/liquid-glass-zoom': (_) => const ZoomMorphDemo(),
//         '/liquid-glass-morphing-buttons': (_) => const MorphingButtonsDemo(),
//         '/liquid-glass-bar-actions': (_) => const BarActionsDemo(),
//         '/liquid-glass-large-title': (_) => const LargeTitleDemo(),
//         '/liquid-glass-tab-bar': (_) => const FloatingTabBarDemo(),
//         '/liquid-glass-surfaces': (_) => const BarSurfacesDemo(),
//         '/material3': (_) => const Material3MenuScreen(),
//         '/material3-hide-on-scroll': (_) => const M3HideOnScrollDemo(),
//         '/material3-badges': (_) => const M3BadgesDemo(),
//         '/material3-large-top-bar': (_) => const M3LargeTopBarDemo(),
//         '/material3-dynamic-color': (_) => const M3DynamicColorDemo(),
//         '/material3-search': (_) => const M3SearchDemo(),
//         '/material3-search-appbar': (_) => const M3SearchAppBarDemo(),
//         '/material3-menus': (_) => const M3MenusDemo(),
//       });
//       if (DartNativeLogger.filePath != null) {
//         dnLog('[Logger] Log file: ${DartNativeLogger.filePath}');
//       }
//       // Theme before first build — a hot restart from a PUSHED screen builds
//       // that screen's tree immediately with the global palette.
//       await restorePlaygroundTheme();
//       // App-level DEFAULT system chrome, applied by the Navigator on every
//       // push — theme-aware. Screens with a fixed look override it in their
//       // initState; the Navigator restores the previous style on pop.
//       SystemChrome.defaultStyle = playgroundOverlayStyle();
//       runApp(const PlaygroundHome());
//     }, verbose: false, saveToFile: false);
//   }, (error, stack) {
//     dnLog('[main] UNCAUGHT ERROR: $error\n$stack');
//   });
// }

import 'dart:async';

import 'package:bloc_signals_dn/bloc_signals_dn.dart';
import 'package:dartnative/dartnative.dart'
    hide
        effect,
        computed,
        Computed,
        signal,
        Signal,
        SignalWatch,
        ListenableWatch,
        Provided;

// ==========================================
// 2. BLoC State & Events
// ==========================================
/// Sealed class representing events dispatched to the [LoginBloc].
sealed class LoginEvent {}

/// Triggered when the user types in the username text field.
class UsernameChanged extends LoginEvent {
  final String username;
  UsernameChanged(this.username);
}

/// Triggered when the user types in the password text field.
class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);
}

/// Triggered when the user clicks the "Sign In" button.
class SubmitLogin extends LoginEvent {}

/// Triggered when the user logs out from the dashboard.
class Logout extends LoginEvent {}

/// Immutable state containing the login UI credentials, loading status,
/// error message, and authentication state.
class LoginState {
  final String username;
  final String password;
  final bool isLoading;
  final String? error;
  final bool isLoggedIn;

  const LoginState({
    this.username = '',
    this.password = '',
    this.isLoading = false,
    this.error,
    this.isLoggedIn = false,
  });

  /// Returns a copy of the state with modified properties.
  LoginState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    String? error,
    bool? isLoggedIn,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error, // If passed null, it clears the error.
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

/// [LoginBloc] coordinates the user authentication flow.
/// It registers constructor-scoped [on] event handlers to process updates synchronously.
class LoginBloc extends BlocSignal<LoginEvent, LoginState> {
  LoginBloc() : super(initialState: const LoginState()) {
    /// Update username credential on [UsernameChanged].
    on<UsernameChanged>((event, emit) {
      emit(stateValue.copyWith(username: event.username));
    });

    /// Update password credential on [PasswordChanged].
    on<PasswordChanged>((event, emit) {
      emit(stateValue.copyWith(password: event.password));
    });

    /// Process authentication validation and simulate network latency on [SubmitLogin].
    on<SubmitLogin>((event, emit) async {
      // Validate inputs
      if (stateValue.username.trim().isEmpty) {
        emit(stateValue.copyWith(error: 'Username cannot be empty'));
        return;
      }
      if (stateValue.password.length < 4) {
        emit(
          stateValue.copyWith(error: 'Password must be at least 4 characters'),
        );
        return;
      }

      // Enter loading state
      emit(stateValue.copyWith(isLoading: true, error: null));

      // Simulate a network latency/async process
      await Future<void>.delayed(const Duration(milliseconds: 800));

      if (stateValue.password == 'password') {
        // Authenticated successfully
        emit(stateValue.copyWith(isLoading: false, isLoggedIn: true));
      } else {
        // Authentication failed
        emit(
          stateValue.copyWith(
            isLoading: false,
            error: 'Incorrect password! (Hint: use "password")',
          ),
        );
      }
    });

    /// Reset authentication credentials on [Logout].
    on<Logout>((event, emit) {
      emit(const LoginState());
    });
  }
}

// ==========================================
// 2b. Timer BLoC & Ticker
// ==========================================
class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}

sealed class TimerEvent {}

class TimerStarted extends TimerEvent {
  final int duration;
  TimerStarted({required this.duration});
}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerReset extends TimerEvent {}

class _TimerTicked extends TimerEvent {
  final int duration;
  _TimerTicked({required this.duration});
}

sealed class TimerState {
  final int duration;
  const TimerState(this.duration);
}

class TimerInitial extends TimerState {
  const TimerInitial(super.duration);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);
}

class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}

/// [TimerBloc] manages countdown timer state using `on<E>` event handlers
/// and ticker stream subscriptions.
class TimerBloc extends BlocSignal<TimerEvent, TimerState> {
  final Ticker ticker;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required this.ticker})
    : super(initialState: const TimerInitial(_duration)) {
    /// Start countdown timer on [TimerStarted].
    on<TimerStarted>((event, emit) {
      emit(TimerRunInProgress(event.duration));
      _tickerSubscription?.cancel();
      _tickerSubscription = ticker
          .tick(ticks: event.duration)
          .listen((duration) => add(_TimerTicked(duration: duration)));
    });

    /// Pause active timer subscription on [TimerPaused].
    on<TimerPaused>((event, emit) {
      if (stateValue is TimerRunInProgress) {
        _tickerSubscription?.pause();
        emit(TimerRunPause(stateValue.duration));
      }
    });

    /// Resume paused timer subscription on [TimerResumed].
    on<TimerResumed>((event, emit) {
      if (stateValue is TimerRunPause) {
        _tickerSubscription?.resume();
        emit(TimerRunInProgress(stateValue.duration));
      }
    });

    /// Cancel timer subscription and reset state on [TimerReset].
    on<TimerReset>((event, emit) {
      _tickerSubscription?.cancel();
      emit(const TimerInitial(_duration));
    });

    /// Process timer tick progression on [_TimerTicked].
    on<_TimerTicked>((event, emit) {
      emit(
        event.duration > 0
            ? TimerRunInProgress(event.duration)
            : const TimerRunComplete(),
      );
    });
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}

void main() {
  final loginBloc = LoginBloc();
  final routes = <String, WidgetBuilder>{
    '/login': (_) => const LoginScreen(),
    '/home': (_) => const HomeScreen(),
    '/timer': (_) => BlocSignalProvider<TimerBloc>(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: const TimerScreen(),
    ),
  };
  registerRoutes(routes);

  runApp(
    BlocSignalProvider<LoginBloc>.value(
      value: loginBloc,
      child: MyApp(routes: routes),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes;

  const MyApp({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return App(
      title: 'BlocSignal Demo',
      theme: ThemeData(colorScheme: ColorScheme.light()),
      darkTheme: ThemeData(colorScheme: ColorScheme.dark()),
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      routes: routes,
    );
  }
}

// ==========================================
// 4. UI Screens
// ==========================================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Retrieve [LoginBloc] instance using the context reader extension.
    /// This retrieves the instance without establishing a widget rebuild dependency.
    final bloc = context.read<LoginBloc>();

    return BlocSignalListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          !previous.isLoggedIn && current.isLoggedIn,
      listener: (context, state) {
        Navigator.of(context).pushReplacement(
          PageRoute(builder: (_) => const HomeScreen(), settings: '/home'),
        );
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: BlocSignalBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(
                              MaterialSymbolsRounded.lock_outline,
                              size: 64,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Welcome Back',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Sign in to demonstrate BlocSignal + DartNative',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 32),

                            // Username field
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: const Icon(
                                  MaterialSymbolsRounded.person_outline,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              // Dispatch event on change
                              onChanged: (val) =>
                                  bloc.add(UsernameChanged(val)),
                            ),
                            const SizedBox(height: 16),

                            // Password field
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(
                                  MaterialSymbolsRounded.lock_open,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              // Dispatch event on change
                              onChanged: (val) =>
                                  bloc.add(PasswordChanged(val)),
                            ),

                            // Render validation errors dynamically
                            if (state.error != null) ...[
                              const SizedBox(height: 16),
                              Text(
                                state.error!,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            const SizedBox(height: 24),

                            // Submit button
                            Button(
                              title: state.isLoading ? null : 'Sign In',
                              variant: ButtonVariant.filled,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              onPressed: state.isLoading
                                  ? null
                                  : () => bloc.add(SubmitLogin()),
                              child: state.isLoading
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    )
                                  : null,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Retrieve the BLoC to handle the logout event.
    final bloc = context.read<LoginBloc>();

    return BlocSignalListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.isLoggedIn && !current.isLoggedIn,
      listener: (context, state) {
        Navigator.of(context).pushReplacement(
          PageRoute(builder: (_) => const LoginScreen(), settings: '/login'),
        );
      },
      child: BlocSignalBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(MaterialSymbolsRounded.logout),
                onPressed: () => bloc.add(Logout()),
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello, ${state.username}!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'You have successfully signed in using a synchronous '
                    'BlocSignal pattern and dartnative navigation!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  Button(
                    title: 'Go to Timer Example',
                    variant: ButtonVariant.filled,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/timer'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TimerBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('BlocSignal Timer')),
      body: Center(
        child: BlocSignalBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            final durationStr =
                '${(state.duration / 60).floor().toString().padLeft(2, '0')}'
                ':${(state.duration % 60).toString().padLeft(2, '0')}';

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  durationStr,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is TimerInitial) ...[
                      FloatingActionButton(
                        onPressed: () =>
                            bloc.add(TimerStarted(duration: state.duration)),
                        child: const Icon(MaterialSymbolsRounded.play_arrow),
                      ),
                    ],
                    if (state is TimerRunInProgress) ...[
                      FloatingActionButton(
                        onPressed: () => bloc.add(TimerPaused()),
                        child: const Icon(MaterialSymbolsRounded.pause),
                      ),
                      const SizedBox(width: 16),
                      FloatingActionButton(
                        onPressed: () => bloc.add(TimerReset()),
                        child: const Icon(MaterialSymbolsRounded.replay),
                      ),
                    ],
                    if (state is TimerRunPause) ...[
                      FloatingActionButton(
                        onPressed: () => bloc.add(TimerResumed()),
                        child: const Icon(MaterialSymbolsRounded.play_arrow),
                      ),
                      const SizedBox(width: 16),
                      FloatingActionButton(
                        onPressed: () => bloc.add(TimerReset()),
                        child: const Icon(MaterialSymbolsRounded.replay),
                      ),
                    ],
                    if (state is TimerRunComplete) ...[
                      FloatingActionButton(
                        onPressed: () => bloc.add(TimerReset()),
                        child: const Icon(MaterialSymbolsRounded.replay),
                      ),
                    ],
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
