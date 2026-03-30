# Change: Add Python API Gateway Cognito authorizer and Lambda integration configuration

## Why

~40 e2e step definitions are skipped because lws does not support configuring a Cognito user pool as an authorizer on a REST API, routing requests through that authorizer, or wiring Lambda integrations onto REST API methods. These are core API Gateway usage patterns that are heavily tested in the `apigateway_cognito` and `apigateway_lambda` e2e suites.

## What Changes

- **API Gateway — Cognito authorizer**: Implement `create_authorizer` (type=COGNITO_USER_POOLS), `update_authorizer`, `delete_authorizer`. When a method has a Cognito authorizer, validate the `Authorization` header contains a token that resolves to an authenticated user in the referenced user pool before routing the request.
- **API Gateway — Lambda proxy integration**: Implement `create_integration` (type=AWS_PROXY, uri=arn:aws:apigateway:...:lambda:path/...) on a method. When a request matches the method, invoke the Lambda function synchronously and return its response.
- **API Gateway — Stage and deployment management**: Implement `create_deployment`, `delete_deployment`, `update_method` (PATCH) to close the remaining route gaps.
- **Cognito — Lambda triggers**: Implement `update_user_pool` to accept `LambdaConfig` (pre-signup, post-confirmation, etc.) triggers. Required for the `apigateway_cognito` e2e suite.
- **Cognito — User pool groups**: Implement `create_group`, `delete_group`, `add_user_to_group`, `remove_user_from_group`, `list_groups`, `list_users_in_group`.
- **Cognito — EventBridge publishing**: Implement `update_user_pool` to accept `UserPoolAddOns` with `EventFeedback` / `AdvancedSecurityMode` that publishes events to EventBridge.

## Impact

- Affected specs: `python-apigateway-cognito-authorizer` (new)
- Affected code: `lang/python/core/src/lws/providers/apigateway/routes.py`, `lang/python/core/src/lws/providers/cognito/routes.py`
- No breaking changes.
