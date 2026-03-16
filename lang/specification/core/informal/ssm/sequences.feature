@ssm @generated
Feature: Ssm - Action Sequences

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then an existing parameter value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then parameters under a path are retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then parameters are described
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are added to a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are removed from a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags for a parameter are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is stored in "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then parameters are described
    Given pname in param_exists
    When an existing parameter value is updated
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are added to a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are removed from a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags for a parameter are listed
    Given pname in param_exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then parameters are described
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are added to a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then parameters are described
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then a parameter is stored in "SSM"
    When multiple parameters are retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then an existing parameter value is updated
    When multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then a parameter is written without overwrite when it already exists
    When multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then a parameter is retrieved from "SSM"
    When multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then parameters under a path are retrieved from "SSM"
    When multiple parameters are retrieved from "SSM"
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then parameters are described
    When multiple parameters are retrieved from "SSM"
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then a parameter is deleted from "SSM"
    When multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then multiple parameters are deleted from "SSM"
    When multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then tags are added to a parameter
    When multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then tags are removed from a parameter
    When multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are retrieved from "SSM" then tags for a parameter are listed
    When multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then a parameter is stored in "SSM"
    When parameters under a path are retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then an existing parameter value is updated
    When parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then a parameter is written without overwrite when it already exists
    When parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then a parameter is retrieved from "SSM"
    When parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then multiple parameters are retrieved from "SSM"
    When parameters under a path are retrieved from "SSM"
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then parameters are described
    When parameters under a path are retrieved from "SSM"
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then a parameter is deleted from "SSM"
    When parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then multiple parameters are deleted from "SSM"
    When parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then tags are added to a parameter
    When parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then tags are removed from a parameter
    When parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters under a path are retrieved from "SSM" then tags for a parameter are listed
    When parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then a parameter is stored in "SSM"
    When parameters are described
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then an existing parameter value is updated
    When parameters are described
    Given pname in param_exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then a parameter is written without overwrite when it already exists
    When parameters are described
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then a parameter is retrieved from "SSM"
    When parameters are described
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then multiple parameters are retrieved from "SSM"
    When parameters are described
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then parameters under a path are retrieved from "SSM"
    When parameters are described
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then a parameter is deleted from "SSM"
    When parameters are described
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then multiple parameters are deleted from "SSM"
    When parameters are described
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then tags are added to a parameter
    When parameters are described
    Given pname in param_exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then tags are removed from a parameter
    When parameters are described
    Given pname in param_exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: parameters are described then tags for a parameter are listed
    When parameters are described
    Given pname in param_exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then parameters are described
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then parameters are described
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then an existing parameter value is updated
    Given pname in param_exists
    When tags are added to a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then parameters are described
    Given pname in param_exists
    When tags are added to a parameter
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags are removed from a parameter
    Given pname in param_exists
    When tags are added to a parameter
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags for a parameter are listed
    Given pname in param_exists
    When tags are added to a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then an existing parameter value is updated
    Given pname in param_exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then parameters are described
    Given pname in param_exists
    When tags are removed from a parameter
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags are added to a parameter
    Given pname in param_exists
    When tags are removed from a parameter
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags for a parameter are listed
    Given pname in param_exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then an existing parameter value is updated
    Given pname in param_exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then parameters under a path are retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When parameters under a path are retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then parameters are described
    Given pname in param_exists
    When tags for a parameter are listed
    When parameters are described
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are added to a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are removed from a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then an existing parameter value is updated then a parameter is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then an existing parameter value is updated then a parameter is retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then an existing parameter value is updated then a parameter is deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then an existing parameter value is updated then multiple parameters are deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then an existing parameter value is updated then tags are added to a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then an existing parameter value is updated then tags are removed from a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then an existing parameter value is updated then tags for a parameter are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists then an existing parameter value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists then tags are added to a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists then tags are removed from a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists then tags for a parameter are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is retrieved from "SSM" then an existing parameter value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is retrieved from "SSM" then a parameter is deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is retrieved from "SSM" then tags are added to a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is retrieved from "SSM" then tags are removed from a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is retrieved from "SSM" then tags for a parameter are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is deleted from "SSM" then an existing parameter value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is deleted from "SSM" then tags are added to a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is deleted from "SSM" then tags are removed from a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then a parameter is deleted from "SSM" then tags for a parameter are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are deleted from "SSM" then an existing parameter value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are deleted from "SSM" then tags are added to a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are deleted from "SSM" then tags are removed from a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then multiple parameters are deleted from "SSM" then tags for a parameter are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are added to a parameter then an existing parameter value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are added to a parameter then a parameter is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are added to a parameter then a parameter is retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are added to a parameter then a parameter is deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are added to a parameter then multiple parameters are deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are added to a parameter then tags are removed from a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are added to a parameter then tags for a parameter are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are removed from a parameter then an existing parameter value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are removed from a parameter then a parameter is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are removed from a parameter then a parameter is retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are removed from a parameter then a parameter is deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are removed from a parameter then multiple parameters are deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are removed from a parameter then tags are added to a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags are removed from a parameter then tags for a parameter are listed
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags for a parameter are listed then an existing parameter value is updated
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags for a parameter are listed then a parameter is written without overwrite when it already exists
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags for a parameter are listed then a parameter is retrieved from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags for a parameter are listed then a parameter is deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags for a parameter are listed then multiple parameters are deleted from "SSM"
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags for a parameter are listed then tags are added to a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is stored in "SSM" then tags for a parameter are listed then tags are removed from a parameter
    Given pname not in param_exists or param_exists[pname] is False
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is stored in "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is stored in "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is stored in "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is stored in "SSM" then tags are added to a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is stored in "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is stored in "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is written without overwrite when it already exists then a parameter is stored in "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is written without overwrite when it already exists then tags are added to a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is written without overwrite when it already exists then tags are removed from a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is written without overwrite when it already exists then tags for a parameter are listed
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is retrieved from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is retrieved from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is retrieved from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is retrieved from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is retrieved from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then a parameter is deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then multiple parameters are deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are added to a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are added to a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are added to a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are added to a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are added to a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are added to a parameter then tags are removed from a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are added to a parameter
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are added to a parameter then tags for a parameter are listed
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are added to a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are removed from a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are removed from a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are removed from a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are removed from a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are removed from a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are removed from a parameter then tags are added to a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags are removed from a parameter then tags for a parameter are listed
    Given pname in param_exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags for a parameter are listed then a parameter is stored in "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags for a parameter are listed then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags for a parameter are listed then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags for a parameter are listed then a parameter is deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags for a parameter are listed then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags for a parameter are listed then tags are added to a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: an existing parameter value is updated then tags for a parameter are listed then tags are removed from a parameter
    Given pname in param_exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is stored in "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is stored in "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is stored in "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is stored in "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is stored in "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is stored in "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is stored in "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then an existing parameter value is updated then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then an existing parameter value is updated then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then an existing parameter value is updated then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then an existing parameter value is updated then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then an existing parameter value is updated then tags are added to a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then an existing parameter value is updated then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then an existing parameter value is updated then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are added to a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are added to a parameter then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are added to a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are added to a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are added to a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are added to a parameter then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are added to a parameter then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are removed from a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are removed from a parameter then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are removed from a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are removed from a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are removed from a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are removed from a parameter then tags are added to a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags are removed from a parameter then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags for a parameter are listed then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags for a parameter are listed then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags for a parameter are listed then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags for a parameter are listed then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags for a parameter are listed then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags for a parameter are listed then tags are added to a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is written without overwrite when it already exists then tags for a parameter are listed then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is stored in "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is stored in "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is stored in "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is stored in "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is stored in "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is stored in "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then an existing parameter value is updated then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then an existing parameter value is updated then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then an existing parameter value is updated then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then an existing parameter value is updated then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then an existing parameter value is updated then tags are added to a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then an existing parameter value is updated then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then an existing parameter value is updated then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists then tags are added to a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then a parameter is deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are added to a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are added to a parameter then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are added to a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are added to a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are added to a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are added to a parameter then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are added to a parameter then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are removed from a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are removed from a parameter then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are removed from a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are removed from a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are removed from a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are removed from a parameter then tags are added to a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags are removed from a parameter then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags for a parameter are listed then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags for a parameter are listed then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags for a parameter are listed then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags for a parameter are listed then a parameter is deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags for a parameter are listed then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags for a parameter are listed then tags are added to a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is retrieved from "SSM" then tags for a parameter are listed then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is stored in "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is stored in "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is stored in "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is stored in "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is stored in "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is stored in "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then an existing parameter value is updated then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then an existing parameter value is updated then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then an existing parameter value is updated then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then an existing parameter value is updated then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then an existing parameter value is updated then tags are added to a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then an existing parameter value is updated then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then an existing parameter value is updated then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists then tags are added to a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is retrieved from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is retrieved from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is retrieved from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is retrieved from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then a parameter is retrieved from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are added to a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are added to a parameter then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are added to a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are added to a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are added to a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are added to a parameter then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are added to a parameter then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are removed from a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are removed from a parameter then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are removed from a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are removed from a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are removed from a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are removed from a parameter then tags are added to a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags are removed from a parameter then tags for a parameter are listed
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags for a parameter are listed then a parameter is stored in "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags for a parameter are listed then an existing parameter value is updated
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags for a parameter are listed then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags for a parameter are listed then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags for a parameter are listed then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags for a parameter are listed then tags are added to a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: a parameter is deleted from "SSM" then tags for a parameter are listed then tags are removed from a parameter
    Given pname in param_exists
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is stored in "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is stored in "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is stored in "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is stored in "SSM" then tags are added to a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is stored in "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is stored in "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then an existing parameter value is updated then a parameter is stored in "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then an existing parameter value is updated then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then an existing parameter value is updated then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then an existing parameter value is updated then a parameter is deleted from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then an existing parameter value is updated then tags are added to a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then an existing parameter value is updated then tags are removed from a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then an existing parameter value is updated then tags for a parameter are listed
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists then a parameter is stored in "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists then an existing parameter value is updated
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists then tags are added to a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists then tags are removed from a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists then tags for a parameter are listed
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are added to a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are added to a parameter then an existing parameter value is updated
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are added to a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are added to a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are added to a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are added to a parameter then tags are removed from a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are added to a parameter then tags for a parameter are listed
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are removed from a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are removed from a parameter then an existing parameter value is updated
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are removed from a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are removed from a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are removed from a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are removed from a parameter then tags are added to a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags are removed from a parameter then tags for a parameter are listed
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags for a parameter are listed then a parameter is stored in "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags for a parameter are listed then an existing parameter value is updated
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags for a parameter are listed then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags for a parameter are listed then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags for a parameter are listed then a parameter is deleted from "SSM"
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags for a parameter are listed then tags are added to a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: multiple parameters are deleted from "SSM" then tags for a parameter are listed then tags are removed from a parameter
    Given pname in param_exists
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is stored in "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is stored in "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is stored in "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is stored in "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is stored in "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is stored in "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then an existing parameter value is updated then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then an existing parameter value is updated then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a parameter
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then an existing parameter value is updated then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then an existing parameter value is updated then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then an existing parameter value is updated then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then an existing parameter value is updated then tags are removed from a parameter
    Given pname in param_exists
    When tags are added to a parameter
    When an existing parameter value is updated
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then an existing parameter value is updated then tags for a parameter are listed
    Given pname in param_exists
    When tags are added to a parameter
    When an existing parameter value is updated
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is written without overwrite when it already exists then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is written without overwrite when it already exists then an existing parameter value is updated
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is written without overwrite when it already exists then tags are removed from a parameter
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is written without overwrite when it already exists then tags for a parameter are listed
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is retrieved from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is retrieved from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is retrieved from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is retrieved from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is retrieved from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then a parameter is deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then multiple parameters are deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags are removed from a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags are removed from a parameter then an existing parameter value is updated
    Given pname in param_exists
    When tags are added to a parameter
    When tags are removed from a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags are removed from a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a parameter
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags are removed from a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags are removed from a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags are removed from a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags are removed from a parameter then tags for a parameter are listed
    Given pname in param_exists
    When tags are added to a parameter
    When tags are removed from a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags for a parameter are listed then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags for a parameter are listed then an existing parameter value is updated
    Given pname in param_exists
    When tags are added to a parameter
    When tags for a parameter are listed
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags for a parameter are listed then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are added to a parameter
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags for a parameter are listed then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags for a parameter are listed then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags for a parameter are listed then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are added to a parameter
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are added to a parameter then tags for a parameter are listed then tags are removed from a parameter
    Given pname in param_exists
    When tags are added to a parameter
    When tags for a parameter are listed
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is stored in "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is stored in "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is stored in "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is stored in "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is stored in "SSM" then tags are added to a parameter
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is stored in "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then an existing parameter value is updated then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then an existing parameter value is updated then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then an existing parameter value is updated then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then an existing parameter value is updated then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then an existing parameter value is updated then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then an existing parameter value is updated then tags are added to a parameter
    Given pname in param_exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then an existing parameter value is updated then tags for a parameter are listed
    Given pname in param_exists
    When tags are removed from a parameter
    When an existing parameter value is updated
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is written without overwrite when it already exists then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is written without overwrite when it already exists then an existing parameter value is updated
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is written without overwrite when it already exists then tags are added to a parameter
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is written without overwrite when it already exists then tags for a parameter are listed
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is retrieved from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is retrieved from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is retrieved from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is retrieved from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is retrieved from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then a parameter is deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then multiple parameters are deleted from "SSM" then tags for a parameter are listed
    Given pname in param_exists
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags are added to a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags are added to a parameter then an existing parameter value is updated
    Given pname in param_exists
    When tags are removed from a parameter
    When tags are added to a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags are added to a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a parameter
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags are added to a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags are added to a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags are added to a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags are added to a parameter then tags for a parameter are listed
    Given pname in param_exists
    When tags are removed from a parameter
    When tags are added to a parameter
    When tags for a parameter are listed
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags for a parameter are listed then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags for a parameter are listed then an existing parameter value is updated
    Given pname in param_exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags for a parameter are listed then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags for a parameter are listed then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags for a parameter are listed then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags for a parameter are listed then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags are removed from a parameter then tags for a parameter are listed then tags are added to a parameter
    Given pname in param_exists
    When tags are removed from a parameter
    When tags for a parameter are listed
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is stored in "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is stored in "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is stored in "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is stored in "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is stored in "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is stored in "SSM" then tags are added to a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is stored in "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is stored in "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then an existing parameter value is updated then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then an existing parameter value is updated then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then an existing parameter value is updated then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then an existing parameter value is updated then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then an existing parameter value is updated then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then an existing parameter value is updated then tags are added to a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then an existing parameter value is updated then tags are removed from a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When an existing parameter value is updated
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is written without overwrite when it already exists then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is written without overwrite when it already exists then an existing parameter value is updated
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is written without overwrite when it already exists then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is written without overwrite when it already exists then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is written without overwrite when it already exists then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is written without overwrite when it already exists then tags are added to a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is written without overwrite when it already exists then tags are removed from a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is written without overwrite when it already exists
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is retrieved from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is retrieved from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is retrieved from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is retrieved from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is retrieved from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is retrieved from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is retrieved from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is retrieved from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is deleted from "SSM" then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then a parameter is deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When a parameter is deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are deleted from "SSM" then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are deleted from "SSM" then an existing parameter value is updated
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are deleted from "SSM" then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are deleted from "SSM" then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are deleted from "SSM" then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are deleted from "SSM" then tags are added to a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then multiple parameters are deleted from "SSM" then tags are removed from a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When multiple parameters are deleted from "SSM"
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are added to a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are added to a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are added to a parameter then an existing parameter value is updated
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are added to a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are added to a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are added to a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are added to a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are added to a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are added to a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are added to a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are added to a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are added to a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are added to a parameter then tags are removed from a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are added to a parameter
    When tags are removed from a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are removed from a parameter then a parameter is stored in "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    When a parameter is stored in "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are removed from a parameter then an existing parameter value is updated
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    When an existing parameter value is updated
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are removed from a parameter then a parameter is written without overwrite when it already exists
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    When a parameter is written without overwrite when it already exists
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are removed from a parameter then a parameter is retrieved from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    When a parameter is retrieved from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are removed from a parameter then a parameter is deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    When a parameter is deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are removed from a parameter then multiple parameters are deleted from "SSM"
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    When multiple parameters are deleted from "SSM"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @exhaustive @sequence
  Scenario: tags for a parameter are listed then tags are removed from a parameter then tags are added to a parameter
    Given pname in param_exists
    When tags for a parameter are listed
    When tags are removed from a parameter
    When tags are added to a parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries
