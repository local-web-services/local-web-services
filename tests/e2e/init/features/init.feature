@init @controlplane
Feature: LWS init scaffolds agent configuration

  The lws init command writes a CLAUDE.md snippet and custom slash
  commands into a project directory so coding agents understand how
  to use lws.

  @happy
  Scenario: Init creates CLAUDE.md in a new project
    Given an empty project directory was created
    When I run lws init in the project directory
    Then the command will succeed
    And CLAUDE.md will exist in the project directory
    And CLAUDE.md will contain "Local Web Services"

  @happy
  Scenario: Init creates slash commands
    Given an empty project directory was created
    When I run lws init in the project directory
    Then the command will succeed
    And ".claude/commands/lws/mock.md" will exist in the project directory
    And ".claude/commands/lws/chaos.md" will exist in the project directory

  @happy
  Scenario: Init appends to existing CLAUDE.md
    Given an empty project directory was created
    And CLAUDE.md with content "# My Project" was created in the project directory
    When I run lws init in the project directory
    Then the command will succeed
    And CLAUDE.md will contain "# My Project"
    And CLAUDE.md will contain "Local Web Services"

  @happy
  Scenario: Init is idempotent
    Given an empty project directory was created
    And lws init was already run in the project directory
    When I run lws init in the project directory
    Then the command will succeed
    And CLAUDE.md will contain exactly 1 occurrence of "LWS:START"
