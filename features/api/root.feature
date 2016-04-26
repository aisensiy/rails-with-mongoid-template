Feature: API

  Scenario: Get root path
    When I send and accept JSON
    And I send a GET request to "/productions/index"
    Then the response status should be "200"
