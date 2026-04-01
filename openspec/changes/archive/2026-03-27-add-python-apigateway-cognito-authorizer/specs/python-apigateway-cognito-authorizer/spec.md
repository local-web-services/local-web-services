## ADDED Requirements

### Requirement: API Gateway Cognito Authorizer

The API Gateway provider SHALL support creating, reading, updating, and deleting Cognito user pool authorizers via `create_authorizer` / `update_authorizer` / `delete_authorizer`. When a method has a Cognito authorizer associated, the provider SHALL validate the `Authorization` request header against the referenced user pool and reject requests with HTTP 401 when the token is absent or invalid.

#### Scenario: Request authorised with valid token

- **GIVEN** a REST API method has a Cognito authorizer
- **AND** a valid user pool token is provided in the Authorization header
- **WHEN** a request is sent to the stage endpoint
- **THEN** the request is forwarded and returns a successful response

#### Scenario: Request rejected with missing token

- **GIVEN** a REST API method has a Cognito authorizer
- **WHEN** a request is sent without an Authorization header
- **THEN** the request is rejected with HTTP 401

#### Scenario: Request rejected with invalid token

- **GIVEN** a REST API method has a Cognito authorizer
- **WHEN** a request is sent with an invalid or expired token
- **THEN** the request is rejected with HTTP 401

### Requirement: API Gateway DeleteDeployment and UpdateMethod

The API Gateway provider SHALL implement `delete_deployment` (`DELETE /restapis/{id}/deployments/{deployment_id}`) and `update_method` (`PATCH /restapis/{id}/resources/{resource_id}/methods/{method}`).

#### Scenario: Deployment deleted successfully

- **GIVEN** a deployment exists for a REST API
- **WHEN** `delete_deployment` is called
- **THEN** the deployment is removed and no longer returned in `get_deployments`

#### Scenario: Method updated successfully

- **GIVEN** a method exists on a resource
- **WHEN** `update_method` is called with a patch operation
- **THEN** the method reflects the updated configuration

### Requirement: Cognito User Pool Groups

The Cognito provider SHALL implement user pool group management: `create_group`, `delete_group`, `admin_add_user_to_group`, `admin_remove_user_from_group`, `list_groups`, and `list_users_in_group`.

#### Scenario: User added to group

- **GIVEN** a user pool group exists and a user exists in the pool
- **WHEN** `admin_add_user_to_group` is called
- **THEN** `list_users_in_group` returns the user

#### Scenario: Group deleted

- **GIVEN** a group exists in a user pool
- **WHEN** `delete_group` is called
- **THEN** `list_groups` no longer returns the group
