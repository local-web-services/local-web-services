package cognitoidp

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"
const region = "us-east-1"

// ── Data types ───────────────────────────────────────────────────────────────

type UserPool struct {
	ID               string
	Name             string
	ARN              string
	Status           string
	CreatedDate      float64
	LastModifiedDate float64
}

type UserStatus string

const (
	StatusUnconfirmed        UserStatus = "UNCONFIRMED"
	StatusConfirmed          UserStatus = "CONFIRMED"
	StatusForceChangePassword UserStatus = "FORCE_CHANGE_PASSWORD"
	StatusDisabled           UserStatus = "DISABLED"
	StatusCompromised        UserStatus = "COMPROMISED"
)

type User struct {
	Username         string
	Status           UserStatus
	Enabled          bool
	Password         string
	TempPassword     string
	Attributes       []map[string]string
	CreatedDate      float64
	LastModifiedDate float64
}

type Group struct {
	Name             string
	PoolID           string
	Description      string
	Precedence       int
	CreatedDate      float64
	LastModifiedDate float64
}

type UserPoolClient struct {
	ClientID         string
	ClientName       string
	PoolID           string
	CreatedDate      float64
	LastModifiedDate float64
}

type AuthSession struct {
	PoolID    string
	Username  string
	Challenge string
	CreatedAt float64
}

// ── Store ────────────────────────────────────────────────────────────────────

type Store struct {
	mu           sync.RWMutex
	pools        map[string]*UserPool
	users        map[string]map[string]*User        // poolID → username → user
	groups       map[string]map[string]*Group       // poolID → groupName → group
	groupMembers map[string]map[string]map[string]bool // poolID → groupName → username → bool
	clients      map[string]*UserPoolClient         // clientID → client
	authSessions map[string]*AuthSession
}

