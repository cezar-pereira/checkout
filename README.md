# Checkout Project

Este é um projeto simples de checkout

## Pré-requisitos

Antes de começar, você precisa ter as seguintes ferramentas instaladas em sua máquina:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Versão 3.24.1)
- [Android Studio](https://developer.android.com/studio) ou [Visual Studio Code](https://code.visualstudio.com/) com o plugin do Flutter
- Emulador Android ou dispositivo físico

## Packages utilizados

1. flutter_modular
2. shared_preferences

## Funcionalidades

1. #### Adicionar, remover e listar produtos
2. #### Listar promoções
3. #### Iniciar venda

## Testes unitários

1. #### Testes da classe CheckoutEntity

## Instalação

1. Clone este repositório:

   ```bash
   git clone https://github.com/cezar-pereira/checkout.git
   ```

2. Acesse o diretório do projeto

3. Instale as dependências do Flutter:

   ```bash
   flutter pub get
   ```

4. Execute o projeto:

   ```bash
   flutter run
   ```

## Estrutura do projeto:

```
└── 📁lib
    └── 📁app
        └── 📁core
            └── 📁domain
                └── 📁models
                    └── product_model.dart
                └── 📁promotions
                    └── bulk_promotion_entity.dart
                    └── combo_promotion_entity.dart
                    └── free_item_promotion_entity.dart
                └── checkout_entity.dart
                └── discount_entity.dart
                └── product_entity.dart
                └── promotion.dart
            └── 📁failures
                └── failure.dart
                └── product_already_exist_failure.dart
        └── 📁modules
            └── 📁checkout
                └── 📁presentation
                    └── 📁controllers
                        └── checkout_controller.dart
                    └── 📁pages
                        └── checkout_page.dart
                └── checkout_module.dart
            └── 📁home
                └── 📁presentation
                    └── home_page.dart
                └── home_module.dart
            └── 📁products
                └── 📁data
                    └── products_datasource.dart
                    └── products_repository.dart
                └── 📁domain
                    └── 📁repositories
                        └── products_repository.dart
                    └── 📁usecases
                        └── add_product_stock_usecase.dart
                        └── fetch_products_stock_usecase.dart
                        └── remove_product_stock_usecase.dart
                └── 📁presentation
                    └── 📁controllers
                        └── products_controller.dart
                    └── 📁pages
                        └── products_page.dart
                    └── 📁widgets
                        └── add_product_widget.dart
                └── products_module.dart
            └── 📁promotions
                └── 📁data
                    └── promotions_datasource.dart
                    └── promotions_repository.dart
                └── 📁domain
                    └── 📁repositories
                        └── promotions_repository.dart
                    └── 📁usecases
                        └── fetch_promotions_usecase.dart
                └── 📁presentation
                    └── 📁controllers
                        └── promotions_controller.dart
                    └── 📁pages
                        └── promotions_page.dart
                └── promotions_module.dart
        └── 📁utils
            └── custom_inject.dart
            └── custom_navigator.dart
        └── app_module.dart
        └── app_routes.dart
        └── app_widget.dart
    └── main.dart
```
