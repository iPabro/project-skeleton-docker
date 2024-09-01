Feature: Not Found page

  Scenario: Not Found page
    Given I am a guest user
    When I open "/not-found" page
    Then I see "Ошиблись? Такой страницы нет, но Вы можете поискать номер"
