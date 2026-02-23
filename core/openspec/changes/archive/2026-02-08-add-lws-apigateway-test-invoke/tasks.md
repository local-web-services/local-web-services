## 1. Discovery
- [x] 1.1 Add API Gateway routes to `_build_resource_metadata` in `src/lws/cli/main.py`

## 2. Command
- [x] 2.1 Create `src/lws/cli/services/apigateway.py` with `test-invoke-method` command
- [x] 2.2 Register `apigateway` sub-app in `src/lws/cli/lws.py`

## 3. Local Details
- [x] 3.1 Update `_build_local_details` in `src/lws/cli/main.py` to show `lws apigateway test-invoke-method` snippets for API routes

## 4. Tests
- [x] 4.1 Update `tests/unit/api/test_management_resources.py` for apigateway in discovery
- [x] 4.2 Update `tests/unit/cli/test_lws.py` for apigateway sub-command
- [x] 4.3 Update `tests/unit/cli/test_display.py` for lws snippet in local details
