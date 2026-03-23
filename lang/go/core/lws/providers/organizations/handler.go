package organizations

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"sync"
	"sync/atomic"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"

var targetPrefixes = []string{
	"AmazonOrganizationsV20161128.",
	"AWSOrganizationsV20161128.",
}

var orgCounter uint64
var rootCounter uint64
var ouCounter uint64
var policyCounter uint64
var accountCounter uint64

func nextOrgID() string    { return fmt.Sprintf("o-%04x", atomic.AddUint64(&orgCounter, 1)) }
func nextRootID() string   { return fmt.Sprintf("r-%04x", atomic.AddUint64(&rootCounter, 1)) }
func nextOUID() string     { return fmt.Sprintf("ou-%08x", atomic.AddUint64(&ouCounter, 1)) }
func nextPolicyID() string { return fmt.Sprintf("p-%08x", atomic.AddUint64(&policyCounter, 1)) }
func nextAccountNum() string {
	n := atomic.AddUint64(&accountCounter, 1)
	return fmt.Sprintf("%012d", n)
}

func orgARN(orgID string) string {
	return fmt.Sprintf("arn:aws:organizations::%s:organization/%s", accountID, orgID)
}
func rootARN(orgID, rootID string) string {
	return fmt.Sprintf("arn:aws:organizations::%s:root/%s/%s", accountID, orgID, rootID)
}
func ouARN(orgID, ouID string) string {
	return fmt.Sprintf("arn:aws:organizations::%s:ou/%s/%s", accountID, orgID, ouID)
}
func acctARN(acctID string) string {
	return fmt.Sprintf("arn:aws:organizations::%s:account/%s", accountID, acctID)
}
func policyARN(orgID, polID string) string {
	return fmt.Sprintf("arn:aws:organizations::%s:policy/%s/service_control_policy/%s", accountID, orgID, polID)
}

// Store holds the in-memory state for the Organizations service.
type Store struct {
	mu                sync.RWMutex
	organization      map[string]interface{}
	root              map[string]interface{}
	ous               map[string]map[string]interface{}
	accounts          map[string]map[string]interface{}
	accountParents    map[string]string
	policies          map[string]map[string]interface{}
	policyAttachments map[string]map[string]bool // policyID -> set of targetIDs
}

