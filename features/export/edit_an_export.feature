@javascript
Feature: Edit an export
  In order to manage existing export jobs
  As an administrator
  I need to be able to edit an export job

  Background:
    Given a "footwear" catalog configuration
    And I am logged in as "Peter"

  Scenario: Successfully edit an export job
    Given I am on the "csv_footwear_product_export" export job edit page
    Then I should see the Code field
    And the field Code should be disabled
    When I fill in the following information:
      | Label | My export |
    And I press the "Save" button
    Then I should see "My export"

  Scenario: Successfully update export job configuration
    Given I am on the "csv_footwear_product_export" export job edit page
    Then I should see the Delimiter, Enclosure, With header, File path and Decimal separator fields
    And I fill in the following information:
      | Delimiter         | \|         |
      | Enclosure         | '          |
      | File path         | file.csv   |
      | Decimal separator | ,          |
      | Date format       | yyyy-MM-dd |
    And I uncheck the "With header" switch
    When I visit the "Content" tab
    Then I should see the Channel, Status, Completeness, Family, Locales fields
    And I fill in the following information:
      | Channel      | Tablet                               |
      | Status       | Disabled                             |
      | Family       | Boots                                |
      | Completeness | Not complete on all selected locales |
    When I press the "Save" button
    Then I should see the text "File path file.csv"
    And I should see the text "Delimiter |"
    And I should see the text "Enclosure '"
    And I should see the text "With header No"
    And I should see the text "Decimal Separator comma (,)"
    And I should see the text "Date format yyyy-MM-dd"
    When I visit the "Content" tab
    Then I should see the text "Channel tablet"
    And I should see the text "Status disabled"
    And I should see the text "en_US"
    And I should see the text "Boots"
    And I should see the text "Not complete on all selected locales"

  Scenario: Successfully display a dialog when we quit a page with unsaved changes
    Given I am on the "csv_footwear_product_export" export job edit page
    When I fill in the following information:
      | Label | My export |
    When I click on the Akeneo logo
    Then I should see a confirm dialog with the following content:
      | title   | Are you sure you want to leave this page?                           |
      | content | You will lose changes to the export profile if you leave this page. |

  @skip
  Scenario: Successfully display a message when there are unsaved changes
    Given I am on the "csv_footwear_product_export" export job edit page
    When I fill in the following information:
      | Label | My export |
    Then I should see "There are unsaved changes."
