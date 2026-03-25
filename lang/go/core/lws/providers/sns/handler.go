package sns

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"strings"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"
const region = "us-east-1"

// MessageAttribute is a single SNS message attribute.
type MessageAttribute struct {
	DataType    string
	StringValue string
}

// Subscription holds all state for a single SNS subscription.
type Subscription struct {
	SubscriptionArn string
	TopicArn        string
	Protocol        string
	Endpoint        string
	// FilterPolicy maps attribute name -> list of allowed values.
	FilterPolicy map[string][]string
	// Attributes holds arbitrary subscription attributes (for GetSubscriptionAttributes).
	Attributes map[string]string
}

// Topic holds all state for a single SNS topic.
type Topic struct {
	Arn           string
	Name          string
	Attributes    map[string]string
	Subscriptions []*Subscription
	Tags          []map[string]string
}

// Store is the in-memory state store for SNS.
type Store struct {
	mu     sync.RWMutex
	topics map[string]*Topic // keyed by ARN
	// subsIndex maps SubscriptionArn -> *Subscription for fast lookup.
	subsIndex map[string]*Subscription
}

// NewStore creates an empty Store.
func NewStore() *Store {
	return &Store{
		topics:    make(map[string]*Topic),
		subsIndex: make(map[string]*Subscription),
	}
}

// Reset clears all state.
func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.topics = make(map[string]*Topic)
	s.subsIndex = make(map[string]*Subscription)
}

func topicARN(name string) string {
	return fmt.Sprintf("arn:aws:sns:%s:%s:%s", region, accountID, name)
}

// createTopic creates a topic, returning (topic, true) on creation or (existing, false) if already exists.
func (s *Store) createTopic(name string) (*Topic, bool) {
	s.mu.Lock()
	defer s.mu.Unlock()
	arn := topicARN(name)
	if t, ok := s.topics[arn]; ok {
		return t, false
	}
	t := &Topic{
		Arn:        arn,
		Name:       name,
		Attributes: map[string]string{"TopicArn": arn, "DisplayName": name},
	}
	s.topics[arn] = t
	return t, true
}

func (s *Store) getTopic(arn string) *Topic {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.topics[arn]
}

func (s *Store) deleteTopic(arn string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if t, ok := s.topics[arn]; ok {
		for _, sub := range t.Subscriptions {
			delete(s.subsIndex, sub.SubscriptionArn)
		}
	}
	delete(s.topics, arn)
}

func (s *Store) listTopics() []*Topic {
	s.mu.RLock()
	defer s.mu.RUnlock()
	var result []*Topic
	for _, t := range s.topics {
		result = append(result, t)
	}
	return result
}

// subscribe adds a subscription to a topic and returns (subscriptionArn, true) or ("", false) if topic not found.
func (s *Store) subscribe(topicArn, protocol, endpoint string, filterPolicy map[string][]string) (string, bool) {
	s.mu.Lock()
	defer s.mu.Unlock()
	t, ok := s.topics[topicArn]
	if !ok {
		return "", false
	}
	subArn := fmt.Sprintf("%s:%d", topicArn, time.Now().UnixNano())
	attrs := map[string]string{
		"SubscriptionArn": subArn,
		"TopicArn":        topicArn,
		"Protocol":        protocol,
		"Endpoint":        endpoint,
		"Owner":           accountID,
	}
	if filterPolicy != nil {
		fp, _ := json.Marshal(filterPolicy)
		attrs["FilterPolicy"] = string(fp)
	}
	sub := &Subscription{
		SubscriptionArn: subArn,
		TopicArn:        topicArn,
		Protocol:        protocol,
		Endpoint:        endpoint,
		FilterPolicy:    filterPolicy,
		Attributes:      attrs,
	}
	t.Subscriptions = append(t.Subscriptions, sub)
	s.subsIndex[subArn] = sub
	return subArn, true
}