func NewStore() *Store {
	return &Store{
		ous:               make(map[string]map[string]interface{}),
		accounts:          make(map[string]map[string]interface{}),
		accountParents:    make(map[string]string),
		policies:          make(map[string]map[string]interface{}),
		policyAttachments: make(map[string]map[string]bool),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.organization = nil
	s.root = nil
	s.ous = make(map[string]map[string]interface{})
	s.accounts = make(map[string]map[string]interface{})
	s.accountParents = make(map[string]string)
	s.policies = make(map[string]map[string]interface{})
	s.policyAttachments = make(map[string]map[string]bool)
}

// Handler is the HTTP handler for the Organizations service.
type Handler struct {
	state *state.ServerState
	store *Store
}

// NewHandler creates a new Organizations handler.
func NewHandler(st *state.ServerState) *Handler {
	store := NewStore()
	st.AddResetCallback(store.Reset)
	return &Handler{state: st, store: store}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	target := r.Header.Get("X-Amz-Target")
	operation := target
	for _, prefix := range targetPrefixes {
		if strings.HasPrefix(target, prefix) {
			operation = strings.TrimPrefix(target, prefix)
			break
		}
	}

	if state.ApplyChaos(h.state, "organizations", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(w, operation, body)
}

func writeOK(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(data) //nolint:errcheck
}

func writeErr(w http.ResponseWriter, code, msg string, status int) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(status)
	fmt.Fprintf(w, `{"__type":%q,"message":%q}`+"\n", code, msg) //nolint:errcheck
}

func str(m map[string]interface{}, key string) string {
	if v, ok := m[key].(string); ok {
		return v
	}
	return ""
}

func (h *Handler) parentExists(parentID string) bool {
	if h.store.root != nil && h.store.root["Id"] == parentID {
		return true
	}
	_, ok := h.store.ous[parentID]
	return ok
}

func (h *Handler) targetType(targetID string) string {
	if h.store.root != nil && h.store.root["Id"] == targetID {
		return "ROOT"
	}
	if _, ok := h.store.ous[targetID]; ok {
		return "ORGANIZATIONAL_UNIT"
	}
	if _, ok := h.store.accounts[targetID]; ok {
		return "ACCOUNT"
	}
	return ""
}

func (h *Handler) ouHasChildren(ouID string) bool {
	for _, parentID := range h.store.accountParents {
		if parentID == ouID {
			return true
		}
	}
	for _, ou := range h.store.ous {
		if ou["ParentId"] == ouID {
			return true
		}
	}
	return false
}

func (h *Handler) ouHasAttachedPolicies(ouID string) bool {
	for _, targets := range h.store.policyAttachments {
		if targets[ouID] {
			return true
		}
	}
	return false
}

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	h.store.mu.Lock()
	defer h.store.mu.Unlock()

	switch operation {
	case "CreateOrganization":
		if h.store.organization != nil {
			writeErr(w, "AlreadyInOrganizationException", "The account is already a member of an organization.", 409)
			return
		}
		featureSet := str(body, "FeatureSet")
		if featureSet == "" {
			featureSet = "ALL"
		}
		orgID := nextOrgID()
		rootID := nextRootID()
		org := map[string]interface{}{
			"Id": orgID, "Arn": orgARN(orgID), "FeatureSet": featureSet,
			"MasterAccountId":      accountID,
			"MasterAccountArn":     fmt.Sprintf("arn:aws:organizations::%s:account/%s/%s", accountID, orgID, accountID),
			"MasterAccountEmail":   "master@example.com",
			"AvailablePolicyTypes": []interface{}{map[string]interface{}{"Type": "SERVICE_CONTROL_POLICY", "Status": "ENABLED"}},
		}
		root := map[string]interface{}{
			"Id": rootID, "Arn": rootARN(orgID, rootID), "Name": "Root",
			"PolicyTypes": []interface{}{map[string]interface{}{"Type": "SERVICE_CONTROL_POLICY", "Status": "ENABLED"}},
		}
		h.store.organization = org
		h.store.root = root
		writeOK(w, map[string]interface{}{"Organization": org})

	case "DescribeOrganization":
		if h.store.organization == nil {
			writeErr(w, "AWSOrganizationsNotInUseException", "Your account is not a member of an organization.", 400)
			return
		}
		writeOK(w, map[string]interface{}{"Organization": h.store.organization})

	case "ListRoots":
		roots := []interface{}{}
		if h.store.root != nil {
			roots = []interface{}{h.store.root}
		}
		writeOK(w, map[string]interface{}{"Roots": roots})

	case "CreateAccount":
		if h.store.organization == nil {
			writeErr(w, "AWSOrganizationsNotInUseException", "Your account is not a member of an organization.", 400)
			return
		}
		email := str(body, "Email")
		for _, acct := range h.store.accounts {
			if acct["Email"] == email {
				writeErr(w, "DuplicateAccountException", fmt.Sprintf("An account with email '%s' already exists.", email), 409)
				return
			}
		}
		acctID := nextAccountNum()
		name := str(body, "AccountName")
		ts := float64(time.Now().Unix())
		acct := map[string]interface{}{
			"Id": acctID, "Arn": acctARN(acctID), "Name": name, "Email": email,
			"Status": "ACTIVE", "JoinedMethod": "CREATED", "JoinedTimestamp": ts,
		}
		h.store.accounts[acctID] = acct
		h.store.accountParents[acctID] = h.store.root["Id"].(string)
		writeOK(w, map[string]interface{}{
			"CreateAccountStatus": map[string]interface{}{
				"State": "SUCCEEDED", "AccountId": acctID, "AccountName": name, "RequestedTimestamp": ts,
			},
		})

	case "DescribeAccount":
		acctID := str(body, "AccountId")
		acct, ok := h.store.accounts[acctID]
		if !ok {
			writeErr(w, "AccountNotFoundException", fmt.Sprintf("Account '%s' does not exist.", acctID), 400)
			return
		}
		writeOK(w, map[string]interface{}{"Account": acct})

	case "ListAccounts":
		accts := make([]interface{}, 0, len(h.store.accounts))
		for _, a := range h.store.accounts {
			accts = append(accts, a)
		}
		writeOK(w, map[string]interface{}{"Accounts": accts})

	case "ListAccountsForParent":
		parentID := str(body, "ParentId")
		accts := []interface{}{}
		for acctID, acct := range h.store.accounts {
			if h.store.accountParents[acctID] == parentID {
				accts = append(accts, acct)
			}
		}
		writeOK(w, map[string]interface{}{"Accounts": accts})

	case "CreateOrganizationalUnit":
		if h.store.organization == nil {
			writeErr(w, "AWSOrganizationsNotInUseException", "Your account is not a member of an organization.", 400)
			return
		}
		parentID := str(body, "ParentId")
		name := str(body, "Name")
		if !h.parentExists(parentID) {
			writeErr(w, "ParentNotFoundException", fmt.Sprintf("Parent '%s' does not exist.", parentID), 400)
			return
		}
		for _, ou := range h.store.ous {
			if ou["ParentId"] == parentID && ou["Name"] == name {
				writeErr(w, "DuplicateOrganizationalUnitException", fmt.Sprintf("An OU named '%s' already exists under parent '%s'.", name, parentID), 409)
				return
			}
		}
		orgID := h.store.organization["Id"].(string)
		ouID := nextOUID()
		ou := map[string]interface{}{
			"Id": ouID, "Arn": ouARN(orgID, ouID), "Name": name, "ParentId": parentID,
		}
		h.store.ous[ouID] = ou
		writeOK(w, map[string]interface{}{"OrganizationalUnit": ou})

	case "DescribeOrganizationalUnit":
		ouID := str(body, "OrganizationalUnitId")
		ou, ok := h.store.ous[ouID]
		if !ok {
			writeErr(w, "OrganizationalUnitNotFoundException", fmt.Sprintf("Organizational unit '%s' does not exist.", ouID), 400)
			return
		}
		writeOK(w, map[string]interface{}{"OrganizationalUnit": ou})

	case "ListOrganizationalUnitsForParent":
		parentID := str(body, "ParentId")
		ous := []interface{}{}
		for _, ou := range h.store.ous {
			if ou["ParentId"] == parentID {
				ous = append(ous, ou)
			}
		}
		writeOK(w, map[string]interface{}{"OrganizationalUnits": ous})

	case "DeleteOrganizationalUnit":
		ouID := str(body, "OrganizationalUnitId")
		if _, ok := h.store.ous[ouID]; !ok {
			writeErr(w, "OrganizationalUnitNotFoundException", fmt.Sprintf("Organizational unit '%s' does not exist.", ouID), 400)
			return
		}
		if h.ouHasChildren(ouID) {
			writeErr(w, "OrganizationalUnitNotEmptyException", fmt.Sprintf("Organizational unit '%s' is not empty.", ouID), 400)
			return
		}
		if h.ouHasAttachedPolicies(ouID) {
			writeErr(w, "PolicyChangesInProgressException", fmt.Sprintf("Organizational unit '%s' has policies attached.", ouID), 400)
			return
		}
		delete(h.store.ous, ouID)
		writeOK(w, map[string]interface{}{})

	case "MoveAccount":
		acctID := str(body, "AccountId")
		srcID := str(body, "SourceParentId")
		dstID := str(body, "DestinationParentId")
		if _, ok := h.store.accounts[acctID]; !ok {
			writeErr(w, "AccountNotFoundException", fmt.Sprintf("Account '%s' does not exist.", acctID), 400)
			return
		}
		if h.store.accountParents[acctID] != srcID {
			writeErr(w, "SourceParentNotFoundException", fmt.Sprintf("Account '%s' is not under source parent '%s'.", acctID, srcID), 400)
			return
		}
		if !h.parentExists(dstID) {
			writeErr(w, "DestinationParentNotFoundException", fmt.Sprintf("Destination parent '%s' does not exist.", dstID), 400)
			return
		}
		h.store.accountParents[acctID] = dstID
		writeOK(w, map[string]interface{}{})

	case "CreatePolicy":
		if h.store.organization == nil {
			writeErr(w, "AWSOrganizationsNotInUseException", "Your account is not a member of an organization.", 400)
			return
		}
		name := str(body, "Name")
		polType := str(body, "Type")
		if polType == "" {
			polType = "SERVICE_CONTROL_POLICY"
		}
		for _, pol := range h.store.policies {
			summary := pol["PolicySummary"].(map[string]interface{})
			if summary["Name"] == name && summary["Type"] == polType {
				writeErr(w, "DuplicatePolicyException", fmt.Sprintf("A policy named '%s' of type '%s' already exists.", name, polType), 409)
				return
			}
		}
		orgID := h.store.organization["Id"].(string)
		polID := nextPolicyID()
		desc := str(body, "Description")
		content := str(body, "Content")
		if content == "" {
			content = "{}"
		}
		policy := map[string]interface{}{
			"PolicySummary": map[string]interface{}{
				"Id": polID, "Arn": policyARN(orgID, polID), "Name": name,
				"Description": desc, "Type": polType, "AwsManaged": false,
			},
			"Content": content,
		}
		h.store.policies[polID] = policy
		writeOK(w, map[string]interface{}{"Policy": policy})

	case "DescribePolicy":
		polID := str(body, "PolicyId")
		pol, ok := h.store.policies[polID]
		if !ok {
			writeErr(w, "PolicyNotFoundException", fmt.Sprintf("Policy '%s' does not exist.", polID), 400)
			return
		}
		writeOK(w, map[string]interface{}{"Policy": pol})

	case "ListPolicies":
		filter := str(body, "Filter")
		policies := []interface{}{}
		for _, pol := range h.store.policies {
			summary := pol["PolicySummary"].(map[string]interface{})
			if filter == "" || summary["Type"] == filter {
				policies = append(policies, summary)
			}
		}
		writeOK(w, map[string]interface{}{"Policies": policies})

	case "AttachPolicy":
		polID := str(body, "PolicyId")
		targetID := str(body, "TargetId")
		if _, ok := h.store.policies[polID]; !ok {
			writeErr(w, "PolicyNotFoundException", fmt.Sprintf("Policy '%s' does not exist.", polID), 400)
			return
		}
		if h.targetType(targetID) == "" {
			writeErr(w, "TargetNotFoundException", fmt.Sprintf("Target '%s' does not exist.", targetID), 400)
			return
		}
		if h.store.policyAttachments[polID] == nil {
			h.store.policyAttachments[polID] = make(map[string]bool)
		}
		if h.store.policyAttachments[polID][targetID] {
			writeErr(w, "DuplicatePolicyAttachmentException", fmt.Sprintf("Policy '%s' is already attached to target '%s'.", polID, targetID), 409)
			return
		}
		h.store.policyAttachments[polID][targetID] = true
		writeOK(w, map[string]interface{}{})

	case "DetachPolicy":
		polID := str(body, "PolicyId")
		targetID := str(body, "TargetId")
		if !h.store.policyAttachments[polID][targetID] {
			writeErr(w, "PolicyNotAttachedException", fmt.Sprintf("Policy '%s' is not attached to target '%s'.", polID, targetID), 400)
			return
		}
		delete(h.store.policyAttachments[polID], targetID)
		writeOK(w, map[string]interface{}{})

	case "ListPoliciesForTarget":
		targetID := str(body, "TargetId")
		filter := str(body, "Filter")
		policies := []interface{}{}
		for polID, targets := range h.store.policyAttachments {
			if !targets[targetID] {
				continue
			}
			pol, ok := h.store.policies[polID]
			if !ok {
				continue
			}
			summary := pol["PolicySummary"].(map[string]interface{})
			if filter != "" && summary["Type"] != filter {
				continue
			}
			policies = append(policies, summary)
		}
		writeOK(w, map[string]interface{}{"Policies": policies})

	case "ListTargetsForPolicy":
		polID := str(body, "PolicyId")
		if _, ok := h.store.policies[polID]; !ok {
			writeErr(w, "PolicyNotFoundException", fmt.Sprintf("Policy '%s' does not exist.", polID), 400)
			return
		}
		targets := []interface{}{}
		for targetID := range h.store.policyAttachments[polID] {
			ttype := h.targetType(targetID)
			if ttype == "" {
				continue
			}
			targets = append(targets, map[string]interface{}{"TargetId": targetID, "Type": ttype})
		}
		writeOK(w, map[string]interface{}{"Targets": targets})

	default:
		writeErr(w, "InvalidAction", "lws: Organizations operation '"+operation+"' is not yet implemented", 400)
	}
}
