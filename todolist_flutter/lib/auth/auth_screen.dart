import 'package:flutter/material.dart';
import '../core/client.dart';
import '../core/constants.dart';
import '../core/localization_helper.dart';
import '../core/user_prefs.dart';
import '../core/widgets/app_background.dart';
import '../core/widgets/team_sync_logo.dart';

enum AuthMode { login, register, verifyCode }

class AuthScreen extends StatefulWidget {
  final bool startInSwitchAccountMode;

  const AuthScreen({super.key, this.startInSwitchAccountMode = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  // Registration state
  UuidValue? _accountRequestId;
  String? _pendingEmail;
  String? _pendingPassword;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final saved = UserPrefs.lastEmailNotifier.value;
    if (saved != null && saved.trim().isNotEmpty) {
      _emailController.text = saved.trim();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      setState(() => _errorMessage = context.isEn ? 'Please enter your email address.' : 'Bitte gib deine E-Mail-Adresse ein.');
      return;
    }
    if (!email.contains('@') || !email.contains('.')) {
      setState(() => _errorMessage = context.isEn ? 'Please enter a valid email address.' : 'Bitte gib eine gültige E-Mail-Adresse ein.');
      return;
    }
    if (password.isEmpty) {
      setState(() => _errorMessage = context.isEn ? 'Please enter your password.' : 'Bitte gib dein Passwort ein.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final authSuccess = await client.emailIdp.login(
        email: email,
        password: password,
      );

      await client.auth.updateSignedInUser(authSuccess);
      await UserPrefs.setLastEmail(email);
      await UserPrefs.syncFromServer();

      if (mounted && context.mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        final errStr = e.toString().toLowerCase();
        if (errStr.contains('invalid') || errStr.contains('credential') || errStr.contains('password')) {
          _errorMessage = context.isEn
              ? 'Invalid email or password. If you don\'t have an account yet, switch to the "Register" tab.'
              : 'Falsche E-Mail oder falsches Passwort. Falls du noch kein Konto hast, wechsle auf den Reiter "Registrieren".';
        } else if (errStr.contains('socket') || errStr.contains('connection') || errStr.contains('failed to connect')) {
          _errorMessage = context.isEn
              ? 'Connection error to server (localhost:8080). Please ensure server is running.'
              : 'Verbindungsfehler zum Server (localhost:8080). Bitte stelle sicher, dass der Server läuft.';
        } else {
          _errorMessage = context.isEn ? 'Sign in failed: $e' : 'Anmeldung fehlgeschlagen: $e';
        }
      });
    }
  }

