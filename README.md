# 💸 Flutter Riverpod Transactions App

A simple Flutter app that demonstrates state management using [Riverpod](https://riverpod.dev). This app displays a list of mock financial transactions and allows users to filter them by status (All, Successful, Pending, Failed). It includes smooth list animations and fallback UI when no transactions are found.

---

## 📲 Features

- ✅ Riverpod for scalable state management
- ✅ Dynamic transaction filtering using horizontal `ChoiceChip`s
- ✅ Fade + slide-in animation for each transaction item
- ✅ Fallback UI for empty transaction states
- ✅ Counter demo using `StateProvider`
- ✅ Clean architecture with providers, models, and screens

---

## 🧠 State Management Overview

| Provider | Description |
|---------|-------------|
| `counterProvider` | Manages counter state with `StateProvider<int>` |
| `filterProvider` | Tracks currently selected filter (`FilterOption`) |
| `transactionListProvider` | Provides list of static mock transactions |
| `filteredTransactionsProvider` | Filters transactions based on selected `filterProvider` value |

All providers are declared and exported via `pods/index.dart`.


### Test Transactions
TransactionModel(id: '1', amount: 100, status: TransactionStatus.successful)
TransactionModel(id: '2', amount: 250, status: TransactionStatus.failed)
TransactionModel(id: '3', amount: 80,  status: TransactionStatus.pending)
TransactionModel(id: '4', amount: 400, status: TransactionStatus.successful)
TransactionModel(id: '5', amount: 150, status: TransactionStatus.pending)


---

## 🏗 Folder Structure
lib/
├── core/
│ └── models/
│ └── transaction_model.dart # Defines TransactionModel & enums
│
├── pods/
│ └── index.dart # Riverpod providers for filter, transactions, counter
│
├── screens/
│ └── home_screen.dart # Main UI: filter, list, counter, animations
│
├── main.dart # App entry point wrapped with ProviderScope


## 🚀 Getting Started

### ✅ Prerequisites
- Flutter SDK (>=3.x)
- Dart enabled IDE (e.g. VSCode or Android Studio)

### 📦 Install dependencies

```bash
flutter pub get


