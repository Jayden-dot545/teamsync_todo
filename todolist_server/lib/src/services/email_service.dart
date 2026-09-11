import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart' hide Message;

class EmailService {
  static const String appName = 'ToDosync';
  static const String defaultSenderEmail = 'noreply@todosync.app';

  /// Sends an email with ToDosync as sender.
  /// If SMTP credentials are provided via passwords.yaml or environment variables,
  /// it sends a real email over SMTP. Otherwise, it logs the email to the console.
  static Future<bool> sendEmail(
    Session session, {
    required String toEmail,
    required String subject,
    required String htmlBody,
    required String textBody,
  }) async {
    final smtpHost =
        Platform.environment['SMTP_HOST'] ?? session.passwords['smtpHost'];
    final smtpPortStr =
        Platform.environment['SMTP_PORT'] ?? session.passwords['smtpPort'];
    final smtpUser =
        Platform.environment['SMTP_USER'] ?? session.passwords['smtpUser'];
    final smtpPass =
        Platform.environment['SMTP_PASSWORD'] ??
        session.passwords['smtpPassword'];
    final fromEmail =
        Platform.environment['SMTP_FROM_EMAIL'] ??
        session.passwords['smtpFromEmail'] ??
        (smtpUser != null && smtpUser.contains('@')
            ? smtpUser
            : defaultSenderEmail);

    if (smtpHost != null &&
        smtpHost.isNotEmpty &&
        smtpUser != null &&
        smtpPass != null &&
        smtpPass.isNotEmpty &&
        !smtpPass.startsWith('DEIN_') &&
        !smtpPass.startsWith('HIER_')) {
      try {
        final port = int.tryParse(smtpPortStr ?? '') ?? 587;
        final smtpServer = SmtpServer(
          smtpHost,
          port: port,
          username: smtpUser,
          password: smtpPass,
          ssl: port == 465,
          allowInsecure: false,
        );

        final message = Message()
          ..from = Address(fromEmail, appName)
          ..recipients.add(toEmail)
          ..subject = subject
          ..text = textBody
          ..html = htmlBody;

        final sendReport = await send(message, smtpServer);
        session.log(
          '[$appName Email-Service] ✅ E-Mail erfolgreich an $toEmail versendet (${sendReport.toString()})',
          level: LogLevel.info,
        );
        return true;
      } catch (e, stack) {
        session.log(
          '[$appName Email-Service] ⚠️ SMTP-Fehler beim Senden an $toEmail: $e',
          level: LogLevel.error,
          stackTrace: stack,
        );
      }
    }

    // Development & fallback logging
    // ignore: avoid_print
    print(
      '\n╔════════════════════════════════════════════════════════════════╗',
    );
    // ignore: avoid_print
    print(
      '║ ✉️  TODOSYNC E-MAIL-DIENST                                      ║',
    );
    // ignore: avoid_print
    print('║ Empfänger: $toEmail');
    // ignore: avoid_print
    print('║ Betreff:   $subject');
    // ignore: avoid_print
    print('║ Inhalt:\n$textBody');
    // ignore: avoid_print
    print(
      '╚════════════════════════════════════════════════════════════════╝\n',
    );

    session.log(
      '[$appName Email-Service] ✉️ [DEV/LOCAL] E-Mail an $toEmail\n'
      '  Absender: $appName <$fromEmail>\n'
      '  Betreff: $subject\n'
      '  Inhalt: $textBody',
      level: LogLevel.info,
    );

    return true;
  }

