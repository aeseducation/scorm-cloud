Feature: Upload Service Interface

	Scenario: Upload a course

		When I upload a package
		Then the package files should be available

		When I delete the package
		Then the package files should not be available
