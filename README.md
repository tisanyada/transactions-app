# KobiPay Transaction App

A Flutter application for managing and viewing transactions with features like filtering, refunding, and detailed transaction views.

## Setup Instructions

1. **Prerequisites**

    - Flutter SDK (3.5.3 or later)
    - Dart SDK (3.0.0 or later)
    - A code editor (VS Code, Android Studio, etc.)

2. **Installation**

    ```bash
    # Clone the repository
    git clone [repository-url]

    # Navigate to project directory
    cd kobipay

    # Install dependencies
    flutter pub get

    # Run the app
    flutter run
    ```

## Libraries Used

-   **flutter_riverpod**: ^2.6.1

    -   State management solution
    -   Provides reactive and provider-based state management

-   **intl**: ^0.19.0
    -   Internationalization and formatting
    -   Used for date and currency formatting

## Design and State Management Decisions

### Architecture

-   **Repository Pattern**

    -   Clear separation of data layer
    -   Easy to switch between mock and real API
    -   Located in `lib/pods/transaction_repo.dart`

-   **Controller Pattern**
    -   Business logic handling
    -   State management with Riverpod
    -   Located in `lib/pods/transaction_controller.dart`

### State Management

-   Using **Riverpod** for:
    -   Dependency injection
    -   State management
    -   Async data handling
    -   Filter state management

### UI Components

-   **Screens**

    -   Home Screen: List of transactions with filters
    -   Transaction Detail Screen: Detailed view with refund capability

-   **Widgets**
    -   Custom transaction card
    -   Filter chips
    -   Animated list items
    -   Status indicators with color coding

### Features

1. **Transaction Filtering**

    - All transactions
    - This month's transactions
    - Last month's transactions

2. **Transaction Management**

    - View transaction details
    - Process refunds
    - Status tracking

3. **UI/UX**
    - Pull-to-refresh
    - Loading states
    - Error handling
    - Success/error feedback
    - Smooth animations

## API Simulation

The app currently simulates API behavior using local JSON data:

1. **Data Storage**

    - Transactions are stored in `assets/transactions.json`
    - Structured to mimic real API responses

2. **API Operations**

    - `getTransactions()`: Reads from local JSON file
    - `refundTransaction()`: Simulates network delay with Future.delayed
    - All operations return Futures to mimic async API calls

3. **Error Handling**

    - Simulates network and processing errors
    - Provides realistic error messages
    - Handles loading and error states

4. **Future Real API Integration**
    - Repository pattern makes it easy to switch to real API
    - Just update the repository methods with actual API calls
    - No changes needed in UI or business logic

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

# VIDEO URL

- Video Url: https://www.awesomescreenshot.com/video/42842367?key=164827829eca4d901917e1d86ad11a1e