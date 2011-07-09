Feature: Registration Service

	Background: Setup a course
		Given a registered course

	Scenario: Register a learner

		When I register a learner
		Then the learner should be in the registration list
		And I can get the registration results

		When I launch the course
		Then I will get a valid url

		When I reset the registration
		Then the learner should be in the registration list
		And I can get the registration results

		When I delete the registration
		Then the learner should not be in the registration list