// unsubscribe removes a subscription by ARN, returning true if found.
func (s *Store) unsubscribe(subArn string) bool {
	s.mu.Lock()
	defer s.mu.Unlock()
	sub, ok := s.subsIndex[subArn]
	if !ok {
		return false
	}
	t, ok := s.topics[sub.TopicArn]
	if ok {
		filtered := t.Subscriptions[:0]
		for _, existing := range t.Subscriptions {
			if existing.SubscriptionArn != subArn {
				filtered = append(filtered, existing)
			}
		}
		t.Subscriptions = filtered
	}
	delete(s.subsIndex, subArn)
	return true
}

func (s *Store) getSubscription(subArn string) *Subscription {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.subsIndex[subArn]
}

func (s *Store) listAllSubscriptions() []*Subscription {
	s.mu.RLock()
	defer s.mu.RUnlock()
	var result []*Subscription
	for _, t := range s.topics {
		result = append(result, t.Subscriptions...)
	}
	return result
}

// matchesFilterPolicy returns true if the given message attributes satisfy the
// subscription filter policy.  An empty/nil policy always matches.
func matchesFilterPolicy(policy map[string][]string, msgAttrs map[string]MessageAttribute) bool {
	if len(policy) == 0 {
		return true
	}
	for attrName, allowedValues := range policy {
		attr, ok := msgAttrs[attrName]
		if !ok {
			return false
		}
		matched := false
		for _, allowed := range allowedValues {
			if attr.StringValue == allowed {
				matched = true
				break
			}
		}
		if !matched {
			return false
		}
	}
	return true
}

// parseMessageAttributes parses the form-encoded MessageAttributes.entry.N.* fields.
func parseMessageAttributesForm(form url.Values) map[string]MessageAttribute {
	result := make(map[string]MessageAttribute)
	// Iterate up to 20 entries — AWS supports up to 10 but be generous.
	for i := 1; i <= 20; i++ {
		prefix := fmt.Sprintf("MessageAttributes.entry.%d.", i)
		name := form.Get(prefix + "Name")
		if name == "" {
			continue
		}
		result[name] = MessageAttribute{
			DataType:    form.Get(prefix + "Value.DataType"),
			StringValue: form.Get(prefix + "Value.StringValue"),
		}
	}
	return result
}

// parseMessageAttributesJSON parses the JSON MessageAttributes map.
// Expected shape: {"Name": {"DataType": "...", "StringValue": "..."}}
func parseMessageAttributesJSON(raw interface{}) map[string]MessageAttribute {
	result := make(map[string]MessageAttribute)
	m, ok := raw.(map[string]interface{})
	if !ok {
		return result
	}
	for name, v := range m {
		if vm, ok := v.(map[string]interface{}); ok {
			attr := MessageAttribute{}
			if dt, ok := vm["DataType"].(string); ok {
				attr.DataType = dt
			}
			if sv, ok := vm["StringValue"].(string); ok {
				attr.StringValue = sv
			}
			result[name] = attr
		}
	}
	return result
}

// parseFilterPolicy converts the raw JSON filter policy string into the typed map.
func parseFilterPolicy(raw string) map[string][]string {
	if raw == "" {
		return nil
	}
	var fp map[string][]string
	if err := json.Unmarshal([]byte(raw), &fp); err != nil {
		return nil
	}
	return fp
}

// Handler is the HTTP handler for the SNS provider.
type Handler struct {
	state   *state.ServerState
	store   *Store
	sqsPort int
}

// NewHandler creates a new SNS handler and registers the reset callback.
func NewHandler(ss *state.ServerState, sqsPort int) *Handler {
	store := NewStore()
	ss.AddResetCallback(store.Reset)
	return &Handler{state: ss, store: store, sqsPort: sqsPort}
}

