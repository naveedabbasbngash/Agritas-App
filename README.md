# Agritas Flutter App

This project is a Flutter application developed using the MVVM (Model-View-ViewModel) architecture. It demonstrates a real-world implementation for managing agricultural products.

## Project Overview

The Agritas Flutter App allows users to view and manage a list of agricultural products categorized under various categories like Fungicide, Herbicide, etc. It includes features such as offline caching, API integration, and image caching for efficient performance.

## Project Structure

The project follows the MVVM architecture, dividing the code into logical layers:


├── main.dart # Entry point of the application
├── models # Data models representing the application entities
│ ├── product.dart # Defines the Product data model
│ └── category.dart # Defines the Category data model
├── viewmodels # Manages data and business logic
│ └── product_viewmodel.dart # Product ViewModel
├── views # UI components of the application
│ ├── product_list_view.dart # Displays a list of products
│ └── product_details_view.dart # Displays details of a single product
├── services # API and data services
│ └── product_api.dart # Handles API interactions for products
└── utils # Utility classes and functions
├── local_storage.dart # Manages local storage for offline support
├── custom_widgets.dart # Contains reusable widgets
├── app_utils.dart # General utility functions
└── validation.dart # Validation functions


## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

- **Flutter SDK**: [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Android Studio** or **Visual Studio Code** for development.

### Installation

1. **Clone the repository**:
   ```bash
   git clone git@github.com:naveedabbasbngsh/Agritas-App.git
