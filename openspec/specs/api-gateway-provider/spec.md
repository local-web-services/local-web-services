# api-gateway-provider Specification

## Purpose
TBD - created by archiving change add-initial-requirements. Update Purpose after archive.
## Requirements
### Requirement: HTTP Route Mapping
The API Gateway provider SHALL create a local HTTP server and register routes from the CDK API Gateway definition, mapping each route to the corresponding Lambda handler invocation.

#### Scenario: Map REST API routes
- **WHEN** the CDK defines a REST API with `POST /orders` mapped to a `createOrder` handler
- **THEN** the local HTTP server SHALL accept `POST http://localhost:<port>/orders` and invoke the `createOrder` handler with a correctly shaped API Gateway proxy event

### Requirement: Request Transformation
The provider SHALL transform incoming HTTP requests into API Gateway proxy integration event objects, including body, headers, path parameters, query string parameters, and HTTP method.

#### Scenario: Transform HTTP request to proxy event
- **WHEN** a client sends `POST /orders/123?status=active` with a JSON body and custom headers
- **THEN** the handler SHALL receive an event with `pathParameters.id = "123"`, `queryStringParameters.status = "active"`, the JSON body as a string in `body`, and request headers in `headers`

### Requirement: Response Transformation
The provider SHALL transform Lambda handler responses back into HTTP responses, setting the status code, headers, and body from the handler's return value.

#### Scenario: Transform handler response to HTTP
- **WHEN** a handler returns `{ statusCode: 201, body: JSON.stringify({ orderId: "123" }), headers: { "X-Custom": "value" } }`
- **THEN** the HTTP response SHALL have status 201, the JSON body, and the `X-Custom` header

### Requirement: Multiple API Support
The provider SHALL support multiple API Gateway resources within the same CDK application, each listening on its own port or path prefix.

#### Scenario: Two APIs in same application
- **WHEN** the CDK defines both a public REST API and an internal REST API
- **THEN** both APIs SHALL be available locally with their respective routes correctly mapped

### Requirement: CORS Support
The provider SHALL handle CORS configuration as defined in the CDK API Gateway construct.

#### Scenario: CORS preflight request
- **WHEN** a CORS-enabled API receives an OPTIONS preflight request
- **THEN** the response SHALL include the correct `Access-Control-Allow-Origin`, `Access-Control-Allow-Methods`, and `Access-Control-Allow-Headers` headers as configured in CDK

