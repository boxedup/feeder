Feature: Pull and parse feeds
  In order to increase possible product matches
  I want to pull product feeds and parse the products out of them

  Scenario: Successfully pulling a Tradedoubler feed
    Given I have a valid Tradedoubler url
    When I fetch that feed
    Then when I parse it I should have fetched a valid xml file
  
  Scenario: Successfully parsing a large Tradedoubler feed
    Given I have a valid large Tradedoubler feed
    And I have valid Tradedoubler element mappings
    When I parse that feed
    Then I should have multiple products
    And those products should be valid
  
  Scenario: Successfully parsing a small Tradedoubler Quality feed
    Given I have a valid small TradedoublerQuality feed
    And I have valid Tradedoubler element mappings
    When I parse that feed
    Then I should have multiple products
    And those products should be valid

  Scenario: Successfully pulling a dgmpro feed
    Given I have a valid dgmpro url
    When I fetch that feed
    Then when I parse it I should have fetched a valid xml file

  Scenario: Successfully parsing a dgmpro feed
    Given I have a valid small dgmpro feed
    And I have valid dgmpro element mappings
    When I parse that feed
    Then I should have multiple products
    And those products should be valid

  Scenario: Successfully pulling an affiliatewindow feed
    Given I have a valid affiliatewindow url
    When I fetch that feed
    Then when I parse it I should have fetched a valid xml file

  Scenario: Successfully parsing an affiliatewindow feed
    Given I have a valid small affiliatewindow feed
    And I have valid affiliatewindow element mappings
    When I parse that feed
    Then I should have multiple products
    And those products should be valid