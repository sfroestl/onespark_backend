Feature: Project API
  # Background:
  #   Given the following users exist:
  #     | id | username | email |
  #     | 1  | Steve      | Richert   |
  #     | 2  | Catie      | Richert   |


  Scenario: Index action
    When I send a GET request to "/api/v1/projects.json"
    Then the JSON response should have 1 projects
    Then the JSON response at "title" should be "Testproject"


    # Given I post to "/api/v1/users.json" with:
    #   """
    #   {
    #     "username": "steve",
    #     "email": "steve@test.de"
    #   }
    #   """
    # And I keep the JSON response at "id" as "USER_ID"
    # When I get "/api/v1/users.json"
    # Then the JSON response should have 1 user
    # And the JSON response at "0" should be:
    #   """
    #   {
    #     "id": %{USER_ID},
    #     "username": "steve",
    #     "email": "steve@test.de"
    #   }
    #   """