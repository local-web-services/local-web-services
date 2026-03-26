# Tasks: add-python-apigateway-cognito-authorizer

## 1. API Gateway — Cognito authorizer

- [ ] 1.1 Implement `POST /restapis/{api_id}/authorizers` (create_authorizer, type=COGNITO_USER_POOLS)
- [ ] 1.2 Implement `GET /restapis/{api_id}/authorizers` and `GET /restapis/{api_id}/authorizers/{authorizer_id}`
- [ ] 1.3 Implement `PATCH /restapis/{api_id}/authorizers/{authorizer_id}` (update_authorizer)
- [ ] 1.4 Implement `DELETE /restapis/{api_id}/authorizers/{authorizer_id}`
- [ ] 1.5 Implement `PUT /restapis/{api_id}/resources/{resource_id}/methods/{method}/authorizer` to associate authorizer with method
- [ ] 1.6 On incoming request: if method has Cognito authorizer, validate Authorization header token against Cognito user pool; reject with 401 if invalid
- [ ] 1.7 Unit tests for authorizer CRUD and token validation

## 2. API Gateway — Lambda proxy integration

- [ ] 2.1 Implement `PUT /restapis/{api_id}/resources/{resource_id}/methods/{method}/integration` (type=AWS_PROXY)
- [ ] 2.2 On incoming request: if method has Lambda proxy integration, invoke Lambda synchronously and return response
- [ ] 2.3 Unit tests

## 3. API Gateway — missing routes

- [ ] 3.1 Implement `DELETE /restapis/{api_id}/deployments/{deployment_id}` (delete_deployment)
- [ ] 3.2 Implement `PATCH /restapis/{api_id}/resources/{resource_id}/methods/{method}` (update_method)
- [ ] 3.3 Unit tests

## 4. Cognito — user pool groups

- [ ] 4.1 Implement `create_group` / `delete_group`
- [ ] 4.2 Implement `admin_add_user_to_group` / `admin_remove_user_from_group`
- [ ] 4.3 Implement `list_groups` / `list_users_in_group`
- [ ] 4.4 Unit tests

## 5. Cognito — Lambda triggers and EventBridge

- [ ] 5.1 Implement `update_user_pool` to accept `LambdaConfig`
- [ ] 5.2 Wire Lambda trigger invocations during Cognito operations (pre-signup, post-confirmation)
- [ ] 5.3 Implement EventBridge event publishing from user pool operations
- [ ] 5.4 Unit tests

## 6. Quality checks

- [ ] 6.1 `make check` passes for `lang/python/core`
- [ ] 6.2 `make check` passes for `lang/python/sdk`
- [ ] 6.3 All formerly-skipped API Gateway Cognito authorizer steps now pass