  /// Sends the registration verification code with ToDosync branding.
  static Future<void> sendRegistrationVerificationCode(
    Session session, {
    required String email,
    required String verificationCode,
  }) async {
    final subject = '$appName: Dein Bestätigungscode lautet $verificationCode';
    final textBody =
        'Hallo!\n\nDein Registrierungs-Code für $appName lautet: $verificationCode\n\n'
        'Gib diesen Code in der App ein, um deine Registrierung abzuschließen.\n\n'
        'Beste Grüße,\nDein $appName Team';

    final htmlBody =
        '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background-color: #0F172A; color: #F8FAFC; margin: 0; padding: 30px 20px; }
    .card { max-width: 480px; margin: 0 auto; background: #1E293B; border: 1px solid #334155; border-radius: 20px; padding: 32px; text-align: center; }
    .logo { font-size: 28px; font-weight: bold; color: #38BDF8; letter-spacing: -0.5px; margin-bottom: 8px; }
    .subtitle { font-size: 14px; color: #94A3B8; margin-bottom: 24px; }
    .code-box { background: #0F172A; border: 2px dashed #38BDF8; border-radius: 12px; padding: 18px; font-size: 32px; font-weight: bold; letter-spacing: 6px; color: #38BDF8; margin: 24px 0; }
    .footer { font-size: 12px; color: #64748B; margin-top: 28px; }
  </style>
</head>
<body>
  <div class="card">
    <div class="logo">🚀 $appName</div>
    <div class="subtitle">Echtzeit-Synchronisation & Produktivität</div>
    <h2 style="color: #FFFFFF; margin: 0 0 12px 0;">Bestätige deine E-Mail</h2>
    <p style="color: #CBD5E1; font-size: 14px; line-height: 1.5;">Gib den folgenden Sicherheitscode in der App ein, um deine Registrierung abzuschließen:</p>
    <div class="code-box">$verificationCode</div>
    <p style="color: #94A3B8; font-size: 13px;">Dieser Code ist 15 Minuten lang gültig.</p>
    <div class="footer">Wenn du diese Anfrage nicht gestellt hast, kannst du diese E-Mail einfach ignorieren.</div>
  </div>
</body>
</html>
''';

    await sendEmail(
      session,
      toEmail: email,
      subject: subject,
      htmlBody: htmlBody,
      textBody: textBody,
    );
  }

  /// Sends a password reset verification code with ToDosync branding.
  static Future<void> sendPasswordResetVerificationCode(
    Session session, {
    required String email,
    required String verificationCode,
  }) async {
    final subject = '$appName: Code zum Zurücksetzen deines Passworts';
    final textBody =
        'Hallo!\n\nDu hast das Zurücksetzen deines Passworts für $appName angefordert.\n\n'
        'Dein Bestätigungscode lautet: $verificationCode\n\n'
        'Beste Grüße,\nDein $appName Team';

    final htmlBody =
        '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background-color: #0F172A; color: #F8FAFC; margin: 0; padding: 30px 20px; }
    .card { max-width: 480px; margin: 0 auto; background: #1E293B; border: 1px solid #334155; border-radius: 20px; padding: 32px; text-align: center; }
    .logo { font-size: 28px; font-weight: bold; color: #38BDF8; letter-spacing: -0.5px; margin-bottom: 8px; }
    .code-box { background: #0F172A; border: 2px dashed #F43F5E; border-radius: 12px; padding: 18px; font-size: 32px; font-weight: bold; letter-spacing: 6px; color: #F43F5E; margin: 24px 0; }
    .footer { font-size: 12px; color: #64748B; margin-top: 28px; }
  </style>
</head>
<body>
  <div class="card">
    <div class="logo">🚀 $appName</div>
    <h2 style="color: #FFFFFF; margin: 0 0 12px 0;">Passwort zurücksetzen</h2>
    <p style="color: #CBD5E1; font-size: 14px; line-height: 1.5;">Verwende diesen Code in der App, um ein neues Passwort zu vergeben:</p>
    <div class="code-box">$verificationCode</div>
    <div class="footer">Falls du dies nicht angefordert hast, ignoriere diese E-Mail bitte.</div>
  </div>
</body>
</html>
''';

    await sendEmail(
      session,
      toEmail: email,
      subject: subject,
      htmlBody: htmlBody,
      textBody: textBody,
    );
  }

  /// Sends a team list invitation email with ToDosync branding.
  static Future<void> sendListInvitation(
    Session session, {
    required String toEmail,
    required String listTitle,
    required String inviterName,
    required String inviteCode,
    String? inviteLink,
  }) async {
    final subject =
        '$inviterName hat dich zu „$listTitle“ auf $appName eingeladen! 🎉';
    final textBody =
        'Hallo!\n\n$inviterName hat dich eingeladen, gemeinsam an der ToDo-Liste „$listTitle“ auf $appName zu arbeiten.\n\n'
        'Dein Einladungs-Code: $inviteCode\n'
        '${inviteLink != null ? 'Oder direkt beitreten: $inviteLink\n' : ''}\n'
        'Beste Grüße,\nDein $appName Team';

    final htmlBody =
        '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background-color: #0F172A; color: #F8FAFC; margin: 0; padding: 30px 20px; }
    .card { max-width: 500px; margin: 0 auto; background: #1E293B; border: 1px solid #334155; border-radius: 20px; padding: 32px; text-align: center; }
    .logo { font-size: 28px; font-weight: bold; color: #38BDF8; letter-spacing: -0.5px; margin-bottom: 8px; }
    .badge { display: inline-block; background: #0284C7; color: white; padding: 6px 14px; border-radius: 20px; font-size: 13px; font-weight: 600; margin-bottom: 16px; }
    .code-box { background: #0F172A; border: 2px dashed #38BDF8; border-radius: 12px; padding: 16px; font-size: 24px; font-weight: bold; letter-spacing: 4px; color: #38BDF8; margin: 20px 0; }
    .btn { display: inline-block; background: #38BDF8; color: #0F172A; font-weight: bold; text-decoration: none; padding: 14px 28px; border-radius: 12px; font-size: 15px; margin-top: 12px; }
    .footer { font-size: 12px; color: #64748B; margin-top: 28px; }
  </style>
</head>
<body>
  <div class="card">
    <div class="logo">🚀 $appName</div>
    <div class="badge">Team-Einladung</div>
    <h2 style="color: #FFFFFF; margin: 0 0 10px 0;">Einladung zu „$listTitle“</h2>
    <p style="color: #CBD5E1; font-size: 14px; line-height: 1.5;"><strong style="color: #38BDF8;">$inviterName</strong> möchte diese Liste mit dir teilen.</p>
    <div class="code-box">$inviteCode</div>
    ${inviteLink != null ? '<a href="$inviteLink" class="btn">Liste in App öffnen 🚀</a>' : ''}
    <div class="footer">Erstelle Aufgaben, verfolge Fortschritte und arbeite in Echtzeit im Team zusammen.</div>
  </div>
</body>
</html>
''';

    await sendEmail(
      session,
      toEmail: toEmail,
      subject: subject,
      htmlBody: htmlBody,
      textBody: textBody,
    );
  }
}
