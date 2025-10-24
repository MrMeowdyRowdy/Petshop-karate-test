# 🧪 Petstore API Test — Conclusions and Observations

## Overview
Automated API testing was performed using **Karate** against the public endpoint [Petstore Swagger API](https://petstore.swagger.io/v2).  
The scenarios validated key operations:
- Adding a new pet
- Retrieving it by ID
- Updating its details and status
- Querying by status

These tests were organized under a Karate-based JUnit5 suite with Cucumber-style reporting.

---

## General Results
- Most runs completed **successfully**.
- Functional workflows (`Add → Get → Update → Find`) executed as expected.
- Tests now use **retries with cooldowns**, significantly improving stability.

---

## Identified Issues and Fixes

### 1. Latency between creation/update and retrieval
**Observation:**  
A slight delay occurs between when a pet is created or updated and when it becomes retrievable via `/pet/{id}` or `/pet/findByStatus`.

**Effect:**  
The GET and FIND operations sometimes failed even when the creation had succeeded, returning intermittent `404` responses. And in the case of find by status the test may fail due to Karate not being able to match the updated pet in the results.

**Fix Implemented:**  
Introduced **retry logic with cooldowns** (`karate.delay()` and `retry until` patterns).  
This ensures tests wait for data propagation before validation, stabilizing the suite across runs.

---

### 2. Lack of automatic ID generation
**Observation:**  
The Petstore API does **not generate pet IDs automatically**.  
The client must provide a unique `id` field when creating a pet.

**Effect:**  
Randomly generated IDs occasionally **collided** with existing ones.  
The API responded with HTTP `200` instead of a clear error, even though the insertion failed silently.

**Fix Implemented:**  
IDs are now generated using a UUID-based hash, ensuring a more random and less collision-prone value.  
However, this is a **limitation of the API itself**, and sometimes you will encounter a failed test due to the generated ID colliding with an existent one.

---

## Final Notes
- The implemented **retry mechanism** mitigates most false negatives.
- The **Cucumber HTML reports** now reflect accurate pass/fail results after mitigation.

---

## 🧾 Summary Table

| Category | Observation | Fix | Status       |
|-----------|--------------|-----|--------------|
| Data propagation delay | Latency between creation and retrieval | Added retries with cooldown | Mitigated    |
| ID management | No auto-generated IDs; collisions possible | Timestamp-based ID generator | Mitigated    |
| Error handling | 200 response even on failed creation | Not fixable client-side | API Limitation |

