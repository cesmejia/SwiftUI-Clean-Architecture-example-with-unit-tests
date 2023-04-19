# SwiftUI-Clean-Architecture-example-with-unit-tests

This is a small project that gets a TODO list from the network, stores it with Filemanager and shows it in a SwiftUI list.

## Overview

The project was developed with the following concepts in mind:

- ``No external libraries``
- ``SOLID principles``
- ``Clean Architecture``
- ``MVVM Architecture``
- ``Used of Composition root``
- ``Coordinator Pattern: Uses UIKit UINavigationController + UIHostingController for navigation``
- ``Factory Pattern``
- ``Repository Pattern``
- ``Use Cases``
- ``Async Await + Result APIs``
- ``Dependency Injection``
- ``Unit tests: Although TDD was not used, tests were created after each instance creation``
- ``Test doubles: Use of Stubs, Spys and Mocks``
- ``Test for memory leaks``
- ``Folder separation: Domain, Data, Presentation and Framework``

### Dependency Diagram:

![Clean MVVM SwiftUI](https://user-images.githubusercontent.com/24886388/233205119-4adca89b-adbc-4ed6-a927-2c0be4b481ef.jpg)

### Dislaimer:

This is a very basic project to serve as guide for a tested Clean Architecture approach with SwiftUI.

- Feedback is welcomed.
- I might add some more use cases and features in the near future.
- TODO entity was used throughout the app for simplification sake. True modularity would be achieved by mapping it between layers.

### Useful resources that made this possible:

- Essential developer course: [Essential Developer](https://www.essentialdeveloper.com)
- Hacking with swift: [HWS](https://www.hackingwithswift.com)
- Clean Mobile Architecture Book by Petros Efthymiou: [Clean Mobile Architecture](https://www.petrosefthymiou.com/product-page/clean-mobile-architecture)
- Dependency Injection Principles, Practices, and Patterns by Mark Seemann and Steven van Deursen [Dependency Injection](https://www.goodreads.com/en/book/show/44416307-dependency-injection-principles-practices-and-patterns)
- Clean Architecture Book by Robert C. Martin (Uncle Bob) [Clean Architecture](https://www.goodreads.com/book/show/18043011-clean-architecture?ref=nav_sb_ss_1_11)