func NewStore() *Store {
	return &Store{
		pools:        make(map[string]*UserPool),
		users:        make(map[string]map[string]*User),
		groups:       make(map[string]map[string]*Group),
		groupMembers: make(map[string]map[string]map[string]bool),
		clients:      make(map[string]*UserPoolClient),
		authSessions: make(map[string]*AuthSession),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.pools = make(map[string]*UserPool)
	s.users = make(map[string]map[string]*User)
	s.groups = make(map[string]map[string]*Group)
	s.groupMembers = make(map[string]map[string]map[string]bool)
	s.clients = make(map[string]*UserPoolClient)
	s.authSessions = make(map[string]*AuthSession)
}

// ── Handler ──────────────────────────────────────────────────────────────────

type Handler struct {
	state *state.ServerState
	store *Store
}

func NewHandler(st *state.ServerState) *Handler {
	store := NewStore()
	st.AddResetCallback(store.Reset)
	return &Handler{state: st, store: store}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	target := r.Header.Get("X-Amz-Target")
	operation := ""
	if strings.HasPrefix(target, "AWSCognitoIdentityProviderService.") {
		operation = strings.TrimPrefix(target, "AWSCognitoIdentityProviderService.")
	} else {
		operation = target
	}

	if state.ApplyIAMAuth(h.state, "cognito-idp", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "cognito-idp", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if body == nil {
		body = make(map[string]interface{})
	}

	h.store.mu.Lock()
	defer h.store.mu.Unlock()

	h.handle(w, operation, body)
}

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	switch operation {

	// ── User Pools ────────────────────────────────────────────────────────────

	case "CreateUserPool":
		name := str(body, "PoolName")
		id := fmt.Sprintf("%s_%s", region, uuid9())
		now := nowSeconds()
		pool := &UserPool{
			ID:               id,
			Name:             name,
			ARN:              fmt.Sprintf("arn:aws:cognito-idp:%s:%s:userpool/%s", region, accountID, id),
			Status:           "Active",
			CreatedDate:      now,
			LastModifiedDate: now,
		}
		h.store.pools[id] = pool
		h.store.users[id] = make(map[string]*User)
		h.store.groups[id] = make(map[string]*Group)
		h.store.groupMembers[id] = make(map[string]map[string]bool)
		jsonOK(w, map[string]interface{}{
			"UserPool": poolToMap(pool),
		})

	case "DeleteUserPool":
		poolID := str(body, "UserPoolId")
		if _, ok := h.store.pools[poolID]; !ok {
			jsonErr(w, "ResourceNotFoundException", "User pool "+poolID+" not found")
			return
		}
		delete(h.store.pools, poolID)
		delete(h.store.users, poolID)
		delete(h.store.groups, poolID)
		delete(h.store.groupMembers, poolID)
		jsonOK(w, map[string]interface{}{})

	case "DescribeUserPool":
		poolID := str(body, "UserPoolId")
		pool, ok := h.store.pools[poolID]
		if !ok {
			jsonErr(w, "ResourceNotFoundException", "User pool "+poolID+" not found")
			return
		}
		jsonOK(w, map[string]interface{}{"UserPool": poolToMap(pool)})

	case "ListUserPools":
		pools := []map[string]interface{}{}
		for _, p := range h.store.pools {
			pools = append(pools, poolToMap(p))
		}
		jsonOK(w, map[string]interface{}{"UserPools": pools})

	case "UpdateUserPool":
		jsonOK(w, map[string]interface{}{})

	// ── User Pool Clients ─────────────────────────────────────────────────────

	case "CreateUserPoolClient":
		poolID := str(body, "UserPoolId")
		if _, ok := h.store.pools[poolID]; !ok {
			jsonErr(w, "ResourceNotFoundException", "User pool "+poolID+" not found")
			return
		}
		clientName := str(body, "ClientName")
		clientID := uuid26()
		now := nowSeconds()
		client := &UserPoolClient{
			ClientID:         clientID,
			ClientName:       clientName,
			PoolID:           poolID,
			CreatedDate:      now,
			LastModifiedDate: now,
		}
		h.store.clients[clientID] = client
		jsonOK(w, map[string]interface{}{"UserPoolClient": clientToMap(client)})

	case "DescribeUserPoolClient":
		clientID := str(body, "ClientId")
		client, ok := h.store.clients[clientID]
		if !ok {
			jsonErr(w, "ResourceNotFoundException", "Client "+clientID+" not found")
			return
		}
		jsonOK(w, map[string]interface{}{"UserPoolClient": clientToMap(client)})

	case "DeleteUserPoolClient":
		clientID := str(body, "ClientId")
		delete(h.store.clients, clientID)
		jsonOK(w, map[string]interface{}{})

	case "UpdateUserPoolClient", "ListUserPoolClients":
		jsonOK(w, map[string]interface{}{"UserPoolClients": []interface{}{}})

	// ── Users ─────────────────────────────────────────────────────────────────

	case "AdminCreateUser":
		poolID := str(body, "UserPoolId")
		if _, ok := h.store.pools[poolID]; !ok {
			jsonErr(w, "ResourceNotFoundException", "User pool "+poolID+" not found")
			return
		}
		username := str(body, "Username")
		if _, exists := h.store.users[poolID][username]; exists {
			jsonErr(w, "UsernameExistsException", "User "+username+" already exists")
			return
		}
		tempPass := str(body, "TemporaryPassword")
		attrs := parseAttrs(body["UserAttributes"])
		now := nowSeconds()
		status := StatusUnconfirmed
		if tempPass != "" {
			status = StatusForceChangePassword
		}
		user := &User{
			Username:         username,
			Status:           status,
			Enabled:          true,
			Password:         tempPass,
			TempPassword:     tempPass,
			Attributes:       attrs,
			CreatedDate:      now,
			LastModifiedDate: now,
		}
		h.store.users[poolID][username] = user
		jsonOK(w, map[string]interface{}{"User": userToMap(user)})

	case "AdminGetUser":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		user, ok := h.store.users[poolID][username]
		if !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		jsonOK(w, map[string]interface{}{
			"Username":             user.Username,
			"UserAttributes":       attrsToList(user.Attributes),
			"UserStatus":           string(user.Status),
			"Enabled":              user.Enabled,
			"UserCreateDate":       user.CreatedDate,
			"UserLastModifiedDate": user.LastModifiedDate,
		})

	case "AdminDeleteUser":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		if _, ok := h.store.users[poolID][username]; !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		delete(h.store.users[poolID], username)
		jsonOK(w, map[string]interface{}{})

	case "ListUsers":
		poolID := str(body, "UserPoolId")
		if _, ok := h.store.pools[poolID]; !ok {
			jsonErr(w, "ResourceNotFoundException", "User pool "+poolID+" not found")
			return
		}
		users := []map[string]interface{}{}
		for _, u := range h.store.users[poolID] {
			users = append(users, userShortToMap(u))
		}
		jsonOK(w, map[string]interface{}{"Users": users})

	case "AdminConfirmSignUp":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		user, ok := h.store.users[poolID][username]
		if !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		user.Status = StatusConfirmed
		user.LastModifiedDate = nowSeconds()
		jsonOK(w, map[string]interface{}{})

	case "AdminDisableUser":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		user, ok := h.store.users[poolID][username]
		if !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		user.Enabled = false
		user.LastModifiedDate = nowSeconds()
		jsonOK(w, map[string]interface{}{})

	case "AdminEnableUser":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		user, ok := h.store.users[poolID][username]
		if !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		user.Enabled = true
		user.LastModifiedDate = nowSeconds()
		jsonOK(w, map[string]interface{}{})

	case "AdminSetUserPassword":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		password := str(body, "Password")
		permanent, _ := body["Permanent"].(bool)
		user, ok := h.store.users[poolID][username]
		if !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		user.Password = password
		if permanent {
			user.Status = StatusConfirmed
			user.TempPassword = ""
		} else {
			user.TempPassword = password
			user.Status = StatusForceChangePassword
		}
		user.LastModifiedDate = nowSeconds()
		jsonOK(w, map[string]interface{}{})

	case "AdminResetUserPassword":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		user, ok := h.store.users[poolID][username]
		if !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		user.Status = StatusForceChangePassword
		user.TempPassword = ""
		user.LastModifiedDate = nowSeconds()
		jsonOK(w, map[string]interface{}{})

	case "AdminUpdateUserAttributes":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		user, ok := h.store.users[poolID][username]
		if !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		newAttrs := parseAttrs(body["UserAttributes"])
		for _, newAttr := range newAttrs {
			found := false
			for _, a := range user.Attributes {
				if a["Name"] == newAttr["Name"] {
					a["Value"] = newAttr["Value"]
					found = true
					break
				}
			}
			if !found {
				user.Attributes = append(user.Attributes, newAttr)
			}
		}
		user.LastModifiedDate = nowSeconds()
		jsonOK(w, map[string]interface{}{})

	case "AdminUserGlobalSignOut", "GlobalSignOut", "AdminSetUserMFAPreference", "SetUserMFAPreference":
		jsonOK(w, map[string]interface{}{})

	// ── Groups ─────────────────────────────────────────────────────────────────

	case "CreateGroup":
		poolID := str(body, "UserPoolId")
		if _, ok := h.store.pools[poolID]; !ok {
			jsonErr(w, "ResourceNotFoundException", "User pool "+poolID+" not found")
			return
		}
		groupName := str(body, "GroupName")
		if _, exists := h.store.groups[poolID][groupName]; exists {
			jsonErr(w, "GroupExistsException", "Group "+groupName+" already exists")
			return
		}
		now := nowSeconds()
		desc := str(body, "Description")
		prec := 0
		if p, ok := body["Precedence"].(float64); ok {
			prec = int(p)
		}
		group := &Group{
			Name:             groupName,
			PoolID:           poolID,
			Description:      desc,
			Precedence:       prec,
			CreatedDate:      now,
			LastModifiedDate: now,
		}
		h.store.groups[poolID][groupName] = group
		h.store.groupMembers[poolID][groupName] = make(map[string]bool)
		jsonOK(w, map[string]interface{}{"Group": groupToMap(group)})

	case "DeleteGroup":
		poolID := str(body, "UserPoolId")
		groupName := str(body, "GroupName")
		if _, ok := h.store.groups[poolID][groupName]; !ok {
			jsonErr(w, "ResourceNotFoundException", "Group "+groupName+" not found")
			return
		}
		delete(h.store.groups[poolID], groupName)
		delete(h.store.groupMembers[poolID], groupName)
		jsonOK(w, map[string]interface{}{})

	case "GetGroup":
		poolID := str(body, "UserPoolId")
		groupName := str(body, "GroupName")
		group, ok := h.store.groups[poolID][groupName]
		if !ok {
			jsonErr(w, "ResourceNotFoundException", "Group "+groupName+" not found")
			return
		}
		jsonOK(w, map[string]interface{}{"Group": groupToMap(group)})

	case "ListGroups":
		poolID := str(body, "UserPoolId")
		groups := []map[string]interface{}{}
		for _, g := range h.store.groups[poolID] {
			groups = append(groups, groupToMap(g))
		}
		jsonOK(w, map[string]interface{}{"Groups": groups})

	case "AdminAddUserToGroup":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		groupName := str(body, "GroupName")
		if _, ok := h.store.users[poolID][username]; !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		if _, ok := h.store.groups[poolID][groupName]; !ok {
			jsonErr(w, "ResourceNotFoundException", "Group "+groupName+" not found")
			return
		}
		if h.store.groupMembers[poolID][groupName] == nil {
			h.store.groupMembers[poolID][groupName] = make(map[string]bool)
		}
		h.store.groupMembers[poolID][groupName][username] = true
		jsonOK(w, map[string]interface{}{})

	case "AdminRemoveUserFromGroup":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		groupName := str(body, "GroupName")
		if members, ok := h.store.groupMembers[poolID][groupName]; ok {
			delete(members, username)
		}
		jsonOK(w, map[string]interface{}{})

	case "ListUsersInGroup":
		poolID := str(body, "UserPoolId")
		groupName := str(body, "GroupName")
		members := h.store.groupMembers[poolID][groupName]
		users := []map[string]interface{}{}
		for username := range members {
			if u, ok := h.store.users[poolID][username]; ok {
				users = append(users, userShortToMap(u))
			}
		}
		jsonOK(w, map[string]interface{}{"Users": users})

	case "AdminListGroupsForUser":
		poolID := str(body, "UserPoolId")
		username := str(body, "Username")
		groups := []map[string]interface{}{}
		for groupName, members := range h.store.groupMembers[poolID] {
			if members[username] {
				if g, ok := h.store.groups[poolID][groupName]; ok {
					groups = append(groups, groupToMap(g))
				}
			}
		}
		jsonOK(w, map[string]interface{}{"Groups": groups})

	// ── Auth ───────────────────────────────────────────────────────────────────

	case "AdminInitiateAuth":
		poolID := str(body, "UserPoolId")
		authFlow := str(body, "AuthFlow")
		authParams := strMap(body["AuthParameters"])
		result, err := h.doAuth(poolID, authFlow, authParams)
		if err != nil {
			jsonErr(w, errorType(err.Error()), err.Error())
			return
		}
		jsonOK(w, result)

	case "InitiateAuth":
		clientID := str(body, "ClientId")
		client, ok := h.store.clients[clientID]
		if !ok {
			jsonErr(w, "ResourceNotFoundException", "Client "+clientID+" not found")
			return
		}
		authFlow := str(body, "AuthFlow")
		authParams := strMap(body["AuthParameters"])
		result, err := h.doAuth(client.PoolID, authFlow, authParams)
		if err != nil {
			jsonErr(w, errorType(err.Error()), err.Error())
			return
		}
		jsonOK(w, result)

	case "RespondToAuthChallenge", "AdminRespondToAuthChallenge":
		sessionToken := str(body, "Session")
		challengeName := str(body, "ChallengeName")
		responses := strMap(body["ChallengeResponses"])
		session, ok := h.store.authSessions[sessionToken]
		if !ok {
			jsonErr(w, "NotAuthorizedException", "Invalid session")
			return
		}
		delete(h.store.authSessions, sessionToken)
		if challengeName == "NEW_PASSWORD_REQUIRED" {
			newPassword, ok := responses["NEW_PASSWORD"]
			if !ok {
				jsonErr(w, "InvalidParameterException", "NEW_PASSWORD required")
				return
			}
			user := h.store.users[session.PoolID][session.Username]
			user.Password = newPassword
			user.Status = StatusConfirmed
			user.TempPassword = ""
			user.LastModifiedDate = nowSeconds()
			tokens := makeTokens(session.PoolID, session.Username, user.Attributes)
			jsonOK(w, map[string]interface{}{"AuthenticationResult": tokens})
		} else {
			jsonErr(w, "NotAuthorizedException", "Challenge "+challengeName+" not supported")
		}

	case "SignUp":
		clientID := str(body, "ClientId")
		client, ok := h.store.clients[clientID]
		if !ok {
			jsonErr(w, "ResourceNotFoundException", "Client not found")
			return
		}
		username := str(body, "Username")
		password := str(body, "Password")
		attrs := parseAttrs(body["UserAttributes"])
		if _, exists := h.store.users[client.PoolID][username]; exists {
			jsonErr(w, "UsernameExistsException", "User "+username+" already exists")
			return
		}
		now := nowSeconds()
		user := &User{
			Username:         username,
			Status:           StatusUnconfirmed,
			Enabled:          true,
			Password:         password,
			Attributes:       attrs,
			CreatedDate:      now,
			LastModifiedDate: now,
		}
		h.store.users[client.PoolID][username] = user
		jsonOK(w, map[string]interface{}{"UserConfirmed": false, "UserSub": username})

	case "ConfirmSignUp":
		clientID := str(body, "ClientId")
		client, ok := h.store.clients[clientID]
		if !ok {
			jsonErr(w, "ResourceNotFoundException", "Client not found")
			return
		}
		username := str(body, "Username")
		user, ok := h.store.users[client.PoolID][username]
		if !ok {
			jsonErr(w, "UserNotFoundException", "User "+username+" not found")
			return
		}
		user.Status = StatusConfirmed
		user.LastModifiedDate = nowSeconds()
		jsonOK(w, map[string]interface{}{})

	case "ForgotPassword":
		jsonOK(w, map[string]interface{}{
			"CodeDeliveryDetails": map[string]interface{}{
				"Destination":   "***@example.com",
				"DeliveryMedium": "EMAIL",
				"AttributeName": "email",
			},
		})

	case "ConfirmForgotPassword":
		jsonOK(w, map[string]interface{}{})

	case "ChangePassword", "GetUser", "UpdateUserAttributes":
		jsonOK(w, map[string]interface{}{"UserAttributes": []interface{}{}})

	default:
		w.Header().Set("Content-Type", "application/x-amz-json-1.1")
		w.WriteHeader(400)
		json.NewEncoder(w).Encode(map[string]interface{}{ //nolint:errcheck
			"__type":  "UnknownOperationException",
			"message": fmt.Sprintf("lws: CognitoIDP operation '%s' is not yet implemented", operation),
		})
	}
}

// ── Auth helper ───────────────────────────────────────────────────────────────

func (h *Handler) doAuth(poolID, authFlow string, authParams map[string]string) (map[string]interface{}, error) {
	if _, ok := h.store.pools[poolID]; !ok {
		return nil, fmt.Errorf("ResourceNotFoundException: User pool %s not found", poolID)
	}
	if authFlow == "ADMIN_USER_PASSWORD_AUTH" {
		username := authParams["USERNAME"]
		password := authParams["PASSWORD"]
		user, ok := h.store.users[poolID][username]
		if !ok {
			return nil, fmt.Errorf("UserNotFoundException: User %s not found", username)
		}
		if !user.Enabled {
			return nil, fmt.Errorf("NotAuthorizedException: User is disabled")
		}
		if user.Password != password && user.TempPassword != password {
			return nil, fmt.Errorf("NotAuthorizedException: Incorrect username or password")
		}
		if user.Status == StatusForceChangePassword {
			sessionToken := fmt.Sprintf("lws-session-%s", uuid26())
			h.store.authSessions[sessionToken] = &AuthSession{
				PoolID:    poolID,
				Username:  username,
				Challenge: "NEW_PASSWORD_REQUIRED",
				CreatedAt: nowSeconds(),
			}
			return map[string]interface{}{
				"ChallengeName":       "NEW_PASSWORD_REQUIRED",
				"Session":             sessionToken,
				"ChallengeParameters": map[string]interface{}{"USER_ID_FOR_SRP": username},
			}, nil
		}
		tokens := makeTokens(poolID, username, user.Attributes)
		return map[string]interface{}{"AuthenticationResult": tokens}, nil
	}
	if authFlow == "REFRESH_TOKEN_AUTH" || authFlow == "REFRESH_TOKEN" {
		username := authParams["USERNAME"]
		user, ok := h.store.users[poolID][username]
		if !ok {
			return nil, fmt.Errorf("NotAuthorizedException: Invalid refresh token")
		}
		tokens := makeTokens(poolID, username, user.Attributes)
		return map[string]interface{}{"AuthenticationResult": tokens}, nil
	}
	return nil, fmt.Errorf("NotAuthorizedException: Auth flow %s not supported", authFlow)
}

// ── Helpers ───────────────────────────────────────────────────────────────────

func nowSeconds() float64 {
	return float64(time.Now().UnixMilli()) / 1000.0
}

func uuid9() string {
	s := fmt.Sprintf("%016x", time.Now().UnixNano())
	if len(s) > 9 {
		return s[:9]
	}
	return s
}

func uuid26() string {
	t := fmt.Sprintf("%016x%016x", time.Now().UnixNano(), time.Now().UnixNano()+1)
	if len(t) > 26 {
		return t[:26]
	}
	return t
}

func b64url(s string) string {
	return base64.RawURLEncoding.EncodeToString([]byte(s))
}

func makeTokens(poolID, username string, attrs []map[string]string) map[string]interface{} {
	now := time.Now().Unix()
	exp := now + 3600
	sub := fmt.Sprintf("%016x", now)

	idHeader := b64url(`{"alg":"RS256","kid":"lws-local","typ":"JWT"}`)
	idPayload := b64url(fmt.Sprintf(`{"sub":"%s","iss":"https://cognito-idp.%s.amazonaws.com/%s","aud":"lws-local-client","token_use":"id","cognito_username":"%s","iat":%d,"exp":%d}`,
		sub, region, poolID, username, now, exp))
	idSig := b64url("lws-local-test-sig")
	idToken := idHeader + "." + idPayload + "." + idSig

	accessHeader := b64url(`{"alg":"RS256","kid":"lws-local","typ":"JWT"}`)
	accessPayload := b64url(fmt.Sprintf(`{"sub":"%s","iss":"https://cognito-idp.%s.amazonaws.com/%s","token_use":"access","username":"%s","iat":%d,"exp":%d}`,
		sub, region, poolID, username, now, exp))
	accessSig := b64url("lws-local-test-sig")
	accessToken := accessHeader + "." + accessPayload + "." + accessSig

	return map[string]interface{}{
		"IdToken":      idToken,
		"AccessToken":  accessToken,
		"RefreshToken": fmt.Sprintf("lws-refresh-%s", uuid26()),
		"ExpiresIn":    3600,
		"TokenType":    "Bearer",
	}
}

func errorType(msg string) string {
	switch {
	case strings.Contains(msg, "UserNotFoundException"):
		return "UserNotFoundException"
	case strings.Contains(msg, "UsernameExistsException"):
		return "UsernameExistsException"
	case strings.Contains(msg, "ResourceNotFoundException"):
		return "ResourceNotFoundException"
	case strings.Contains(msg, "GroupExistsException"):
		return "GroupExistsException"
	case strings.Contains(msg, "NotAuthorizedException"):
		return "NotAuthorizedException"
	case strings.Contains(msg, "InvalidParameterException"):
		return "InvalidParameterException"
	default:
		return "InvalidRequestException"
	}
}

func str(body map[string]interface{}, key string) string {
	v, _ := body[key].(string)
	return v
}

func strMap(v interface{}) map[string]string {
	result := make(map[string]string)
	if m, ok := v.(map[string]interface{}); ok {
		for k, val := range m {
			if s, ok := val.(string); ok {
				result[k] = s
			}
		}
	}
	return result
}

func parseAttrs(v interface{}) []map[string]string {
	var attrs []map[string]string
	if list, ok := v.([]interface{}); ok {
		for _, item := range list {
			if m, ok := item.(map[string]interface{}); ok {
				attr := map[string]string{}
				if n, ok := m["Name"].(string); ok {
					attr["Name"] = n
				}
				if val, ok := m["Value"].(string); ok {
					attr["Value"] = val
				}
				attrs = append(attrs, attr)
			}
		}
	}
	return attrs
}

func attrsToList(attrs []map[string]string) []map[string]string {
	if attrs == nil {
		return []map[string]string{}
	}
	return attrs
}

func poolToMap(p *UserPool) map[string]interface{} {
	return map[string]interface{}{
		"Id":               p.ID,
		"Name":             p.Name,
		"Arn":              p.ARN,
		"Status":           p.Status,
		"CreationDate":     p.CreatedDate,
		"LastModifiedDate": p.LastModifiedDate,
	}
}

func userToMap(u *User) map[string]interface{} {
	return map[string]interface{}{
		"Username":             u.Username,
		"UserStatus":           string(u.Status),
		"Enabled":              u.Enabled,
		"UserAttributes":       attrsToList(u.Attributes),
		"UserCreateDate":       u.CreatedDate,
		"UserLastModifiedDate": u.LastModifiedDate,
		"MFAOptions":           []interface{}{},
	}
}

func userShortToMap(u *User) map[string]interface{} {
	return map[string]interface{}{
		"Username":             u.Username,
		"UserStatus":           string(u.Status),
		"Enabled":              u.Enabled,
		"Attributes":           attrsToList(u.Attributes),
		"UserCreateDate":       u.CreatedDate,
		"UserLastModifiedDate": u.LastModifiedDate,
	}
}

func groupToMap(g *Group) map[string]interface{} {
	return map[string]interface{}{
		"GroupName":        g.Name,
		"UserPoolId":       g.PoolID,
		"Description":      g.Description,
		"Precedence":       g.Precedence,
		"CreationDate":     g.CreatedDate,
		"LastModifiedDate": g.LastModifiedDate,
	}
}

func clientToMap(c *UserPoolClient) map[string]interface{} {
	return map[string]interface{}{
		"ClientId":         c.ClientID,
		"ClientName":       c.ClientName,
		"UserPoolId":       c.PoolID,
		"CreationDate":     c.CreatedDate,
		"LastModifiedDate": c.LastModifiedDate,
	}
}

func jsonOK(w http.ResponseWriter, body interface{}) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(body) //nolint:errcheck
}

func jsonErr(w http.ResponseWriter, errType, message string) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(400)
	json.NewEncoder(w).Encode(map[string]interface{}{ //nolint:errcheck
		"__type":  errType,
		"message": message,
	})
}
