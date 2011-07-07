@apibug
Feature: API Bugs and Questions

	Scenario: Deleting a non-existant package should return an error
	in this case it seems to return deleted=true even when the file
	does not exist

		When I delete a non-existant package
		Then I should get an error