// deliverToSQSByEndpoint delivers an SNS notification to a concrete SQS queue endpoint.
// endpoint is either a queue URL or an ARN like arn:aws:sqs:region:account:name.
func (h *Handler) deliverToSQSByEndpoint(endpoint, topicArn, messageID, message string, msgAttrs map[string]MessageAttribute) {
	if h.sqsPort == 0 {
		return
	}

	// Resolve the queue URL.
	var queueURL string
	if strings.HasPrefix(endpoint, "http") {
		queueURL = endpoint
	} else {
		// ARN: arn:aws:sqs:region:account:queueName
		parts := strings.Split(endpoint, ":")
		queueName := parts[len(parts)-1]
		queueURL = fmt.Sprintf("http://127.0.0.1:%d/%s/%s", h.sqsPort, accountID, queueName)
	}

	// Build the SNS notification envelope.
	envelope := map[string]interface{}{
		"Type":      "Notification",
		"MessageId": messageID,
		"TopicArn":  topicArn,
		"Message":   message,
	}
	if len(msgAttrs) > 0 {
		attrs := make(map[string]map[string]string, len(msgAttrs))
		for k, v := range msgAttrs {
			attrs[k] = map[string]string{
				"DataType":    v.DataType,
				"StringValue": v.StringValue,
			}
		}
		envelope["MessageAttributes"] = attrs
	} else {
		envelope["MessageAttributes"] = map[string]interface{}{}
	}

	envelopeJSON, _ := json.Marshal(envelope)

	payload, _ := json.Marshal(map[string]string{
		"QueueUrl":    queueURL,
		"MessageBody": string(envelopeJSON),
	})

	req, err := http.NewRequest("POST", fmt.Sprintf("http://127.0.0.1:%d/", h.sqsPort), bytes.NewReader(payload))
	if err != nil {
		return
	}
	req.Header.Set("Content-Type", "application/x-amz-json-1.0")
	req.Header.Set("X-Amz-Target", "AmazonSQS.SendMessage")
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return
	}
	resp.Body.Close()
}

// ServeHTTP dispatches SNS requests (supports both JSON and form-encoded).
func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	contentType := r.Header.Get("Content-Type")
	isJSON := strings.Contains(contentType, "application/x-amz-json") || r.Header.Get("X-Amz-Target") != ""

	var action string
	var jsonBody map[string]interface{}
	var formBody url.Values

	if isJSON {
		json.NewDecoder(r.Body).Decode(&jsonBody)
		if jsonBody == nil {
			jsonBody = make(map[string]interface{})
		}
		target := r.Header.Get("X-Amz-Target")
		if parts := strings.SplitN(target, ".", 2); len(parts) == 2 {
			action = parts[1]
		}
	} else {
		r.ParseForm()
		formBody = r.Form
		action = formBody.Get("Action")
	}

	if state.ApplyIAMAuth(h.state, "sns", action, r, w, !isJSON) {
		return
	}
	if state.ApplyChaos(h.state, "sns", action, w, !isJSON, false) {
		return
	}

	if isJSON {
		h.handleJSON(w, action, jsonBody)
	} else {
		h.handleForm(w, action, formBody)
	}
}

func xmlReply(w http.ResponseWriter, content string) {
	w.Header().Set("Content-Type", "text/xml")
	w.WriteHeader(200)
	fmt.Fprintf(w, "<?xml version=\"1.0\" encoding=\"UTF-8\"?><%s", content)
}

func escapeXML(s string) string {
	s = strings.ReplaceAll(s, "&", "&amp;")
	s = strings.ReplaceAll(s, "<", "&lt;")
	s = strings.ReplaceAll(s, ">", "&gt;")
	return s
}

func getString(m map[string]interface{}, key string) string {
	if v, ok := m[key]; ok {
		if s, ok := v.(string); ok {
			return s
		}
	}
	return ""
}

func subToMap(s *Subscription) map[string]string {
	return map[string]string{
		"SubscriptionArn": s.SubscriptionArn,
		"TopicArn":        s.TopicArn,
		"Protocol":        s.Protocol,
		"Endpoint":        s.Endpoint,
		"Owner":           accountID,
	}
}

