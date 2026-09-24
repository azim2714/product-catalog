# Product Catalog

A Flutter product catalog app built using the DummyJSON API.

## Features

* Product listing with title, thumbnail, and price
* Product listing with pagination triggered by scrolling
* Product detail page with description, price, rating, and images
* Debounced product search
* Loading, error, empty, and success states
* Retry on API errors
* Pull-to-refresh
* Image loading and error handling
* Unit test for product model parsing

## Tech Stack

* Flutter/Dart
* Provider - state management
* Dio - HTTP client
* Cached Network Image - image caching and loading states
* DummyJSON - product API

## Architecture

The project uses a layered architecture with separate presentation, data, and networking responsibilities.

```text
lib/
  core/
    network/
      api_client.dart

  data/
    models/
      product_model.dart
    repositories/
      product_repository.dart
    services/
      product_api_service.dart

  presentation/
    providers/
      view_state.dart
      product_list_provider.dart
      product_detail_provider.dart
    screens/
      product_list_screen.dart
      product_detail_screen.dart
    widgets/
      product_card.dart

  main.dart
```

### Data Flow

```text
UI -> Provider -> Repository -> API Service -> Dio/API
```

The repository handles data mapping between API responses and application models, while providers manage UI state and user interactions.

## Search

Search uses DummyJSON's `/products/search` endpoint rather than filtering only the currently loaded products.

Search input is debounced to avoid making an API request for every keystroke.

Search results are not paginated in this implementation.

## Pagination

The product list initially loads 20 products and requests the next 20 products when the user approaches the bottom of the list.

Pagination is disabled while searching.

## Running the Project

Make sure Flutter is installed and configured, then run:

```bash
flutter pub get
flutter run
```
To run the unit tests:

```bash
flutter test
```
## Unfinished / Possible Improvements

The core assignment requirements are implemented. With more time, the following could be added:

* Improved pagination error feedback
* More robust API error handling and typed exceptions
* Additional accessibility and UI polish
* Dependency injection for easier testing
* Pagination support for search results
* More comprehensive unit and widget tests