  Future<void> _handleStartRegistration() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      setState(() => _errorMessage = context.isEn ? 'Please enter an email address for registration.' : 'Bitte gib eine E-Mail-Adresse für die Registrierung ein.');
      return;
    }
    if (!email.contains('@') || !email.contains('.')) {
      setState(() => _errorMessage = context.isEn ? 'Please enter a valid email address.' : 'Bitte gib eine gültige E-Mail-Adresse ein.');
      return;
    }
    if (password.length < 8) {
      setState(() => _errorMessage = context.isEn ? 'Password must be at least 8 characters long.' : 'Das Passwort muss mindestens 8 Zeichen lang sein.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final reqId = await client.emailIdp.startRegistration(email: email);
      _accountRequestId = reqId;
      _pendingEmail = email;
      _pendingPassword = password;

      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _successMessage = context.isEn
            ? 'Confirmation code sent! Check your inbox (or server console).'
            : 'Bestätigungscode wurde gesendet! Prüfe dein E-Mail-Postfach (oder das Server-Terminal).';
      });

      _showVerificationDialog();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = context.isEn ? 'Could not start registration: $e' : 'Registrierung konnte nicht gestartet werden: $e';
      });
    }
  }

  void _showVerificationDialog() {
    _codeController.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: AppColors.surface(context),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                const Icon(Icons.mark_email_read_outlined, color: AppColors.primary),
                const SizedBox(width: 10),
                Text(
                  context.isEn ? 'Confirm Code' : 'Code bestätigen',
                  style: TextStyle(color: AppColors.text(context), fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.isEn
                      ? 'An 8-digit confirmation code was generated for $_pendingEmail.'
                      : 'Ein 8-stelliger Bestätigungscode wurde für $_pendingEmail generiert.',
                  style: TextStyle(color: AppColors.textSecondary(context), fontSize: 13),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          context.isEn
                              ? 'Local Dev: You will find the verification code directly in the server terminal!'
                              : 'Lokale Entwicklung: Den Code findest du direkt im Terminal deines Servers!',
                          style: TextStyle(fontSize: 11.5, color: AppColors.text(context)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: AppColors.text(context), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                  decoration: InputDecoration(
                    labelText: context.isEn ? '8-digit Code' : '8-stelliger Code',
                    hintText: context.isEn ? 'e.g. 12345678' : 'z.B. 12345678',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(context.isEn ? 'Cancel' : 'Abbrechen'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final code = _codeController.text.trim();
                  if (code.isEmpty) return;

                  Navigator.of(ctx).pop();
                  await _finishRegistrationWithCode(code);
                },
                child: Text(context.isEn ? 'Activate Account' : 'Konto aktivieren'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _finishRegistrationWithCode(String code) async {
    if (_accountRequestId == null || _pendingPassword == null || _pendingEmail == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = await client.emailIdp.verifyRegistrationCode(
        accountRequestId: _accountRequestId!,
        verificationCode: code,
      );

      final authSuccess = await client.emailIdp.finishRegistration(
        registrationToken: token,
        password: _pendingPassword!,
      );

      await client.auth.updateSignedInUser(authSuccess);
      await UserPrefs.setLastEmail(_pendingEmail!);
      await UserPrefs.syncFromServer();

      if (mounted && context.mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = context.isEn ? 'Code invalid or expired: $e' : 'Code ungültig oder abgelaufen: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Navigator.canPop(context)
              ? IconButton(
                  tooltip: context.isEn ? 'Back to overview' : 'Zurück zur Übersicht',
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surface(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.text(context)),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          actions: [
            ValueListenableBuilder<ThemeMode>(
              valueListenable: UserPrefs.themeModeNotifier,
              builder: (context, mode, _) {
                final isCurrentLight = mode == ThemeMode.light ||
                    (mode == ThemeMode.system && Theme.of(context).brightness == Brightness.light);
                return IconButton(
                  tooltip: isCurrentLight
                      ? (context.isEn ? 'Switch to Dark Mode' : 'Zu Dunkelmodus wechseln')
                      : (context.isEn ? 'Switch to Light Mode' : 'Zu Hellmodus wechseln'),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surface(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: Icon(
                      isCurrentLight ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      size: 18,
                      color: isCurrentLight ? const Color(0xFF6366F1) : const Color(0xFFFBBF24),
                    ),
                  ),
                  onPressed: () => UserPrefs.setThemeMode(
                    isCurrentLight ? ThemeMode.dark : ThemeMode.light,
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TeamSyncLogo(size: 72),
                    const SizedBox(height: 14),
                    Text(
                      'TeamSync ToDo',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text(context),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.isEn
                          ? 'Collaborative task management & notes in real time'
                          : 'Kollaborative Aufgabenverwaltung & Notizen in Echtzeit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main Card with Tabs
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: AppColors.surface(context),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border(context), width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: isLight ? const Color(0x0A0F172A) : Colors.black.withValues(alpha: 0.35),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tab Bar
                          Container(
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight(context),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: AppColors.textSecondary(context),
                              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                              tabs: [
                                Tab(text: context.isEn ? 'Sign In' : 'Anmelden'),
                                Tab(text: context.isEn ? 'Register' : 'Registrieren'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // E-Mail Input
                          Text(
                            context.isEn ? 'Email Address' : 'E-Mail-Adresse',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.text(context)),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: AppColors.text(context)),
                            decoration: InputDecoration(
                              hintText: context.isEn ? 'name@example.com' : 'name@beispiel.de',
                              prefixIcon: Icon(Icons.email_outlined, color: AppColors.textSecondary(context), size: 20),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Passwort Input
                          Text(
                            context.isEn ? 'Password' : 'Passwort',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.text(context)),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: TextStyle(color: AppColors.text(context)),
                            onSubmitted: (_) => _tabController.index == 0 ? _handleLogin() : _handleStartRegistration(),
                            decoration: InputDecoration(
                              hintText: context.isEn ? 'At least 8 characters' : 'Mindestens 8 Zeichen',
                              prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary(context), size: 20),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: AppColors.textSecondary(context),
                                  size: 20,
                                ),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                            ),
                          ),

                          // Error message banner
                          if (_errorMessage != null) ...[
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.priorityHigh.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.priorityHigh.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error_outline_rounded, size: 16, color: AppColors.priorityHigh),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: const TextStyle(fontSize: 12.5, color: AppColors.priorityHigh, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          // Success message banner
                          if (_successMessage != null) ...[
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.priorityLow.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.priorityLow.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle_outline_rounded, size: 16, color: AppColors.priorityLow),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _successMessage!,
                                      style: const TextStyle(fontSize: 12.5, color: AppColors.priorityLow, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 20),

                          // Action Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () => _tabController.index == 0 ? _handleLogin() : _handleStartRegistration(),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _tabController.index == 0
                                              ? (context.isEn ? 'Sign In Now' : 'Jetzt Anmelden')
                                              : (context.isEn ? 'Create Account' : 'Konto erstellen'),
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_forward_rounded, size: 18),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Clear cache button if needed
                    TextButton.icon(
                      onPressed: () async {
                        await UserPrefs.clearAll();
                        _emailController.clear();
                        _passwordController.clear();
                        if (mounted) setState(() => _errorMessage = null);
                      },
                      icon: const Icon(Icons.cleaning_services_rounded, size: 16),
                      label: Text(
                        context.isEn
                            ? 'Clear saved sign-in cache'
                            : 'Gespeicherten Anmelde-Cache leeren',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
