import 'package:appflowy/core/frameless_window.dart';
import 'package:appflowy/env/cloud_env.dart';
import 'package:appflowy/generated/locale_keys.g.dart';
import 'package:appflowy/shared/window_title_bar.dart';
import 'package:appflowy/user/application/sign_in_bloc.dart';
import 'package:appflowy/user/presentation/screens/sign_in_screen/widgets/widgets.dart';
import 'package:appflowy/user/presentation/widgets/widgets.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowy_infra_ui/flowy_infra_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopSignInScreen extends StatelessWidget {
  const DesktopSignInScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const indicatorMinHeight = 4.0;
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: Center(
            child: AuthFormContainer(
              children: [
                const Spacer(),

                const VSpace(20),

                // logo and title
                FlowyLogoTitle(
                  title: LocaleKeys.welcomeText.tr(),
                  logoSize: const Size(60, 60),
                ),
                const VSpace(20),

                // magic link sign in
                const SignInWithMagicLinkButtons(),
                const VSpace(20),

                // third-party sign in.
                if (isAuthEnabled) ...[
                  const _OrDivider(),
                  const VSpace(20),
                  const ThirdPartySignInButtons(),
                  const VSpace(20),
                ],

                // sign in agreement
                const SignInAgreement(),

                // loading status
                const VSpace(indicatorMinHeight),
                state.isSubmitting
                    ? const LinearProgressIndicator(
                        minHeight: indicatorMinHeight,
                      )
                    : const VSpace(indicatorMinHeight),
                const VSpace(20),

                const Spacer(),

                // anonymous sign in
                const SignInAnonymousButtonV2(),
                const VSpace(16),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(PlatformExtension.isWindows ? 100 : 60),
      child: PlatformExtension.isWindows
          ? const WindowTitleBar()
          : const MoveWindowDetector(),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FlowyText.regular(LocaleKeys.signIn_or.tr()),
        ),
        const Flexible(child: Divider(thickness: 1)),
      ],
    );
  }
}
