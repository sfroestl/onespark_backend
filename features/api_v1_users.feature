Feature: User API

  Background:
  Given the following user exists:
  | username    | email           |
  | Brandon | brandon@example.com |

  Scenario: Index action
    When I send a GET request to "/api/v1/user.json"
    Then the JSON response should have 1 user
    Then the JSON response at "username" should be "Brandon"


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