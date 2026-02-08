## ADDED Requirements

### Requirement: User Pool Operations
The Cognito provider SHALL implement minimal local user pool operations: sign up, sign in, and JWT token generation.

#### Scenario: Sign up and sign in
- **WHEN** a user signs up with email and password, then signs in with the same credentials
- **THEN** sign up SHALL succeed and sign in SHALL return a valid JWT token

#### Scenario: Invalid credentials rejected
- **WHEN** a user attempts to sign in with incorrect credentials
- **THEN** the sign in SHALL fail with an authentication error

### Requirement: API Gateway Authorizer Integration
The provider SHALL integrate with the API Gateway provider to validate JWT tokens on protected routes using Cognito authorizer configuration from CDK.

#### Scenario: Valid token accepted
- **WHEN** a request to a protected API route includes a valid JWT token in the Authorization header
- **THEN** the request SHALL be forwarded to the handler with the decoded claims

#### Scenario: Missing or invalid token rejected
- **WHEN** a request to a protected API route has no token or an invalid token
- **THEN** the request SHALL be rejected with a 401 Unauthorized response

### Requirement: Lambda Triggers
The provider SHALL support pre-authentication and post-confirmation Lambda triggers as configured in CDK.

#### Scenario: Pre-authentication trigger
- **WHEN** a user signs in and a pre-authentication Lambda trigger is configured
- **THEN** the trigger handler SHALL be invoked before authentication completes, and the handler can allow or deny the authentication

#### Scenario: Post-confirmation trigger
- **WHEN** a user confirms their account and a post-confirmation Lambda trigger is configured
- **THEN** the trigger handler SHALL be invoked after confirmation with the user's attributes

### Requirement: Hybrid Mode Recommendation
The Cognito provider documentation SHALL prominently recommend hybrid mode (pointing at real Cognito) for complex authentication scenarios that require higher fidelity than the local implementation provides.

#### Scenario: Documentation includes hybrid mode guidance
- **WHEN** a developer reads the Cognito provider documentation
- **THEN** the documentation SHALL explain how to configure hybrid mode for Cognito and recommend it for scenarios involving OAuth flows, federated identity, or advanced user pool features
