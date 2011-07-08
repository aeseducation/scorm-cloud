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
