## Ecommerce App - hungnt

## File structure

```
assets
└───font
└───image
    └───2.0x
    └───3.0x
libs
└───bloc
│   └───app_cubit.dart
│   └───app_state.dart
└───common
│   └───app_colors.dart
│   └───app_dimens.dart
│   └───app_images.dart
│   └───app_shadows.dart
│   └───app_text_styles.dart
│   └───app_themes.dart
└───configs
│   └───app_configs.dart
└───database
│   └───secure_storage_helper.dart
│   └───shared_preferences_helper.dart
│   └───...
└───l10n
└───models
│   └───entities
│   │   └───user_entity.dart
│   │   └───...
│   └───enums
│   │   └───load_status.dart
│   │   └───...
│   └───params
│   │   └───sign_up_param.dart
│   │   └───...
│   └───response
│       └───array_response.dart
│       └───object_response.dart
└───networks
│   └───api_client.dart
│   └───api_interceptors.dart
│   └───api_util.dart
└───router
│   └───route_config.dart
└───repositories
│   └───auth_repository.dart
│   └───user_repository.dart.dart
│   └───...
└───ui
│   └───commons
│   │   └───app_bottom_sheet.dart
│   │   └───app_dialog.dart
│   │   └───app_snackbar.dart
│   │   └───...
│   └───pages
│   │   └───splash
│   │   │   └───splash_page.dart
│   │   │   └───splash_cubit.dart
│   │   │   └───splash_state.dart
│   │   └───...
│   └───widget //Chứa các widget base cho app
│       └───appbar
│       └───buttons
│       │   └───app_button.dart
│       │   └───app_icon_button.dart
│       │   └───...
│       └───images
│       │   └───app_cache_image.dart
│       │   └───app_circle_avatar.dart
│       └───textfields
│       └───shimmer
│       └───...
└───utils
│   └───date_utils.dart
│   └───file_utils.dart
│   └───logger.dart
│   └───utils.dart
│───main.dart
│───main_dev.dart //Config môi trường dev
└───main_staging.dart //Config môi trường production
```