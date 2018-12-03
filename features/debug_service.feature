Feature: Debug Service Interface

  Scenario: Debug Services Function

    When I ping the server
    Then the response should be "pong"

    When I authping the server
    Then the response should be "pong"

    When I get the current time
    Then the resonse should be the current time
