# Karate API Test Project

## Overview

This project contains automated API tests using **Karate** for testing the Petstore API. The tests cover scenarios like creating pets, updating them, and querying pets by status (in this case `sold`).

The tests are designed to be **repeatable**, **robust**, and easy to run locally.

---

## Prerequisites

* Java 17 or higher
* Maven 3.9.X (for dependency management, 3.9.9 used here)
* IntelliJ
* Internet connection

---

## Project StructureS

```
src/
 └─ test/
     └─ java/
         └─ features/
             ├─ CreatePet.feature
             ├─ UpdatePet.feature
             ├─ GetPetsByStatus.feature
             └─ ...
karate-config.js      # Base configuration
pom.xml               # Maven dependencies
```

---

## Installing Dependencies

The project uses Maven for dependency management. Run:

```bash
mvn clean install
```

This will download all necessary Karate dependencies.

---

## Running Tests

You can run tests using Maven or directly in your IDE.

### Run all tests via Maven:

```bash
mvn test
```

### Run a specific feature:

```bash
mvn test -Dkarate.options="--tags @smoke"
```

### Run via IntelliJ:

1. Right-click the `.feature` file.
2. Select `Run 'Feature: <filename>'`.

---

## Test Results

After running tests, Karate will generate HTML and JSON reports locally. By default, results are stored in:

```
target/surefire-reports/
```

Example files:

* `karate-summary.html` – Full test report
* `karate-summary.json` – JSON output
* `*.txt` – Logs for each scenario

You can open the HTML report in a browser to see detailed test results.

---

## Tips for Reliable Tests

* Avoid hardcoding IDs; let the API generate them or use UUIDs.
* Match only relevant fields when validating responses (e.g., `name`, `status`) to avoid failures from extra fields added by the API.
* Use `karate.log(response)` in your scenarios to debug API responses.

---



