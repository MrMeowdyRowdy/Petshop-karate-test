Feature: Pet lifecycle tests (create -> get -> update -> find by status)

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def petData = read('classpath:examples/petstore/petData.json')
    * def createPetId =
      """
      function() {
        return java.lang.Math.abs(java.util.UUID.randomUUID().hashCode())
      }
      """
    * def petId = callonce createPetId
    * print 'Using petId: ' + petId

  Scenario: Create a new pet
    # JSON payload as JS object
    * def newPet =
      """
    {  id: #(petId),
    category: { id: 1, name: 'dogs' },
    name: 'doggo-create-test',
    photoUrls: ['https://example.com/photo1.jpg'],
    tags: [ { id: 1, name: 'tag1' } ],
    status: 'available'
    }
    """
    * print 'Creating pet with payload: ' + newPet
    # POST request to create the pet
    Given path 'pet'
    And request newPet
    When method post
    Then status 200

    # Validate the response
    And match response.id == petId
    And match response.name == 'doggo-create-test'
    And match response.status == 'available'

    # Save response for next steps
    * def createdPet = response

  Scenario: Get the pet by ID
    * configure retry = { count: 7, interval: 2000 }
    # Use the same petId from the previous scenario
    Given path 'pet', petId
    And retry until responseStatus == 200
    When method get
    Then status 200

    # Validate the response matches what we created
    And match response.id == petId
    And match response.name == 'doggo-create-test'
    And match response.status == 'available'

  Scenario: Update pet's name and mark as sold
    # Build the updated JSON payload
    print 'Looking for the pet with id: ' + petId
    * def updatedPet =
      """
      {  id: #(petId),
    category: { id: 1, name: 'dogs' },
    name: 'doggo-updated-test',
    photoUrls: ['https://example.com/photo1.jpg'],
    tags: [ { id: 1, name: 'tag1' } ],
    status: 'sold'
    }
      """

    # PUT request to update the pet
    Given path 'pet'
    And request updatedPet
    When method put
    Then status 200

    # Validate the response
    And match response.id == petId
    And match response.name == 'doggo-updated-test'
    And match response.status == 'sold'

    # Save updated response for later steps
    * def updatedPetResponse = response



  Scenario: Get pets by status "sold"
    * configure retry = { count: 7, interval: 2000 }
    # Query pets with status sold
    Given path 'pet', 'findByStatus'
    And param status = 'sold'
    When method get
    Then status 200

    # Validate that our updated pet is in the list
    * def soldPets = response
    * def updatedPet =
      """
      {  id: #(petId),
    category: { id: 1, name: 'dogs' },
    name: 'doggo-updated-test',
    photoUrls: ['https://example.com/photo1.jpg'],
    tags: [ { id: 1, name: 'tag1' } ],
    status: 'sold'
    }
    """
    Then match response contains updatedPet
