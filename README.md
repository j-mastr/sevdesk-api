# Unofficial SevDesk API Documentation

Welcome to the unofficial sevdesk API Documentation! This project aims to provide a stable yet up-to-date and comprehensible OpenAPI specification based on the [official OpenAPI specs](https://api.sevdesk.de/). Here, you'll find all the necessary information to interact with the sevdesk API efficiently.

## Objective

The primary goal of this project is to maintain an accurate and reliable OpenAPI specification for the sevdesk API. The official API documentation is sometimes inaccurate, frequently updated and the updates are poorly communicated, making it difficult to use as an accurate and complete reference. This project will document discrepancies between the official specification and the actual API while tracking changes in the official specification.

## Project Structure

- **`external/openapi.yaml`**: This file contains [the official OpenAPI specification](https://api.sevdesk.de/openapi.yaml) as provided by sevdesk. It is frequently updated during release to reflect the most recent API changes and stays stable in between.
- **`openapi.yaml`**: This is the stable OpenAPI specification. It is adapted with community-provided changes to address any known deviations from the actual specs. This file is periodically updated during releases to ensure compatibility and accuracy.

## SDK Generation

One of the primary use cases for this repository is generating SDKs (Software Development Kits) for various programming languages. By using the provided `openapi.yaml` specifications, developers can easily generate SDKs tailored to their preferred programming language e.g. using the [OpenAPI generator](https://openapi-generator.tech/).

### Available SDKs

Feel free to open a pull request to add your SDK to the list.

| SDK / Language | Maintainer                      | Repository                                                       |
| -------------- | ------------------------------- | ---------------------------------------------------------------- |
| PHP SDK        | it's mind <support@itsmind.com> | [sevdesk-php-sdk](https://github.com/itsmindcom/sevdesk-php-sdk) |

## Contributing

This project lives from the power as a community and contributions are highly encouraged! If you discover any discrepancies in the provided OpenAPI specifications or have suggestions for improvements, please feel free to open an issue or submit a pull request. Your contributions will help ensure the accuracy and effectiveness of the sevdesk API documentation for the entire community.

## Disclaimer

Please note that this repository is not affiliated with or endorsed by sevdesk. While we strive to provide accurate and up-to-date information, use the provided OpenAPI specifications and SDKs at your own risk. Always refer to the official sevdesk documentation and guidelines for mission-critical applications.

## Contact

For any inquiries or assistance regarding this repository, feel free to open an issue.

Thank you for using the unofficial sevdesk API Documentation! We hope it proves to be a valuable resource for your development endeavors.
