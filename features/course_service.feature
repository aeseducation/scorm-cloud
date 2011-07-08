Feature: Course Service Interface

	Scenario: A user can import a previously uploaded course
		When I import a course
		Then there should be 1 course in the list
		Then the course should be in the course list

		When I delete the course
		Then there should be 0 courses in the list
		Then the course should not be in the course list

	Scenario: A user can preview a course w/o registration
		When I import a course
		Then I can get a preview URL for the course

	Scenario: A course has properties
		When I import a course
		Then the course will have a properties url
