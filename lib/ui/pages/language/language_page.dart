import 'package:ecommerce/blocs/setting/app_setting_cubit.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/entities/language/language_entity.dart';
import 'package:ecommerce/ui/pages/language/widgets/appbar_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late AppSettingCubit _appSettingCubit;
  late List<LanguageEntity> languageList;

  @override
  void initState() {
    _appSettingCubit = BlocProvider.of<AppSettingCubit>(context);
    languageList = [
      LanguageEntity(
          locale: S.current.language_english,
          languageCode: const Locale.fromSubtags(languageCode: 'en')),
      LanguageEntity(
          locale: S.current.language_vietnamese,
          languageCode: const Locale.fromSubtags(languageCode: 'vi'))
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarLanguage(),
              Text(
                S.current.language,
                style: AppTextStyle.blackS20W800,
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: _buildLanguageSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSection() {
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      buildWhen: (prev, current) {
        return prev.locale != current.locale;
      },
      builder: (context, state) {
        return ListView.separated(
          itemCount: languageList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _appSettingCubit.changeLocal(
                    locale: languageList[index].languageCode);
              },
              child: languageList[index].languageCode == state.locale
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          languageList[index].locale,
                          style: AppTextStyle.blackS16,
                        ),
                        const Icon(Icons.check),
                      ],
                    )
                  : Text(
                      languageList[index].locale,
                      style: AppTextStyle.greyA16,
                    ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        );
      },
    );
  }
}
