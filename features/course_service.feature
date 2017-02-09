Feature: Course Service Interface

  Scenario: A user can import a previously uploaded course
    When I import a course
    Then there should be 1 course in the list
    And the course should be in the course list
    And the course should exist
    And I can get a preview URL for the course
    And I can get the manifest for the course
    And I can get the attributes for the course

    When I delete the course
    Then there should be 0 courses in the list
    Then the course should not be in the course list

  Scenario: A user can update course attributes
    When I import a course
    And I update course attributes
    Then the course attributes should be updated

  Scenario: A user can async import a course
    When I import a course asynchronously
    Then the async import result status will be "running"
    And the course will eventually be imported
    And the async import result status will be "finished"
    And the course should exist

  Scenario: A user can not async import a bad course
    When I import a bad course asynchronously
    Then the course will eventually fail to import
    And the async import result status will be "error"