func (h *Handler) handleJSON(w http.ResponseWriter, action string, body map[string]interface{}) {
	writeOK := func(data interface{}) {
		w.Header().Set("Content-Type", "application/x-amz-json-1.0")
		w.WriteHeader(200)
		json.NewEncoder(w).Encode(data)
	}
	writeErr := func(code, msg string) {
		w.Header().Set("Content-Type", "application/x-amz-json-1.0")
		w.WriteHeader(400)
		fmt.Fprintf(w, `{"__type":%q,"message":%q}`+"\n", code, msg)
	}

	switch action {
	case "CreateTopic":
		name := getString(body, "Name")
		t, created := h.store.createTopic(name)
		if !created {
			writeErr("TopicLimitExceeded", "Topic already exists: "+t.Arn)
			return
		}
		writeOK(map[string]string{"TopicArn": t.Arn})

	case "DeleteTopic":
		topicArn := getString(body, "TopicArn")
		if h.store.getTopic(topicArn) == nil {
			writeErr("NotFound", "Topic not found: "+topicArn)
			return
		}
		h.store.deleteTopic(topicArn)
		writeOK(map[string]interface{}{})

	case "ListTopics":
		topics := h.store.listTopics()
		var list []map[string]string
		for _, t := range topics {
			list = append(list, map[string]string{"TopicArn": t.Arn})
		}
		if list == nil {
			list = []map[string]string{}
		}
		writeOK(map[string]interface{}{"Topics": list})

	case "Publish":
		topicArn := getString(body, "TopicArn")
		message := getString(body, "Message")
		msgAttrs := parseMessageAttributesJSON(body["MessageAttributes"])
		messageID := fmt.Sprintf("msg-%d", time.Now().UnixNano())

		if h.state.GetCapacityRule("sns").IsExhausted() {
			writeErr("ServiceUnavailableException", "No delivery slot is available")
			return
		}

		if topicArn != "" {
			t := h.store.getTopic(topicArn)
			if t == nil {
				writeErr("NotFound", "Topic not found: "+topicArn)
				return
			}
			// Deliver to each matching subscription.
			h.store.mu.RLock()
			var sqsSubs []*Subscription
			for _, sub := range t.Subscriptions {
				if !matchesFilterPolicy(sub.FilterPolicy, msgAttrs) {
					continue
				}
				if sub.Protocol == "sqs" {
					sqsSubs = append(sqsSubs, sub)
				}
			}
			h.store.mu.RUnlock()
			for _, sub := range sqsSubs {
				h.deliverToSQSByEndpoint(sub.Endpoint, topicArn, messageID, message, msgAttrs)
			}
		}
		writeOK(map[string]string{"MessageId": messageID})

	case "Subscribe":
		topicArn := getString(body, "TopicArn")
		protocol := getString(body, "Protocol")
		endpoint := getString(body, "Endpoint")

		// Verify topic exists.
		if h.store.getTopic(topicArn) == nil {
			writeErr("NotFound", "Topic not found: "+topicArn)
			return
		}

		if h.state.GetCapacityRule("sns").IsExhausted() {
			writeErr("ServiceUnavailableException", "No subscription slot is available")
			return
		}

		// Parse optional FilterPolicy from Attributes.
		var filterPolicy map[string][]string
		if attrs, ok := body["Attributes"].(map[string]interface{}); ok {
			if fp, ok := attrs["FilterPolicy"].(string); ok {
				filterPolicy = parseFilterPolicy(fp)
			}
		}

		subArn, _ := h.store.subscribe(topicArn, protocol, endpoint, filterPolicy)
		if subArn == "" {
			subArn = "pending confirmation"
		}
		writeOK(map[string]string{"SubscriptionArn": subArn})

	case "Unsubscribe":
		subArn := getString(body, "SubscriptionArn")
		if !h.store.unsubscribe(subArn) {
			writeErr("NotFound", "Subscription not found: "+subArn)
			return
		}
		writeOK(map[string]interface{}{})

	case "ListSubscriptions":
		subs := h.store.listAllSubscriptions()
		var list []map[string]string
		for _, s := range subs {
			list = append(list, subToMap(s))
		}
		if list == nil {
			list = []map[string]string{}
		}
		writeOK(map[string]interface{}{"Subscriptions": list})

	case "ListSubscriptionsByTopic":
		topicArn := getString(body, "TopicArn")
		t := h.store.getTopic(topicArn)
		var list []map[string]string
		if t != nil {
			h.store.mu.RLock()
			for _, s := range t.Subscriptions {
				list = append(list, subToMap(s))
			}
			h.store.mu.RUnlock()
		}
		if list == nil {
			list = []map[string]string{}
		}
		writeOK(map[string]interface{}{"Subscriptions": list})

	case "GetTopicAttributes":
		topicArn := getString(body, "TopicArn")
		t := h.store.getTopic(topicArn)
		attrs := map[string]string{}
		if t != nil {
			attrs = t.Attributes
		}
		writeOK(map[string]interface{}{"Attributes": attrs})

	case "SetTopicAttributes":
		writeOK(map[string]interface{}{})

	case "GetSubscriptionAttributes":
		subArn := getString(body, "SubscriptionArn")
		sub := h.store.getSubscription(subArn)
		if sub == nil {
			writeErr("NotFound", "Subscription not found: "+subArn)
			return
		}
		writeOK(map[string]interface{}{"Attributes": sub.Attributes})

	case "SetSubscriptionAttributes":
		subArn := getString(body, "SubscriptionArn")
		attrName := getString(body, "AttributeName")
		attrValue := getString(body, "AttributeValue")
		sub := h.store.getSubscription(subArn)
		if sub != nil {
			h.store.mu.Lock()
			sub.Attributes[attrName] = attrValue
			if attrName == "FilterPolicy" {
				sub.FilterPolicy = parseFilterPolicy(attrValue)
			}
			h.store.mu.Unlock()
		}
		writeOK(map[string]interface{}{})

	case "ConfirmSubscription":
		subArn := fmt.Sprintf("%s:confirmed-%d", getString(body, "TopicArn"), time.Now().UnixNano())
		writeOK(map[string]string{"SubscriptionArn": subArn})

	case "ListTagsForResource":
		writeOK(map[string]interface{}{"Tags": []interface{}{}})

	case "TagResource":
		writeOK(map[string]interface{}{})

	case "UntagResource":
		writeOK(map[string]interface{}{})

	default:
		writeErr("InvalidAction", "Unknown action: "+action)
	}
}

