Feature: lblcd
  bundle exec cucumber features/

  @announce
  Scenario: Run
    When I run `lglcd`
    Then the output should contain "Display name: Logitech Monochrome LCD"
