# DogImageLibrary

![Dog Image](https://images.dog.ceo/breeds/leonberg/n02111129_2785.jpg)

> A Swift library to fetch and display random dog images from the Dog CEO's Dog API.

## Introduction

DogImageLibrary is a lightweight Swift library that provides an easy way to fetch random dog images from the Dog CEO's Dog API. It's designed to be simple and straightforward, making it easy to integrate into your iOS applications.

## Installation

### Prerequisites

- Xcode 12 or later
- Swift 5.3 or later

### Adding to Your Project

You can integrate DogImageLibrary into your project using Swift Package Manager (SPM).

1. **Using Swift Package Manager:**

    In Xcode, select `File` > `Add Packages`, and enter the repository URL:

    ```
    https://github.com/Sachin-commit/MyDogImagePackageLibrary.git
    ```

2. **Manual Integration:**

    Clone the repository and include the files in your project.

    ```sh
    git clone https://github.com/Sachin-commit/MyDogImagePackageLibrary.git
    ```

## Usage

To use DogImageLibrary in your project, you need to initialize the library and fetch dog images. Below are examples of how to use the main features.

### Fetching Dog Images

```swift
import DogImageLibrary

// Initialize the library
let dogImageLibrary = DogImageLibrary()

// Fetch and print the first dog image URL
if let firstImage = dogImageLibrary.getImage() {
    print("First image: \(firstImage)")
}

// Fetch and print the first 5 dog images
let images = dogImageLibrary.getImages(number: 5)
print("First 5 images: \(images)")
