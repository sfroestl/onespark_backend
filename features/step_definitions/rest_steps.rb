  When /^I send a GET request to "([^\"]*)"$/ do |url|
    # authorize("bob", "testbob")

    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    get url
  end

# Then /^I should receive the following JSON response:$/ do |expected_json|
#   expected_json = JSON.parse(expected_json)
#   response_json = JSON.parse(last_response.body)

#   response_json.should == expected_json
# end