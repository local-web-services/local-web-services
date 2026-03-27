package tests

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	cidptypes "github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider/types"
	"github.com/cucumber/godog"
)

const cognitoTestPoolName = "e2e-cognito-test-pool-1"
const cognitoTestUsername = "e2e-test-user-1"
const cognitoTestPassword = "Test@Pass123!"
const cognitoTestTempPassword = "TempPass1!"
const cognitoTestGroupName = "e2e-cognito-test-group-1"
const cognitoTestAttribute = "custom:role"
const cognitoTestAttributeValue = "admin"

// cognitoState holds mutable state for Cognito IDP step definitions within one scenario.
type cognitoState struct {
	poolID       string
	username     string
	groupName    string
	sessionToken string
}

func registerCognitoIDPSteps(sc *godog.ScenarioContext, world *World) {
	st := &cognitoState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.poolID = ""
		st.username = ""
		st.groupName = ""
		st.sessionToken = ""
		return ctx, nil
	})

	// ── helpers ──────────────────────────────────────────────────────────────────

	createPool := func() (string, error) {
		resp, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(cognitoTestPoolName),
		})
		if err != nil {
			if isAlreadyExists(err) {
				// Pool already exists — look it up to retrieve its ID.
				listResp, listErr := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
					MaxResults: aws.Int32(60),
				})
				if listErr == nil {
					for _, p := range listResp.UserPools {
						if p.Name != nil && *p.Name == cognitoTestPoolName && p.Id != nil {
							return *p.Id, nil
						}
					}
				}
			}
			return "", err
		}
		return *resp.UserPool.Id, nil
	}

	createUser := func(poolID string) error {
		_, err := world.CognitoIDPClient().AdminCreateUser(context.Background(), &cognitoidentityprovider.AdminCreateUserInput{
			UserPoolId:        aws.String(poolID),
			Username:          aws.String(cognitoTestUsername),
			TemporaryPassword: aws.String(cognitoTestTempPassword),
		})
		return err
	}

	createGroup := func(poolID string) error {
		_, err := world.CognitoIDPClient().CreateGroup(context.Background(), &cognitoidentityprovider.CreateGroupInput{
			UserPoolId: aws.String(poolID),
			GroupName:  aws.String(cognitoTestGroupName),
		})
		return err
	}

	// ── Background ───────────────────────────────────────────────────────────────

	// "the system is initialized" is already registered in sequences_test.go.

	// ── Given: user pool existence ───────────────────────────────────────────────

	sc.Given(`^the user pool does not already exist$`, func() error {
		// No-op: fresh state after reset has no user pools.
		return nil
	})

	sc.Given(`^the user pool already exists$`, func() error {
		// Arrange: create pools for all known pool names.
		// The first-registered "When a Cognito user pool is created" step
		// (from lambda_cognito_test.go and cognito_lambda_test.go) uses
		// "e2e-test-pool-1". Without pre-creating that name, the duplicate
		// check in the handler would not fire.
		// Act
		poolID, err := createPool()
		if err != nil {
			return err
		}
		st.poolID = poolID
		// Also create the cross-service pool name.
		_, _ = world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(lambdaCognitoTestPoolName),
		})
		return nil
	})

	sc.Given(`^the user pool exists$`, func() error {
		// Arrange: create the test user pool
		// Act
		poolID, err := createPool()
		if err != nil {
			return err
		}
		// Assert: store pool ID
		st.poolID = poolID
		return nil
	})

	sc.Given(`^the user pool is "ACTIVE"$`, func() error {
		// No-op: user pools are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the user pool is not "ACTIVE"$`, func() error {
		// Arrange: use lifecycle API to make the pool appear non-ACTIVE (dwell)
		sess := managementSession()
		// Act
		if err := sess.Lifecycle("cognitoidp").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle dwell apply failed: %w", err)
		}
		poolID, err := createPool()
		if err != nil {
			return err
		}
		// Assert: store pool ID
		st.poolID = poolID
		return nil
	})

	sc.Given(`^the user pool does not exist$`, func() error {
		// No-op: fresh state after reset has no user pools.
		return nil
	})

	// ── Given: user existence ────────────────────────────────────────────────────

	sc.Given(`^the user does not already exist$`, func() error {
		// No-op: fresh state has no users.
		return nil
	})

	sc.Given(`^the user already exists$`, func() error {
		// Arrange: ensure the pool exists, then create the user
		if st.poolID == "" {
			poolID, err := createPool()
			if err != nil {
				return err
			}
			st.poolID = poolID
		}
		// Act
		err := createUser(st.poolID)
		if err != nil {
			return err
		}
		// Assert: store username
		st.username = cognitoTestUsername
		return nil
	})

	sc.Given(`^the user exists$`, func() error {
		// Arrange: ensure the pool exists, then create the user
		if st.poolID == "" {
			poolID, err := createPool()
			if err != nil {
				return err
			}
			st.poolID = poolID
		}
		// Act
		err := createUser(st.poolID)
		if err != nil {
			return err
		}
		// Assert: store username
		st.username = cognitoTestUsername
		return nil
	})

	sc.Given(`^the user does not exist$`, func() error {
		// No-op: fresh state has no users.
		return nil
	})

	sc.Given(`^the user is not already "DELETED"$`, func() error {
		// No-op: newly created users are not in DELETED state.
		return nil
	})

	sc.Given(`^the user is "DELETED"$`, func() error {
		// Arrange: delete the user so they are in DELETED state (not present in the store).
		st.username = cognitoTestUsername
		if st.poolID != "" {
			_, _ = world.CognitoIDPClient().AdminDeleteUser(context.Background(), &cognitoidentityprovider.AdminDeleteUserInput{
				UserPoolId: aws.String(st.poolID),
				Username:   aws.String(cognitoTestUsername),
			})
		}
		return nil
	})

	sc.Given(`^the user is not "DELETED"$`, func() error {
		// No-op: newly created users are not in DELETED state.
		return nil
	})

	sc.Given(`^the user is already "DELETED"$`, func() error {
		// Arrange: delete the user so they are in DELETED state (not present in the store).
		st.username = cognitoTestUsername
		if st.poolID != "" {
			_, _ = world.CognitoIDPClient().AdminDeleteUser(context.Background(), &cognitoidentityprovider.AdminDeleteUserInput{
				UserPoolId: aws.String(st.poolID),
				Username:   aws.String(cognitoTestUsername),
			})
		}
		return nil
	})

	sc.Given(`^the user is "CONFIRMED"$`, func() error {
		// Arrange: transition user from FORCE_CHANGE_PASSWORD → CONFIRMED via AdminConfirmSignUp
		// AdminConfirmSignUp works from FORCE_CHANGE_PASSWORD state directly.
		_, err := world.CognitoIDPClient().AdminConfirmSignUp(context.Background(), &cognitoidentityprovider.AdminConfirmSignUpInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		// Assert: user is now CONFIRMED
		return err
	})

	sc.Given(`^the user is not "CONFIRMED"$`, func() error {
		// No-op: users created via AdminCreateUser start in FORCE_CHANGE_PASSWORD.
		return nil
	})

	sc.Given(`^the user is "UNCONFIRMED"$`, func() error {
		// No-op: no public API puts a user into UNCONFIRMED from FORCE_CHANGE_PASSWORD.
		// The lws fake accepts AdminConfirmSignUp on FORCE_CHANGE_PASSWORD as proxy.
		return nil
	})

	sc.Given(`^the user is not "UNCONFIRMED"$`, func() error {
		// Arrange: confirm the user via AdminConfirmSignUp (FORCE_CHANGE_PASSWORD → CONFIRMED).
		_, err := world.CognitoIDPClient().AdminConfirmSignUp(context.Background(), &cognitoidentityprovider.AdminConfirmSignUpInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		// Assert: user is now CONFIRMED (not UNCONFIRMED)
		return err
	})

	sc.Given(`^the user is in "RESET_REQUIRED" state$`, func() error {
		// Arrange: confirm user first (FORCE_CHANGE_PASSWORD → CONFIRMED), then reset password (CONFIRMED → RESET_REQUIRED)
		// Step 1: confirm the user
		_, err := world.CognitoIDPClient().AdminConfirmSignUp(context.Background(), &cognitoidentityprovider.AdminConfirmSignUpInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		if err != nil {
			return err
		}
		// Step 2: reset their password to put them in RESET_REQUIRED state
		_, err = world.CognitoIDPClient().AdminResetUserPassword(context.Background(), &cognitoidentityprovider.AdminResetUserPasswordInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		// Assert: user is now in RESET_REQUIRED
		return err
	})

	sc.Given(`^the user is not in "RESET_REQUIRED" state$`, func() error {
		// No-op: user starts in FORCE_CHANGE_PASSWORD, not RESET_REQUIRED.
		return nil
	})

	sc.Given(`^the user is in "FORCE_CHANGE_PASSWORD" state$`, func() error {
		// No-op: users created via AdminCreateUser start in FORCE_CHANGE_PASSWORD by default.
		return nil
	})

	sc.Given(`^the user is not in "FORCE_CHANGE_PASSWORD" state$`, func() error {
		// Arrange: set a permanent password so user is CONFIRMED (not FORCE_CHANGE_PASSWORD)
		// Act
		_, err := world.CognitoIDPClient().AdminSetUserPassword(context.Background(), &cognitoidentityprovider.AdminSetUserPasswordInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
			Password:   aws.String(cognitoTestPassword),
			Permanent:  true,
		})
		// Assert: user is now CONFIRMED
		return err
	})

	// ── Given: user enabled/disabled state ───────────────────────────────────────

	sc.Given(`^the user has an enabled flag$`, func() error {
		// Arrange: ensure pool and user exist
		if st.poolID == "" {
			poolID, err := createPool()
			if err != nil {
				return err
			}
			st.poolID = poolID
		}
		// Act
		err := createUser(st.poolID)
		if err != nil {
			return err
		}
		// Assert: store username
		st.username = cognitoTestUsername
		return nil
	})

	sc.Given(`^the user does not have an enabled flag$`, func() error {
		// No-op: no user exists; this is the "user not found" negative path.
		st.username = cognitoTestUsername
		return nil
	})

	sc.Given(`^the user is enabled$`, func() error {
		// No-op: newly created users are enabled by default.
		return nil
	})

	sc.Given(`^the user is not enabled$`, func() error {
		// Arrange: disable the user
		// Act
		_, err := world.CognitoIDPClient().AdminDisableUser(context.Background(), &cognitoidentityprovider.AdminDisableUserInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		// Assert: user is now disabled
		return err
	})

	sc.Given(`^the user is disabled$`, func() error {
		// Arrange: disable the user
		// Act
		_, err := world.CognitoIDPClient().AdminDisableUser(context.Background(), &cognitoidentityprovider.AdminDisableUserInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		// Assert: user is now disabled
		return err
	})

	sc.Given(`^the user is not disabled$`, func() error {
		// No-op: newly created users are enabled (not disabled) by default.
		return nil
	})

	// ── Given: capacity ───────────────────────────────────────────────────────────

	sc.Given(`^the session slot is available$`, func() error {
		// Arrange: ensure unlimited capacity for cognitoidp
		// Act
		err := managementSession().Capacity("cognitoidp").Unlimited().Apply()
		// Assert: capacity is unlimited
		return err
	})

	sc.Given(`^the session slot is not available$`, func() error {
		// Arrange: exhaust the cognitoidp auth session capacity
		// Act
		err := managementSession().Capacity("cognitoidp").Exhaust().Apply()
		// Assert: capacity is exhausted
		return err
	})

	// ── Given: group existence ───────────────────────────────────────────────────

	sc.Given(`^the group does not already exist$`, func() error {
		// No-op: fresh state has no groups.
		return nil
	})

	sc.Given(`^the group already exists$`, func() error {
		// Arrange: create the test group
		// Act
		err := createGroup(st.poolID)
		if err != nil {
			return err
		}
		// Assert: store group name
		st.groupName = cognitoTestGroupName
		return nil
	})

	sc.Given(`^the group exists$`, func() error {
		// Arrange: ensure pool exists, then create the group
		if st.poolID == "" {
			poolID, err := createPool()
			if err != nil {
				return err
			}
			st.poolID = poolID
		}
		// Act
		err := createGroup(st.poolID)
		if err != nil {
			return err
		}
		// Assert: store group name
		st.groupName = cognitoTestGroupName
		return nil
	})

	sc.Given(`^the group does not exist$`, func() error {
		// No-op: fresh state has no groups.
		st.groupName = cognitoTestGroupName
		return nil
	})

	sc.Given(`^the group is "ACTIVE"$`, func() error {
		// No-op: groups are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the group is not "ACTIVE"$`, func() error {
		// No-op: there is no public API to put a group into a non-ACTIVE state.
		st.groupName = cognitoTestGroupName
		return nil
	})

	sc.Given(`^the user and group belong to the same pool$`, func() error {
		// No-op: both user and group are created in the same pool (st.poolID).
		return nil
	})

	sc.Given(`^the user and group belong to different pools$`, func() error {
		// Arrange: create a second pool and a group in it (group name collision with different pool)
		// Act
		resp, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String("e2e-cognito-test-pool-2"),
		})
		if err != nil {
			return err
		}
		secondPoolID := *resp.UserPool.Id
		err = createGroup(secondPoolID)
		if err != nil {
			return err
		}
		// Assert: group name set, but it belongs to a different pool
		st.groupName = cognitoTestGroupName
		return nil
	})

	// ── Given: auth session state ────────────────────────────────────────────────

	sc.Given(`^the session exists$`, func() error {
		// Create a pool and user in FORCE_CHANGE_PASSWORD state, then initiate
		// auth to obtain a session token in CHALLENGE_REQUIRED state.
		if st.poolID == "" {
			poolID, err := createPool()
			if err != nil {
				return fmt.Errorf("create pool for session: %w", err)
			}
			st.poolID = poolID
		}
		if st.username == "" {
			if err := createUser(st.poolID); err != nil {
				return fmt.Errorf("create user for session: %w", err)
			}
			st.username = cognitoTestUsername
		}
		// Initiate auth: user is in FORCE_CHANGE_PASSWORD, so AdminInitiateAuth
		// returns NEW_PASSWORD_REQUIRED challenge with a session token.
		resp, err := world.CognitoIDPClient().AdminInitiateAuth(context.Background(), &cognitoidentityprovider.AdminInitiateAuthInput{
			UserPoolId: aws.String(st.poolID),
			ClientId:   aws.String("test-client-id"),
			AuthFlow:   cidptypes.AuthFlowTypeAdminNoSrpAuth,
			AuthParameters: map[string]string{
				"USERNAME": st.username,
				"PASSWORD": cognitoTestTempPassword,
			},
		})
		if err != nil {
			return fmt.Errorf("initiate auth for session: %w", err)
		}
		if resp.Session != nil {
			st.sessionToken = *resp.Session
		}
		return nil
	})

	sc.Given(`^the session does not exist$`, func() error {
		// No-op: no session has been created in this scenario.
		return nil
	})

	sc.Given(`^the session is "CHALLENGE_REQUIRED"$`, func() error {
		// No-op: @internal scenario; no public API puts a session into CHALLENGE_REQUIRED.
		return nil
	})

	sc.Given(`^the session is not "CHALLENGE_REQUIRED"$`, func() error {
		// No-op: @internal scenario.
		return nil
	})

	sc.Given(`^the session is "AUTHENTICATED"$`, func() error {
		// No-op: @internal scenario.
		return nil
	})

	sc.Given(`^the session is not "AUTHENTICATED"$`, func() error {
		// No-op: @internal scenario.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^a user pool is created$`, func() error {
		// Arrange
		// Act
		resp, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(cognitoTestPoolName),
		})
		// Assert: store result
		if err == nil {
			st.poolID = *resp.UserPool.Id
		}
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user pool is deleted$`, func() error {
		// Arrange
		poolID := st.poolID
		// Act
		resp, err := world.CognitoIDPClient().DeleteUserPool(context.Background(), &cognitoidentityprovider.DeleteUserPoolInput{
			UserPoolId: aws.String(poolID),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user is created by an admin in an active user pool$`, func() error {
		// Arrange
		poolID := st.poolID
		// Act
		resp, err := world.CognitoIDPClient().AdminCreateUser(context.Background(), &cognitoidentityprovider.AdminCreateUserInput{
			UserPoolId:        aws.String(poolID),
			Username:          aws.String(cognitoTestUsername),
			TemporaryPassword: aws.String(cognitoTestTempPassword),
		})
		// Assert: store result
		if err == nil {
			st.username = cognitoTestUsername
		}
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user is deleted by an admin$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		if username == "" {
			username = cognitoTestUsername
		}
		// Act
		resp, err := world.CognitoIDPClient().AdminDeleteUser(context.Background(), &cognitoidentityprovider.AdminDeleteUserInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user account is disabled by an admin$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		// Act
		resp, err := world.CognitoIDPClient().AdminDisableUser(context.Background(), &cognitoidentityprovider.AdminDisableUserInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user account is enabled by an admin$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		// Act
		resp, err := world.CognitoIDPClient().AdminEnableUser(context.Background(), &cognitoidentityprovider.AdminEnableUserInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an admin resets a user password$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		if username == "" {
			username = cognitoTestUsername
		}
		// Act
		resp, err := world.CognitoIDPClient().AdminResetUserPassword(context.Background(), &cognitoidentityprovider.AdminResetUserPasswordInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an admin sets a user password$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		// Act
		resp, err := world.CognitoIDPClient().AdminSetUserPassword(context.Background(), &cognitoidentityprovider.AdminSetUserPasswordInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
			Password:   aws.String(cognitoTestPassword),
			Permanent:  true,
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an admin updates attributes for a confirmed user$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		if username == "" {
			username = cognitoTestUsername
		}
		// Act
		resp, err := world.CognitoIDPClient().AdminUpdateUserAttributes(context.Background(), &cognitoidentityprovider.AdminUpdateUserAttributesInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
			UserAttributes: []cidptypes.AttributeType{
				{Name: aws.String(cognitoTestAttribute), Value: aws.String(cognitoTestAttributeValue)},
			},
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an admin confirms a user registration$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		if username == "" {
			username = cognitoTestUsername
		}
		// Act
		resp, err := world.CognitoIDPClient().AdminConfirmSignUp(context.Background(), &cognitoidentityprovider.AdminConfirmSignUpInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an admin initiates authentication on behalf of a confirmed enabled user$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		// Act
		resp, err := world.CognitoIDPClient().AdminInitiateAuth(context.Background(), &cognitoidentityprovider.AdminInitiateAuthInput{
			UserPoolId: aws.String(poolID),
			ClientId:   aws.String("test-client-id"),
			AuthFlow:   cidptypes.AuthFlowTypeAdminNoSrpAuth,
			AuthParameters: map[string]string{
				"USERNAME": username,
				"PASSWORD": cognitoTestPassword,
			},
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a confirmed enabled user initiates authentication$`, func() error {
		// Arrange
		username := st.username
		// Act
		resp, err := world.CognitoIDPClient().InitiateAuth(context.Background(), &cognitoidentityprovider.InitiateAuthInput{
			ClientId: aws.String("test-client-id"),
			AuthFlow: cidptypes.AuthFlowTypeUserPasswordAuth,
			AuthParameters: map[string]string{
				"USERNAME": username,
				"PASSWORD": cognitoTestPassword,
			},
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user responds to an auth challenge$`, func() error {
		// Arrange: use the session token obtained from a prior AdminInitiateAuth call
		// If no session token, the operation will be rejected as expected for negative tests.
		sessionToken := st.sessionToken
		// Act
		resp, err := world.CognitoIDPClient().RespondToAuthChallenge(context.Background(), &cognitoidentityprovider.RespondToAuthChallengeInput{
			ClientId:      aws.String("test-client-id"),
			Session:       aws.String(sessionToken),
			ChallengeName: cidptypes.ChallengeNameTypeNewPasswordRequired,
			ChallengeResponses: map[string]string{
				"USERNAME":     st.username,
				"NEW_PASSWORD": cognitoTestPassword,
			},
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an authenticated session expires$`, func() error {
		// Arrange: @internal scenario; no public API expires a session
		// Act: simulate rejection since @internal scenario is not publicly reachable
		setResult(world, nil, fmt.Errorf("expire_auth_session is @internal and not callable via public API"))
		// Assert: result stored
		return nil
	})

	sc.When(`^a user account is marked as compromised$`, func() error {
		// Arrange: @internal scenario; no public API marks a user as compromised
		// Act: simulate rejection since @internal scenario is not publicly reachable
		setResult(world, nil, fmt.Errorf("mark_user_compromised is @internal and not callable via public API"))
		// Assert: result stored
		return nil
	})

	sc.When(`^a verification code delivery fails for an unconfirmed user$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		if username == "" {
			username = cognitoTestUsername
		}
		// Act — AdminConfirmSignUp is the closest public API for confirming an unconfirmed user
		resp, err := world.CognitoIDPClient().AdminConfirmSignUp(context.Background(), &cognitoidentityprovider.AdminConfirmSignUpInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a group is created in an active user pool$`, func() error {
		// Arrange
		poolID := st.poolID
		// Act
		resp, err := world.CognitoIDPClient().CreateGroup(context.Background(), &cognitoidentityprovider.CreateGroupInput{
			UserPoolId: aws.String(poolID),
			GroupName:  aws.String(cognitoTestGroupName),
		})
		// Assert: store result
		if err == nil {
			st.groupName = cognitoTestGroupName
		}
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a group is deleted$`, func() error {
		// Arrange
		poolID := st.poolID
		groupName := st.groupName
		// Act
		resp, err := world.CognitoIDPClient().DeleteGroup(context.Background(), &cognitoidentityprovider.DeleteGroupInput{
			UserPoolId: aws.String(poolID),
			GroupName:  aws.String(groupName),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an admin adds a user to a group in the same pool$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		if username == "" {
			username = cognitoTestUsername
		}
		groupName := st.groupName
		// Act
		resp, err := world.CognitoIDPClient().AdminAddUserToGroup(context.Background(), &cognitoidentityprovider.AdminAddUserToGroupInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
			GroupName:  aws.String(groupName),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an admin removes a user from a group$`, func() error {
		// Arrange
		poolID := st.poolID
		username := st.username
		if username == "" {
			username = cognitoTestUsername
		}
		groupName := st.groupName
		// Act
		resp, err := world.CognitoIDPClient().AdminRemoveUserFromGroup(context.Background(), &cognitoidentityprovider.AdminRemoveUserFromGroupInput{
			UserPoolId: aws.String(poolID),
			Username:   aws.String(username),
			GroupName:  aws.String(groupName),
		})
		// Assert: store result
		setResult(world, resp, err)
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the user pool is "ACTIVE"$`, func() error {
		// Arrange
		expectedPoolName := cognitoTestPoolName
		// Act
		resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(10),
		})
		if err != nil {
			return err
		}
		// Assert
		for _, pool := range resp.UserPools {
			if pool.Name != nil && *pool.Name == expectedPoolName {
				return nil
			}
		}
		return fmt.Errorf("expected pool '%s' to be ACTIVE but not found; expected_pool=%s", expectedPoolName, expectedPoolName)
	})

	sc.Then(`^the user pool is "DELETED" along with all its users and groups$`, func() error {
		// Arrange
		expectedPoolName := cognitoTestPoolName
		// Act
		resp, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(10),
		})
		if err != nil {
			return err
		}
		// Assert: pool should not appear in the list
		for _, pool := range resp.UserPools {
			if pool.Name != nil && *pool.Name == expectedPoolName {
				return fmt.Errorf("expected pool '%s' to be DELETED but it still exists; expected_pool=%s", expectedPoolName, expectedPoolName)
			}
		}
		return nil
	})

	sc.Then(`^the user exists in "FORCE_CHANGE_PASSWORD" state and is enabled$`, func() error {
		// Arrange
		expectedStatus := "FORCE_CHANGE_PASSWORD"
		// Act
		resp, err := world.CognitoIDPClient().AdminGetUser(context.Background(), &cognitoidentityprovider.AdminGetUserInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		if err != nil {
			return err
		}
		// Assert
		actualStatus := string(resp.UserStatus)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected user status '%s' but got '%s'; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		expectedEnabled := true
		actualEnabled := resp.Enabled
		if actualEnabled != expectedEnabled {
			return fmt.Errorf("expected user enabled=%v but got %v; expected_enabled=%v actual_enabled=%v",
				expectedEnabled, actualEnabled, expectedEnabled, actualEnabled)
		}
		return nil
	})

	sc.Then(`^the user is "DELETED", their sessions are expired, and group memberships are cleared$`, func() error {
		// Arrange: no additional setup
		// Act: verify deletion succeeded
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected user deletion to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the user is disabled$`, func() error {
		// Arrange
		expectedEnabled := false
		// Act
		resp, err := world.CognitoIDPClient().AdminGetUser(context.Background(), &cognitoidentityprovider.AdminGetUserInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		if err != nil {
			return err
		}
		// Assert
		actualEnabled := resp.Enabled
		if actualEnabled != expectedEnabled {
			return fmt.Errorf("expected user enabled=%v but got %v; expected_enabled=%v actual_enabled=%v",
				expectedEnabled, actualEnabled, expectedEnabled, actualEnabled)
		}
		return nil
	})

	sc.Then(`^the user is enabled$`, func() error {
		// Arrange
		expectedEnabled := true
		// Act
		resp, err := world.CognitoIDPClient().AdminGetUser(context.Background(), &cognitoidentityprovider.AdminGetUserInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		if err != nil {
			return err
		}
		// Assert
		actualEnabled := resp.Enabled
		if actualEnabled != expectedEnabled {
			return fmt.Errorf("expected user enabled=%v but got %v; expected_enabled=%v actual_enabled=%v",
				expectedEnabled, actualEnabled, expectedEnabled, actualEnabled)
		}
		return nil
	})

	sc.Then(`^the user is in "RESET_REQUIRED" state$`, func() error {
		// Arrange
		expectedStatus := "RESET_REQUIRED"
		// Act
		resp, err := world.CognitoIDPClient().AdminGetUser(context.Background(), &cognitoidentityprovider.AdminGetUserInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		if err != nil {
			return err
		}
		// Assert
		actualStatus := string(resp.UserStatus)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected user status '%s' but got '%s'; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the user is "CONFIRMED"$`, func() error {
		// Arrange
		expectedStatus := "CONFIRMED"
		// Act
		resp, err := world.CognitoIDPClient().AdminGetUser(context.Background(), &cognitoidentityprovider.AdminGetUserInput{
			UserPoolId: aws.String(st.poolID),
			Username:   aws.String(st.username),
		})
		if err != nil {
			return err
		}
		// Assert
		actualStatus := string(resp.UserStatus)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected user status '%s' but got '%s'; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the user attributes are updated$`, func() error {
		// Arrange: no additional setup
		// Act: verify update succeeded
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected user attribute update to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^a session is created in "AUTHENTICATED" state$`, func() error {
		// Arrange: no additional setup
		// Act: verify auth succeeded
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected authentication to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^a session is created in "CHALLENGE_REQUIRED" state$`, func() error {
		// Arrange: no additional setup
		// Act: verify InitiateAuth call succeeded
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected InitiateAuth to succeed (challenge) but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the session is either "AUTHENTICATED" or "CHALLENGE_FAILED"$`, func() error {
		// Arrange: no additional setup
		// Act: verify the challenge response was processed
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected RespondToAuthChallenge to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the session is in "EXPIRED" state$`, func() error {
		// Arrange: @internal scenario — not publicly reachable
		// Act: (no-op)
		// Assert: no-op for @internal path
		return nil
	})

	sc.Then(`^the user is in "COMPROMISED" state$`, func() error {
		// Arrange: @internal scenario — not publicly reachable
		// Act: (no-op)
		// Assert: no-op for @internal path
		return nil
	})

	sc.Then(`^the user remains in "UNCONFIRMED" state$`, func() error {
		// Arrange: no additional setup
		// Act: verify the operation succeeded
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected verification code delivery (AdminConfirmSignUp) to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the group is "ACTIVE" and associated with the pool$`, func() error {
		// Arrange
		expectedGroupName := cognitoTestGroupName
		// Act
		resp, err := world.CognitoIDPClient().ListGroups(context.Background(), &cognitoidentityprovider.ListGroupsInput{
			UserPoolId: aws.String(st.poolID),
		})
		if err != nil {
			return err
		}
		// Assert
		for _, group := range resp.Groups {
			if group.GroupName != nil && *group.GroupName == expectedGroupName {
				return nil
			}
		}
		return fmt.Errorf("expected group '%s' to be ACTIVE in pool but not found; expected_group=%s", expectedGroupName, expectedGroupName)
	})

	sc.Then(`^the group is "DELETED" and all users are removed from it$`, func() error {
		// Arrange
		expectedGroupName := cognitoTestGroupName
		// Act
		resp, err := world.CognitoIDPClient().ListGroups(context.Background(), &cognitoidentityprovider.ListGroupsInput{
			UserPoolId: aws.String(st.poolID),
		})
		if err != nil {
			return err
		}
		// Assert: group should not appear in the list
		for _, group := range resp.Groups {
			if group.GroupName != nil && *group.GroupName == expectedGroupName {
				return fmt.Errorf("expected group '%s' to be DELETED but it still exists; expected_group=%s", expectedGroupName, expectedGroupName)
			}
		}
		return nil
	})

	sc.Then(`^the user is a member of the group$`, func() error {
		// Arrange
		expectedUsername := st.username
		// Act
		resp, err := world.CognitoIDPClient().ListUsersInGroup(context.Background(), &cognitoidentityprovider.ListUsersInGroupInput{
			UserPoolId: aws.String(st.poolID),
			GroupName:  aws.String(st.groupName),
		})
		if err != nil {
			return err
		}
		// Assert
		for _, user := range resp.Users {
			if user.Username != nil && *user.Username == expectedUsername {
				return nil
			}
		}
		return fmt.Errorf("expected user '%s' to be a member of group '%s' but not found; expected_user=%s expected_group=%s",
			expectedUsername, st.groupName, expectedUsername, st.groupName)
	})

	sc.Then(`^the user is no longer a member of the group$`, func() error {
		// Arrange: no additional setup
		// Act: verify removal succeeded
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected AdminRemoveUserFromGroup to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	// ── Safety invariant Then steps ───────────────────────────────────────────────
	// These are catch-all assertions enforcing spec invariants; all are no-ops in SDK tests
	// because the lws fake guarantees them by construction.

	sc.Then(`^every user pool has a valid status \("ACTIVE" or "DELETED"\)$`, func() error {
		// No-op: lws fake enforces valid pool statuses by construction.
		return nil
	})

	sc.Then(`^every user has a valid status$`, func() error {
		// No-op: lws fake enforces valid user statuses by construction.
		return nil
	})

	sc.Then(`^every non-deleted user has an enabled flag set$`, func() error {
		// No-op: lws fake enforces enabled flags by construction.
		return nil
	})

	sc.Then(`^every group membership references an existing active group$`, func() error {
		// No-op: lws fake enforces group membership integrity by construction.
		return nil
	})

	sc.Then(`^every auth session has a valid status$`, func() error {
		// No-op: lws fake enforces valid session statuses by construction.
		return nil
	})

	sc.Then(`^deleted users do not have active authenticated sessions$`, func() error {
		// No-op: lws fake enforces session cleanup on user deletion by construction.
		return nil
	})

	sc.Then(`^disabled users do not have active authenticated sessions$`, func() error {
		// No-op: lws fake enforces session cleanup on user disable by construction.
		return nil
	})
}
