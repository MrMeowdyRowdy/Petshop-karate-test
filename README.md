# Karate Petstore API Tests

## Project Overview

This repository contains a **Karate-based API test suite** for the [Swagger Petstore](https://petstore.swagger.io/) service.
The suite exercises the main lifecycle for a pet resource:

1. Create a new pet.
2. Update the pet's attributes.
3. Retrieve pets filtered by status (e.g., `sold`).

---

## Prerequisites

* Java 17
* Maven 3.9.x
* Chrome browser (for viewing HTML reports)
* Internet connection
* IntelliJ IDEA (recommended IDE)

---

## Project Structure

```
src
├── main
└── test
    ├── java/examples/petstore/             # Karate JUnit runner (PetRunner)
    └── resources/examples/petstore/        # Karate feature files (pet.feature)
```

Additional project files of interest:

* `pom.xml` – Maven dependencies and build configuration

---

## Setup & Dependencies

Maven handles dependency resolution. The first build downloads all required Karate artifacts automatically. No extra setup is needed beyond installing the prerequisites.

---

## How to Run the Tests

### Run from IntelliJ IDEA (recommended)

1. Open the project in IntelliJ IDEA.
2. Open the **Maven** tool window (usually on the right-hand side).
3. Under the project, expand **Lifecycle** and double-click **verify**.
   * This runs `mvn clean verify` using the integrated Maven runner.
4. Alternatively, right-click `PetRunner` or a `.feature` file and select **Run** for an ad-hoc execution.

### Run from a terminal

```bash
mvn clean verify
```

The `verify` phase compiles the project, executes the Karate scenarios, and produces the reports.

---

## Test Results & Reports

Karate generates both summary and detailed Cucumber-style HTML reports inside the `target` directory.

* Summary: `target/karate-reports/karate-summary.html`
* Cucumber HTML reports: `target/cucumber-html-reports/`

To view the Cucumber report:

1. Open the project `target` folder after a test run.
2. Navigate to `cucumber-html-reports`.
3. Locate a file named `report-feature_XXXXXXXXXXX.html`.
4. Open it in a browser (double-click or drag the file into a browser window) to inspect the scenario breakdown and results.

---

## Helpful Tips

* Avoid hard-coded identifiers—prefer dynamically generated values or data returned by the API.
* Log responses with `karate.log()` while authoring new scenarios to aid debugging.
* Keep assertions focused on business-relevant fields so the tests remain stable if the API adds new properties.