func (h *Handler) handleForm(w http.ResponseWriter, action string, form url.Values) {
	writeXMLOK := func(content string) {
		xmlReply(w, content)
	}
	writeXMLErr := func(code, msg string) {
		w.Header().Set("Content-Type", "text/xml")
		w.WriteHeader(400)
		fmt.Fprintf(w, `<?xml version="1.0"?><ErrorResponse><Error><Code>%s</Code><Message>%s</Message></Error></ErrorResponse>`, code, escapeXML(msg))
	}

	switch action {
	case "CreateTopic":
		name := form.Get("Name")
		t, created := h.store.createTopic(name)
		if !created {
			writeXMLErr("TopicLimitExceeded", "Topic already exists: "+t.Arn)
			return
		}
		writeXMLOK(fmt.Sprintf(`CreateTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><CreateTopicResult><TopicArn>%s</TopicArn></CreateTopicResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></CreateTopicResponse>`, t.Arn))

	case "DeleteTopic":
		topicArnForm := form.Get("TopicArn")
		if h.store.getTopic(topicArnForm) == nil {
			writeXMLErr("NotFound", "Topic not found: "+topicArnForm)
			return
		}
		h.store.deleteTopic(topicArnForm)
		writeXMLOK(`DeleteTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></DeleteTopicResponse>`)

	case "ListTopics":
		topics := h.store.listTopics()
		topicsXML := ""
		for _, t := range topics {
			topicsXML += fmt.Sprintf("<member><TopicArn>%s</TopicArn></member>", t.Arn)
		}
		writeXMLOK(fmt.Sprintf(`ListTopicsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ListTopicsResult><Topics>%s</Topics></ListTopicsResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></ListTopicsResponse>`, topicsXML))

	case "Publish":
		topicArn := form.Get("TopicArn")
		if topicArn == "" {
			writeXMLErr("InvalidParameter", "TopicArn must not be empty")
			return
		}
		message := form.Get("Message")
		msgAttrs := parseMessageAttributesForm(form)
		t := h.store.getTopic(topicArn)
		if t == nil {
			writeXMLErr("NotFound", "Topic not found: "+topicArn)
			return
		}
		// Fail if no subscriptions exist for the topic (all subscriptions are treated as confirmed).
		h.store.mu.RLock()
		hasSubscription := len(t.Subscriptions) > 0
		var sqsSubs []*Subscription
		for _, sub := range t.Subscriptions {
			if !matchesFilterPolicy(sub.FilterPolicy, msgAttrs) {
				continue
			}
			if sub.Protocol == "sqs" {
				sqsSubs = append(sqsSubs, sub)
			}
		}
		h.store.mu.RUnlock()
		if !hasSubscription {
			writeXMLErr("InvalidParameter", "No confirmed subscription exists for topic: "+topicArn)
			return
		}
		messageID := fmt.Sprintf("msg-%d", time.Now().UnixNano())
		for _, sub := range sqsSubs {
			h.deliverToSQSByEndpoint(sub.Endpoint, topicArn, messageID, message, msgAttrs)
		}
		writeXMLOK(fmt.Sprintf(`PublishResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><PublishResult><MessageId>%s</MessageId></PublishResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></PublishResponse>`, messageID))

	case "Subscribe":
		topicArn := form.Get("TopicArn")
		protocol := form.Get("Protocol")
		endpoint := form.Get("Endpoint")

		// Verify topic exists.
		if h.store.getTopic(topicArn) == nil {
			writeXMLErr("NotFound", "Topic not found: "+topicArn)
			return
		}

		fpStr := form.Get("Attributes.entry.1.value")
		var filterPolicy map[string][]string
		if fpStr != "" && form.Get("Attributes.entry.1.key") == "FilterPolicy" {
			filterPolicy = parseFilterPolicy(fpStr)
		}
		subArn, _ := h.store.subscribe(topicArn, protocol, endpoint, filterPolicy)
		writeXMLOK(fmt.Sprintf(`SubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><SubscribeResult><SubscriptionArn>%s</SubscriptionArn></SubscribeResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></SubscribeResponse>`, subArn))

	case "Unsubscribe":
		subArn := form.Get("SubscriptionArn")
		if !h.store.unsubscribe(subArn) {
			writeXMLErr("NotFound", "Subscription not found: "+subArn)
			return
		}
		writeXMLOK(`UnsubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></UnsubscribeResponse>`)

	case "ListSubscriptions":
		subs := h.store.listAllSubscriptions()
		subsXML := ""
		for _, s := range subs {
			subsXML += fmt.Sprintf(`<member><TopicArn>%s</TopicArn><Protocol>%s</Protocol><SubscriptionArn>%s</SubscriptionArn><Endpoint>%s</Endpoint></member>`,
				s.TopicArn, s.Protocol, s.SubscriptionArn, s.Endpoint)
		}
		writeXMLOK(fmt.Sprintf(`ListSubscriptionsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ListSubscriptionsResult><Subscriptions>%s</Subscriptions></ListSubscriptionsResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></ListSubscriptionsResponse>`, subsXML))

	case "ListSubscriptionsByTopic":
		topicArn := form.Get("TopicArn")
		t := h.store.getTopic(topicArn)
		subsXML := ""
		if t != nil {
			h.store.mu.RLock()
			for _, s := range t.Subscriptions {
				subsXML += fmt.Sprintf(`<member><TopicArn>%s</TopicArn><Protocol>%s</Protocol><SubscriptionArn>%s</SubscriptionArn></member>`,
					s.TopicArn, s.Protocol, s.SubscriptionArn)
			}
			h.store.mu.RUnlock()
		}
		writeXMLOK(fmt.Sprintf(`ListSubscriptionsByTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ListSubscriptionsByTopicResult><Subscriptions>%s</Subscriptions></ListSubscriptionsByTopicResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></ListSubscriptionsByTopicResponse>`, subsXML))

	case "GetTopicAttributes":
		topicArn := form.Get("TopicArn")
		t := h.store.getTopic(topicArn)
		attrsXML := ""
		if t != nil {
			for k, v := range t.Attributes {
				attrsXML += fmt.Sprintf("<entry><key>%s</key><value>%s</value></entry>", k, escapeXML(v))
			}
		}
		writeXMLOK(fmt.Sprintf(`GetTopicAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><GetTopicAttributesResult><Attributes>%s</Attributes></GetTopicAttributesResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></GetTopicAttributesResponse>`, attrsXML))

	case "SetTopicAttributes":
		writeXMLOK(`SetTopicAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></SetTopicAttributesResponse>`)

	case "GetSubscriptionAttributes":
		subArn := form.Get("SubscriptionArn")
		sub := h.store.getSubscription(subArn)
		attrsXML := ""
		if sub != nil {
			for k, v := range sub.Attributes {
				attrsXML += fmt.Sprintf("<entry><key>%s</key><value>%s</value></entry>", k, escapeXML(v))
			}
		}
		writeXMLOK(fmt.Sprintf(`GetSubscriptionAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><GetSubscriptionAttributesResult><Attributes>%s</Attributes></GetSubscriptionAttributesResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></GetSubscriptionAttributesResponse>`, attrsXML))

	case "SetSubscriptionAttributes":
		subArn := form.Get("SubscriptionArn")
		attrName := form.Get("AttributeName")
		attrValue := form.Get("AttributeValue")
		sub := h.store.getSubscription(subArn)
		if sub != nil {
			h.store.mu.Lock()
			sub.Attributes[attrName] = attrValue
			if attrName == "FilterPolicy" {
				sub.FilterPolicy = parseFilterPolicy(attrValue)
			}
			h.store.mu.Unlock()
		}
		writeXMLOK(`SetSubscriptionAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></SetSubscriptionAttributesResponse>`)

	case "ConfirmSubscription":
		subArn := fmt.Sprintf("%s:confirmed-%d", form.Get("TopicArn"), time.Now().UnixNano())
		writeXMLOK(fmt.Sprintf(`ConfirmSubscriptionResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ConfirmSubscriptionResult><SubscriptionArn>%s</SubscriptionArn></ConfirmSubscriptionResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></ConfirmSubscriptionResponse>`, subArn))

	case "ListTagsForResource":
		writeXMLOK(`ListTagsForResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><ListTagsForResourceResult><Tags></Tags></ListTagsForResourceResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></ListTagsForResourceResponse>`)

	case "TagResource":
		writeXMLOK(`TagResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><TagResourceResult></TagResourceResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></TagResourceResponse>`)

	case "UntagResource":
		writeXMLOK(`UntagResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/"><UntagResourceResult></UntagResourceResult><ResponseMetadata><RequestId>0</RequestId></ResponseMetadata></UntagResourceResponse>`)

	default:
		writeXMLErr("InvalidAction", "Unknown action: "+action)
	}
}
