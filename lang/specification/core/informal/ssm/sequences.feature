@ssm @generated
Feature: Ssm - Action Sequences

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "ssm" "parameter" is stored then an existing "ssm" "parameter" value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then a "ssm" "parameter" is retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then multiple "ssm" "parameter"s are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then "ssm" "parameter"s under a path are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then "ssm" "parameter"s are described
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then a "ssm" "parameter" is deleted
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then multiple "ssm" "parameter"s are deleted
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then tags are added to a "ssm" "parameter"
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then tags are removed from a "ssm" "parameter"
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then tags for a "ssm" "parameter" are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is stored
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then "ssm" "parameter"s are described
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is stored
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then a "ssm" "parameter" is stored
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is stored
    When multiple "ssm" "parameter"s are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then an existing "ssm" "parameter" value is updated
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is retrieved
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then "ssm" "parameter"s under a path are retrieved
    When multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then "ssm" "parameter"s are described
    When multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is deleted
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then multiple "ssm" "parameter"s are deleted
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then tags are added to a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then tags are removed from a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then tags for a "ssm" "parameter" are listed
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is stored
    When "ssm" "parameter"s under a path are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is written without overwrite when it already exists
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s under a path are retrieved
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then "ssm" "parameter"s are described
    When "ssm" "parameter"s under a path are retrieved
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is deleted
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then multiple "ssm" "parameter"s are deleted
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then a "ssm" "parameter" is stored
    When "ssm" "parameter"s are described
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then a "ssm" "parameter" is written without overwrite when it already exists
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s are described
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then "ssm" "parameter"s under a path are retrieved
    When "ssm" "parameter"s are described
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then a "ssm" "parameter" is deleted
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then multiple "ssm" "parameter"s are deleted
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is stored
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is stored
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then "ssm" "parameter"s are described
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then a "ssm" "parameter" is stored
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then "ssm" "parameter"s are described
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is stored
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then "ssm" "parameter"s are described
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is stored
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then "ssm" "parameter"s are described
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then a "ssm" "parameter" is retrieved then multiple "ssm" "parameter"s are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is retrieved
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then multiple "ssm" "parameter"s are retrieved then "ssm" "parameter"s under a path are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then "ssm" "parameter"s under a path are retrieved then "ssm" "parameter"s are described
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When "ssm" "parameter"s under a path are retrieved
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then "ssm" "parameter"s are described then a "ssm" "parameter" is deleted
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When "ssm" "parameter"s are described
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then a "ssm" "parameter" is deleted then multiple "ssm" "parameter"s are deleted
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is deleted
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then multiple "ssm" "parameter"s are deleted then tags are added to a "ssm" "parameter"
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When multiple "ssm" "parameter"s are deleted
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then tags are added to a "ssm" "parameter" then tags are removed from a "ssm" "parameter"
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When tags are added to a "ssm" "parameter"
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then tags are removed from a "ssm" "parameter" then tags for a "ssm" "parameter" are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When tags are removed from a "ssm" "parameter"
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is stored then tags for a "ssm" "parameter" are listed then an existing "ssm" "parameter" value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When tags for a "ssm" "parameter" are listed
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is stored then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is written without overwrite when it already exists then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is retrieved then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then multiple "ssm" "parameter"s are retrieved then "ssm" "parameter"s are described
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s under a path are retrieved
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then "ssm" "parameter"s are described then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s are described
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is deleted then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is deleted
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then multiple "ssm" "parameter"s are deleted then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When multiple "ssm" "parameter"s are deleted
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then tags are added to a "ssm" "parameter" then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When tags are added to a "ssm" "parameter"
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is stored
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: an existing "ssm" "parameter" value is updated then tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is stored then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is stored
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then an existing "ssm" "parameter" value is updated then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is retrieved then "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are retrieved
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then "ssm" "parameter"s under a path are retrieved then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When "ssm" "parameter"s under a path are retrieved
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then "ssm" "parameter"s are described then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When "ssm" "parameter"s are described
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is deleted then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is deleted
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then multiple "ssm" "parameter"s are deleted then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are deleted
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then tags are added to a "ssm" "parameter" then a "ssm" "parameter" is stored
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then tags are removed from a "ssm" "parameter" then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags are removed from a "ssm" "parameter"
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists then tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then a "ssm" "parameter" is stored then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When a "ssm" "parameter" is stored
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then an existing "ssm" "parameter" value is updated then "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then multiple "ssm" "parameter"s are retrieved then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When multiple "ssm" "parameter"s are retrieved
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then "ssm" "parameter"s under a path are retrieved then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s under a path are retrieved
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then "ssm" "parameter"s are described then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s are described
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then a "ssm" "parameter" is deleted then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When a "ssm" "parameter" is deleted
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is stored
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then tags are added to a "ssm" "parameter" then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags are added to a "ssm" "parameter"
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is retrieved then tags for a "ssm" "parameter" are listed then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags for a "ssm" "parameter" are listed
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is stored then "ssm" "parameter"s are described
    When multiple "ssm" "parameter"s are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is deleted
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is written without overwrite when it already exists then multiple "ssm" "parameter"s are deleted
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is retrieved then tags are added to a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then "ssm" "parameter"s under a path are retrieved then tags are removed from a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then "ssm" "parameter"s are described then tags for a "ssm" "parameter" are listed
    When multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is deleted then a "ssm" "parameter" is stored
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then multiple "ssm" "parameter"s are deleted then an existing "ssm" "parameter" value is updated
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then tags are added to a "ssm" "parameter" then a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is retrieved
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are retrieved then tags for a "ssm" "parameter" are listed then "ssm" "parameter"s under a path are retrieved
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is stored then a "ssm" "parameter" is deleted
    When "ssm" "parameter"s under a path are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then an existing "ssm" "parameter" value is updated then multiple "ssm" "parameter"s are deleted
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is written without overwrite when it already exists then tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is retrieved then tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then multiple "ssm" "parameter"s are retrieved then tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s under a path are retrieved
    When multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then "ssm" "parameter"s are described then a "ssm" "parameter" is stored
    When "ssm" "parameter"s under a path are retrieved
    When "ssm" "parameter"s are described
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is deleted then an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is written without overwrite when it already exists
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then tags are added to a "ssm" "parameter" then a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then tags are removed from a "ssm" "parameter" then multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s under a path are retrieved then tags for a "ssm" "parameter" are listed then "ssm" "parameter"s are described
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then a "ssm" "parameter" is stored then multiple "ssm" "parameter"s are deleted
    When "ssm" "parameter"s are described
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then an existing "ssm" "parameter" value is updated then tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then a "ssm" "parameter" is written without overwrite when it already exists then tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then a "ssm" "parameter" is retrieved then tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is retrieved
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is stored
    When "ssm" "parameter"s are described
    When multiple "ssm" "parameter"s are retrieved
    Given pname not in param_exists or param_exists[pname] is False
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then "ssm" "parameter"s under a path are retrieved then an existing "ssm" "parameter" value is updated
    When "ssm" "parameter"s are described
    When "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then a "ssm" "parameter" is deleted then a "ssm" "parameter" is written without overwrite when it already exists
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then tags are added to a "ssm" "parameter" then multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then tags are removed from a "ssm" "parameter" then "ssm" "parameter"s under a path are retrieved
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: "ssm" "parameter"s are described then tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is deleted
    When "ssm" "parameter"s are described
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is stored then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is stored
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then an existing "ssm" "parameter" value is updated then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When an existing "ssm" "parameter" value is updated
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is written without overwrite when it already exists then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is written without overwrite when it already exists
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then a "ssm" "parameter" is retrieved then a "ssm" "parameter" is stored
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When a "ssm" "parameter" is retrieved
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then multiple "ssm" "parameter"s are retrieved then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When multiple "ssm" "parameter"s are retrieved
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When "ssm" "parameter"s under a path are retrieved
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then "ssm" "parameter"s are described then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When "ssm" "parameter"s are described
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then multiple "ssm" "parameter"s are deleted then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When multiple "ssm" "parameter"s are deleted
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then tags are added to a "ssm" "parameter" then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then tags are removed from a "ssm" "parameter" then "ssm" "parameter"s are described
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: a "ssm" "parameter" is deleted then tags for a "ssm" "parameter" are listed then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When a "ssm" "parameter" is deleted
    When tags for a "ssm" "parameter" are listed
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is stored then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is stored
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then an existing "ssm" "parameter" value is updated then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When an existing "ssm" "parameter" value is updated
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is stored
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is retrieved then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is retrieved
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When multiple "ssm" "parameter"s are retrieved
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When "ssm" "parameter"s under a path are retrieved
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then "ssm" "parameter"s are described then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When "ssm" "parameter"s are described
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is deleted then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is deleted
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then tags are added to a "ssm" "parameter" then "ssm" "parameter"s are described
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: multiple "ssm" "parameter"s are deleted then tags for a "ssm" "parameter" are listed then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When multiple "ssm" "parameter"s are deleted
    When tags for a "ssm" "parameter" are listed
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then a "ssm" "parameter" is stored then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is stored
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is stored
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then a "ssm" "parameter" is written without overwrite when it already exists then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is written without overwrite when it already exists
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then a "ssm" "parameter" is retrieved then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is retrieved
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then multiple "ssm" "parameter"s are retrieved then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then "ssm" "parameter"s under a path are retrieved then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then "ssm" "parameter"s are described then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When "ssm" "parameter"s are described
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then a "ssm" "parameter" is deleted then "ssm" "parameter"s are described
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is deleted
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then multiple "ssm" "parameter"s are deleted then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When multiple "ssm" "parameter"s are deleted
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then tags are removed from a "ssm" "parameter" then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When tags are removed from a "ssm" "parameter"
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are added to a "ssm" "parameter" then tags for a "ssm" "parameter" are listed then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When tags are added to a "ssm" "parameter"
    When tags for a "ssm" "parameter" are listed
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is stored then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is stored
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is written without overwrite when it already exists then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is written without overwrite when it already exists
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is retrieved then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is retrieved
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then multiple "ssm" "parameter"s are retrieved then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then "ssm" "parameter"s under a path are retrieved then "ssm" "parameter"s are described
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s under a path are retrieved
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then "ssm" "parameter"s are described then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When "ssm" "parameter"s are described
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then a "ssm" "parameter" is deleted then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When a "ssm" "parameter" is deleted
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then multiple "ssm" "parameter"s are deleted then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When multiple "ssm" "parameter"s are deleted
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then tags are added to a "ssm" "parameter" then tags for a "ssm" "parameter" are listed
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When tags are added to a "ssm" "parameter"
    When tags for a "ssm" "parameter" are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags are removed from a "ssm" "parameter" then tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is stored
    Given pname in param_exists
    When tags are removed from a "ssm" "parameter"
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is stored then a "ssm" "parameter" is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is stored
    When a "ssm" "parameter" is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then an existing "ssm" "parameter" value is updated then a "ssm" "parameter" is retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When an existing "ssm" "parameter" value is updated
    When a "ssm" "parameter" is retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is written without overwrite when it already exists then multiple "ssm" "parameter"s are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is written without overwrite when it already exists
    When multiple "ssm" "parameter"s are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is retrieved then "ssm" "parameter"s under a path are retrieved
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is retrieved
    When "ssm" "parameter"s under a path are retrieved
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then multiple "ssm" "parameter"s are retrieved then "ssm" "parameter"s are described
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When multiple "ssm" "parameter"s are retrieved
    When "ssm" "parameter"s are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then "ssm" "parameter"s under a path are retrieved then a "ssm" "parameter" is deleted
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s under a path are retrieved
    When a "ssm" "parameter" is deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then "ssm" "parameter"s are described then multiple "ssm" "parameter"s are deleted
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When "ssm" "parameter"s are described
    When multiple "ssm" "parameter"s are deleted
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then a "ssm" "parameter" is deleted then tags are added to a "ssm" "parameter"
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When a "ssm" "parameter" is deleted
    When tags are added to a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then multiple "ssm" "parameter"s are deleted then tags are removed from a "ssm" "parameter"
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When multiple "ssm" "parameter"s are deleted
    When tags are removed from a "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then tags are added to a "ssm" "parameter" then a "ssm" "parameter" is stored
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When tags are added to a "ssm" "parameter"
    When a "ssm" "parameter" is stored
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @sequence
  Scenario: tags for a "ssm" "parameter" are listed then tags are removed from a "ssm" "parameter" then an existing "ssm" "parameter" value is updated
    Given pname in param_exists
    When tags for a "ssm" "parameter" are listed
    When tags are removed from a "ssm" "parameter"
    When an existing "ssm" "parameter" value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries
