package sqs

import (
	"crypto/md5"
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

// SqsMessage represents a message in a queue.
type SqsMessage struct {
	MessageID              string
	ReceiptHandle          string
	Body                   string
	Attributes             map[string]string
	MessageGroupId         string
	MessageDeduplicationId string
	DeduplicationExpiry    time.Time
	visibleAfter           time.Time
	receiveCount           int
}

// RedrivePolicy represents the dead-letter queue redrive policy.
type RedrivePolicy struct {
	DeadLetterTargetArn string
	MaxReceiveCount     int
}

// LocalQueue is an in-memory SQS queue.
type LocalQueue struct {
	mu                sync.Mutex
	Name              string
	URL               string
	IsFifo            bool
	VisibilityTimeout int
	RedrivePolicy     *RedrivePolicy
	messages          []*SqsMessage
	msgCounter        int
	// FIFO deduplication: deduplicationId -> expiry
	deduplicationIds map[string]time.Time
}

func (q *LocalQueue) sendMessage(body, groupId, deduplicationId string) (string, bool) {
	q.mu.Lock()
	defer q.mu.Unlock()

	// FIFO deduplication check
	if q.IsFifo && deduplicationId != "" {
		if expiry, exists := q.deduplicationIds[deduplicationId]; exists {
			if time.Now().Before(expiry) {
				// Duplicate — return existing (stub: return empty ID to signal duplicate)
				return "", false
			}
		}
		q.deduplicationIds[deduplicationId] = time.Now().Add(5 * time.Minute)
	}

	q.msgCounter++
	id := fmt.Sprintf("msg-%d-%d", time.Now().UnixNano(), q.msgCounter)
	rh := fmt.Sprintf("rh-%s", id)
	q.messages = append(q.messages, &SqsMessage{
		MessageID:              id,
		ReceiptHandle:          rh,
		Body:                   body,
		Attributes:             map[string]string{},
		MessageGroupId:         groupId,
		MessageDeduplicationId: deduplicationId,
		visibleAfter:           time.Now(),
		receiveCount:           0,
	})
	return id, true
}

func (q *LocalQueue) receiveMessages(max int) []*SqsMessage {
	q.mu.Lock()
	defer q.mu.Unlock()
	now := time.Now()
	var result []*SqsMessage
	vt := q.VisibilityTimeout
	if vt == 0 {
		vt = 30
	}
	for _, m := range q.messages {
		if now.After(m.visibleAfter) || now.Equal(m.visibleAfter) {
			m.receiveCount++
			m.visibleAfter = now.Add(time.Duration(vt) * time.Second)
			result = append(result, m)
			if len(result) >= max {
				break
			}
		}
	}
	return result
}

// moveToDLQ moves messages that exceed maxReceiveCount to the DLQ.
// Must be called without holding q.mu.
func (q *LocalQueue) checkDLQ(store *Store) {
	if q.RedrivePolicy == nil {
		return
	}
	maxRC := q.RedrivePolicy.MaxReceiveCount
	dlqArn := q.RedrivePolicy.DeadLetterTargetArn

	// Extract queue name from ARN: arn:aws:sqs:region:accountId:queueName
	parts := strings.Split(dlqArn, ":")
	dlqName := parts[len(parts)-1]
	dlq := store.getQueue(dlqName)
	if dlq == nil {
		return
	}

	q.mu.Lock()
	var remaining []*SqsMessage
	var toMove []*SqsMessage
	now := time.Now()
	for _, m := range q.messages {
		if m.receiveCount > maxRC && (now.After(m.visibleAfter) || now.Equal(m.visibleAfter)) {
			toMove = append(toMove, m)
		} else {
			remaining = append(remaining, m)
		}
	}
	q.messages = remaining
	q.mu.Unlock()

	for _, m := range toMove {
		dlq.sendMessage(m.Body, m.MessageGroupId, "")
	}
}

// deleteMessage removes a message by receipt handle, returning true if found/deleted.
func (q *LocalQueue) deleteMessage(receiptHandle string) bool {
	q.mu.Lock()
	defer q.mu.Unlock()
	found := false
	newMsgs := q.messages[:0]
	for _, m := range q.messages {
		if m.ReceiptHandle == receiptHandle {
			found = true
		} else {
			newMsgs = append(newMsgs, m)
		}
	}
	q.messages = newMsgs
	return found
}

func (q *LocalQueue) purge() {
	q.mu.Lock()
	defer q.mu.Unlock()
	q.messages = nil
}

func (q *LocalQueue) approximateCount() int {
	q.mu.Lock()
	defer q.mu.Unlock()
	count := 0
	now := time.Now()
	for _, m := range q.messages {
		if now.After(m.visibleAfter) || now.Equal(m.visibleAfter) {
			count++
		}
	}
	return count
}

func (q *LocalQueue) inFlightCount() int {
	q.mu.Lock()
	defer q.mu.Unlock()
	count := 0
	now := time.Now()
	for _, m := range q.messages {
		if now.Before(m.visibleAfter) {
			count++
		}
	}
	return count
}

// changeVisibility changes the visibility timeout for a message, returning true if found.
func (q *LocalQueue) changeVisibility(receiptHandle string, timeoutSec int) bool {
	q.mu.Lock()
	defer q.mu.Unlock()
	for _, m := range q.messages {
		if m.ReceiptHandle == receiptHandle {
			m.visibleAfter = time.Now().Add(time.Duration(timeoutSec) * time.Second)
			return true
		}
	}
	return false
}

// Store is the SQS in-memory store.
type Store struct {
	mu        sync.RWMutex
	queues    map[string]*LocalQueue
	queueTags map[string]map[string]string
	port      int
}

func NewStore(port int) *Store {
	return &Store{
		queues:    make(map[string]*LocalQueue),
		queueTags: make(map[string]map[string]string),
		port:      port,
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.queues = make(map[string]*LocalQueue)
	s.queueTags = make(map[string]map[string]string)
}

func (s *Store) queueURL(name string) string {
	return fmt.Sprintf("http://127.0.0.1:%d/%s/%s", s.port, accountID, name)
}

// createQueue creates a queue, returning (queue, true) on success or (existing, false) if already exists.
func (s *Store) createQueue(name string, attrs map[string]string) (*LocalQueue, bool) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if existing, ok := s.queues[name]; ok {
		return existing, false
	}
	isFifo := name != "" && (strings.HasSuffix(name, ".fifo") || attrs["FifoQueue"] == "true")
	vt := 30
	if v, ok := attrs["VisibilityTimeout"]; ok {
		fmt.Sscanf(v, "%d", &vt)
	}

	var rp *RedrivePolicy
	if rpJSON, ok := attrs["RedrivePolicy"]; ok && rpJSON != "" {
		var rpMap map[string]interface{}
		if err := json.Unmarshal([]byte(rpJSON), &rpMap); err == nil {
			rp = &RedrivePolicy{}
			if v, ok := rpMap["deadLetterTargetArn"].(string); ok {
				rp.DeadLetterTargetArn = v
			}
			if v, ok := rpMap["maxReceiveCount"].(float64); ok {
				rp.MaxReceiveCount = int(v)
			}
		}
	}

	q := &LocalQueue{
		Name:              name,
		URL:               s.queueURL(name),
		IsFifo:            isFifo,
		VisibilityTimeout: vt,
		RedrivePolicy:     rp,
		deduplicationIds:  make(map[string]time.Time),
	}
	s.queues[name] = q
	return q, true
}

func (s *Store) getQueue(nameOrURL string) *LocalQueue {
	s.mu.RLock()
	defer s.mu.RUnlock()
	if strings.Contains(nameOrURL, "/") {
		parts := strings.Split(nameOrURL, "/")
		name := parts[len(parts)-1]
		return s.queues[name]
	}
	return s.queues[nameOrURL]
}

func (s *Store) deleteQueue(nameOrURL string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if strings.Contains(nameOrURL, "/") {
		parts := strings.Split(nameOrURL, "/")
		name := parts[len(parts)-1]
		delete(s.queues, name)
		return
	}
	delete(s.queues, nameOrURL)
}

func (s *Store) listQueues(prefix string) []*LocalQueue {
	s.mu.RLock()
	defer s.mu.RUnlock()
	var result []*LocalQueue
	for name, q := range s.queues {
		if prefix == "" || strings.HasPrefix(name, prefix) {
			result = append(result, q)
		}
	}
	return result
}

func (s *Store) getTags(nameOrURL string) map[string]string {
	q := s.getQueue(nameOrURL)
	if q == nil {
		return map[string]string{}
	}
	s.mu.RLock()
	defer s.mu.RUnlock()
	tags := s.queueTags[q.Name]
	if tags == nil {
		return map[string]string{}
	}
	result := make(map[string]string)
	for k, v := range tags {
		result[k] = v
	}
	return result
}

func (s *Store) setTags(nameOrURL string, tags map[string]string) {
	q := s.getQueue(nameOrURL)
	if q == nil {
		return
	}
	s.mu.Lock()
	defer s.mu.Unlock()
	if s.queueTags[q.Name] == nil {
		s.queueTags[q.Name] = make(map[string]string)
	}
	for k, v := range tags {
		s.queueTags[q.Name][k] = v
	}
}

func (s *Store) removeTags(nameOrURL string, tagKeys []string) {
	q := s.getQueue(nameOrURL)
	if q == nil {
		return
	}
	s.mu.Lock()
	defer s.mu.Unlock()
	for _, k := range tagKeys {
		delete(s.queueTags[q.Name], k)
	}
}

// Handler handles SQS HTTP requests.
type Handler struct {
	state *state.ServerState
	store *Store
	port  int
}

func NewHandler(state *state.ServerState, port int) *Handler {
	store := NewStore(port)
	state.AddResetCallback(store.Reset)
	return &Handler{state: state, store: store, port: port}
}

func md5sum(s string) string {
	return fmt.Sprintf("%x", md5.Sum([]byte(s)))
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost && r.Method != http.MethodGet {
		http.NotFound(w, r)
		return
	}

	// Parse body
	contentType := r.Header.Get("Content-Type")
	isJSON := strings.Contains(contentType, "application/x-amz-json") || r.Header.Get("X-Amz-Target") != ""

	var formBody url.Values
	var jsonBody map[string]interface{}

	if isJSON {
		json.NewDecoder(r.Body).Decode(&jsonBody) //nolint:errcheck
		if jsonBody == nil {
			jsonBody = make(map[string]interface{})
		}
	} else {
		r.ParseForm() //nolint:errcheck
		formBody = r.Form
	}

	// Determine action
	action := ""
	if isJSON {
		target := r.Header.Get("X-Amz-Target")
		if target != "" {
			parts := strings.SplitN(target, ".", 2)
			if len(parts) == 2 {
				action = parts[1]
			}
		}
	} else {
		action = formBody.Get("Action")
	}

	// Middleware
	if state.ApplyIAMAuth(h.state, "sqs", action, r, w, !isJSON) {
		return
	}
	if state.ApplyChaos(h.state, "sqs", action, w, !isJSON, false) {
		return
	}

	if isJSON {
		h.handleJSON(w, r, action, jsonBody)
	} else {
		h.handleForm(w, r, action, formBody)
	}
}

func getString(m map[string]interface{}, key string) string {
	if v, ok := m[key]; ok {
		if s, ok := v.(string); ok {
			return s
		}
	}
	return ""
}

func getInt(m map[string]interface{}, key string, def int) int {
	if v, ok := m[key]; ok {
		switch t := v.(type) {
		case float64:
			return int(t)
		case int:
			return t
		}
	}
	return def
}

func (h *Handler) handleJSON(w http.ResponseWriter, r *http.Request, action string, body map[string]interface{}) {
	path := r.URL.Path
	writeOK := func(data interface{}) {
		w.Header().Set("Content-Type", "application/x-amz-json-1.0")
		w.WriteHeader(200)
		json.NewEncoder(w).Encode(data) //nolint:errcheck
	}
	writeErr := func(code, msg string) {
		w.Header().Set("Content-Type", "application/x-amz-json-1.0")
		w.WriteHeader(400)
		fmt.Fprintf(w, `{"__type":%q,"message":%q}`+"\n", code, msg)
	}

	switch action {
	case "CreateQueue":
		name := getString(body, "QueueName")
		attrs := map[string]string{}
		if a, ok := body["Attributes"].(map[string]interface{}); ok {
			for k, v := range a {
				if s, ok := v.(string); ok {
					attrs[k] = s
				}
			}
		}
		q, created := h.store.createQueue(name, attrs)
		if !created {
			writeErr("QueueAlreadyExists", "Queue already exists: "+name)
			return
		}
		writeOK(map[string]string{"QueueUrl": q.URL})

	case "GetQueueUrl":
		name := getString(body, "QueueName")
		writeOK(map[string]string{"QueueUrl": h.store.queueURL(name)})

	case "ListQueues":
		prefix := getString(body, "QueueNamePrefix")
		queues := h.store.listQueues(prefix)
		urls := make([]string, 0, len(queues))
		for _, q := range queues {
			urls = append(urls, q.URL)
		}
		writeOK(map[string]interface{}{"QueueUrls": urls})

	case "DeleteQueue":
		queueURL := getString(body, "QueueUrl")
		if queueURL == "" {
			queueURL = "http://127.0.0.1" + path
		}
		if h.store.getQueue(queueURL) == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		h.store.deleteQueue(queueURL)
		writeOK(map[string]interface{}{})

	case "SendMessage":
		queueURL := getString(body, "QueueUrl")
		if queueURL == "" {
			queueURL = "http://127.0.0.1" + path
		}
		q := h.store.getQueue(queueURL)
		if q == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		if h.state.GetCapacityRule("sqs").IsExhausted() {
			writeErr("AWS.SimpleQueueService.InternalError", "No message slot is available")
			return
		}
		msgBody := getString(body, "MessageBody")
		groupId := getString(body, "MessageGroupId")
		dedupId := getString(body, "MessageDeduplicationId")
		id, sent := q.sendMessage(msgBody, groupId, dedupId)
		if !sent {
			// Duplicate — return a stub response
			writeOK(map[string]string{"MessageId": "duplicate", "MD5OfMessageBody": md5sum(msgBody)})
			return
		}
		// Check DLQ after sending
		q.checkDLQ(h.store)
		writeOK(map[string]string{"MessageId": id, "MD5OfMessageBody": md5sum(msgBody)})

	case "SendMessageBatch":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		entries, _ := body["Entries"].([]interface{})
		var successful []map[string]interface{}
		for _, e := range entries {
			entry, ok := e.(map[string]interface{})
			if !ok {
				continue
			}
			msgBody := getString(entry, "MessageBody")
			groupId := getString(entry, "MessageGroupId")
			dedupId := getString(entry, "MessageDeduplicationId")
			id, _ := q.sendMessage(msgBody, groupId, dedupId)
			successful = append(successful, map[string]interface{}{
				"Id": getString(entry, "Id"), "MessageId": id, "MD5OfMessageBody": md5sum(msgBody),
			})
		}
		if successful == nil {
			successful = []map[string]interface{}{}
		}
		writeOK(map[string]interface{}{"Successful": successful, "Failed": []interface{}{}})

	case "ReceiveMessage":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		// Check DLQ before receiving
		q.checkDLQ(h.store)
		max := getInt(body, "MaxNumberOfMessages", 1)
		msgs := q.receiveMessages(max)
		var out []map[string]interface{}
		for _, m := range msgs {
			attrs := map[string]interface{}{}
			for k, v := range m.Attributes {
				attrs[k] = v
			}
			attrs["ApproximateReceiveCount"] = fmt.Sprintf("%d", m.receiveCount)
			out = append(out, map[string]interface{}{
				"MessageId": m.MessageID, "ReceiptHandle": m.ReceiptHandle,
				"MD5OfBody": md5sum(m.Body), "Body": m.Body,
				"Attributes": attrs,
			})
		}
		if out == nil {
			out = []map[string]interface{}{}
		}
		writeOK(map[string]interface{}{"Messages": out})

	case "DeleteMessage":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		receiptHandle := getString(body, "ReceiptHandle")
		if !q.deleteMessage(receiptHandle) {
			writeErr("ReceiptHandleIsInvalid", "The receipt handle has expired or is invalid")
			return
		}
		writeOK(map[string]interface{}{})

	case "DeleteMessageBatch":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		entries, _ := body["Entries"].([]interface{})
		var successful []map[string]interface{}
		for _, e := range entries {
			entry, ok := e.(map[string]interface{})
			if !ok {
				continue
			}
			if q != nil {
				q.deleteMessage(getString(entry, "ReceiptHandle"))
			}
			successful = append(successful, map[string]interface{}{"Id": getString(entry, "Id")})
		}
		if successful == nil {
			successful = []map[string]interface{}{}
		}
		writeOK(map[string]interface{}{"Successful": successful, "Failed": []interface{}{}})

	case "PurgeQueue":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		q.purge()
		writeOK(map[string]interface{}{})

	case "GetQueueAttributes":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found")
			return
		}
		attrs := map[string]string{
			"QueueArn":                              fmt.Sprintf("arn:aws:sqs:us-east-1:%s:%s", accountID, q.Name),
			"ApproximateNumberOfMessages":           fmt.Sprintf("%d", q.approximateCount()),
			"ApproximateNumberOfMessagesNotVisible": fmt.Sprintf("%d", q.inFlightCount()),
			"VisibilityTimeout":                     fmt.Sprintf("%d", q.VisibilityTimeout),
			"FifoQueue":                             fmt.Sprintf("%v", q.IsFifo),
		}
		if q.RedrivePolicy != nil {
			rpBytes, _ := json.Marshal(map[string]interface{}{
				"deadLetterTargetArn": q.RedrivePolicy.DeadLetterTargetArn,
				"maxReceiveCount":     q.RedrivePolicy.MaxReceiveCount,
			})
			attrs["RedrivePolicy"] = string(rpBytes)
		}
		writeOK(map[string]interface{}{"Attributes": attrs})

	case "SetQueueAttributes":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		if attrs, ok := body["Attributes"].(map[string]interface{}); ok {
			if rpJSON, ok := attrs["RedrivePolicy"].(string); ok && rpJSON != "" {
				var rpMap map[string]interface{}
				if err := json.Unmarshal([]byte(rpJSON), &rpMap); err == nil {
					rp := &RedrivePolicy{}
					if v, ok := rpMap["deadLetterTargetArn"].(string); ok {
						rp.DeadLetterTargetArn = v
					}
					if v, ok := rpMap["maxReceiveCount"].(float64); ok {
						rp.MaxReceiveCount = int(v)
					}
					q.mu.Lock()
					q.RedrivePolicy = rp
					q.mu.Unlock()
				}
			}
		}
		writeOK(map[string]interface{}{})

	case "ChangeMessageVisibility":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			writeErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		if !q.changeVisibility(getString(body, "ReceiptHandle"), getInt(body, "VisibilityTimeout", 0)) {
			writeErr("ReceiptHandleIsInvalid", "The receipt handle has expired or is invalid")
			return
		}
		writeOK(map[string]interface{}{})

	case "ChangeMessageVisibilityBatch":
		queueURL := getString(body, "QueueUrl")
		q := h.store.getQueue(queueURL)
		entries, _ := body["Entries"].([]interface{})
		var successful []map[string]interface{}
		for _, e := range entries {
			entry, ok := e.(map[string]interface{})
			if !ok {
				continue
			}
			if q != nil {
				q.changeVisibility(getString(entry, "ReceiptHandle"), getInt(entry, "VisibilityTimeout", 0))
			}
			successful = append(successful, map[string]interface{}{"Id": getString(entry, "Id")})
		}
		if successful == nil {
			successful = []map[string]interface{}{}
		}
		writeOK(map[string]interface{}{"Successful": successful, "Failed": []interface{}{}})

	case "ListQueueTags":
		queueURL := getString(body, "QueueUrl")
		tags := h.store.getTags(queueURL)
		writeOK(map[string]interface{}{"Tags": tags})

	case "TagQueue":
		queueURL := getString(body, "QueueUrl")
		tags := map[string]string{}
		if t, ok := body["Tags"].(map[string]interface{}); ok {
			for k, v := range t {
				if s, ok := v.(string); ok {
					tags[k] = s
				}
			}
		}
		h.store.setTags(queueURL, tags)
		writeOK(map[string]interface{}{})

	case "UntagQueue":
		queueURL := getString(body, "QueueUrl")
		keys, _ := body["TagKeys"].([]interface{})
		tagKeys := make([]string, 0, len(keys))
		for _, k := range keys {
			if s, ok := k.(string); ok {
				tagKeys = append(tagKeys, s)
			}
		}
		h.store.removeTags(queueURL, tagKeys)
		writeOK(map[string]interface{}{})

	case "ListDeadLetterSourceQueues":
		writeOK(map[string]interface{}{"queueUrls": []string{}})

	case "StartMessageMoveTask":
		taskHandle := fmt.Sprintf("task-%d", time.Now().UnixNano())
		writeOK(map[string]interface{}{"TaskHandle": taskHandle})

	case "CancelMessageMoveTask":
		writeOK(map[string]interface{}{"ApproximateNumberOfMessagesMoved": 0})

	case "ListMessageMoveTasks":
		writeOK(map[string]interface{}{"Results": []interface{}{}})

	case "AddPermission", "RemovePermission":
		writeOK(map[string]interface{}{})

	default:
		writeErr("InvalidAction", "Unknown action: "+action)
	}
}

func (h *Handler) handleForm(w http.ResponseWriter, r *http.Request, action string, form url.Values) {
	path := r.URL.Path
	xmlWrite := func(content string) {
		w.Header().Set("Content-Type", "text/xml")
		w.WriteHeader(200)
		fmt.Fprintf(w, "<?xml version=\"1.0\"?><%s", content)
	}
	xmlErr := func(code, msg string) {
		w.Header().Set("Content-Type", "text/xml")
		w.WriteHeader(400)
		fmt.Fprintf(w, `<?xml version="1.0"?><ErrorResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><Error><Code>%s</Code><Message>%s</Message></Error><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ErrorResponse>`,
			code, escapeXML(msg))
	}
	_ = path

	switch action {
	case "CreateQueue":
		name := form.Get("QueueName")
		attrs := map[string]string{}
		for i := 1; ; i++ {
			attrName := form.Get(fmt.Sprintf("Attribute.%d.Name", i))
			if attrName == "" {
				break
			}
			attrVal := form.Get(fmt.Sprintf("Attribute.%d.Value", i))
			attrs[attrName] = attrVal
		}
		q, created := h.store.createQueue(name, attrs)
		if !created {
			xmlErr("QueueAlreadyExists", "Queue already exists: "+name)
			return
		}
		xmlWrite(fmt.Sprintf(`CreateQueueResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><CreateQueueResult><QueueUrl>%s</QueueUrl></CreateQueueResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></CreateQueueResponse>`, q.URL))

	case "GetQueueUrl":
		name := form.Get("QueueName")
		queueURL := h.store.queueURL(name)
		xmlWrite(fmt.Sprintf(`GetQueueUrlResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><GetQueueUrlResult><QueueUrl>%s</QueueUrl></GetQueueUrlResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></GetQueueUrlResponse>`, queueURL))

	case "ListQueues":
		prefix := form.Get("QueueNamePrefix")
		queues := h.store.listQueues(prefix)
		urlsXML := ""
		for _, q := range queues {
			urlsXML += fmt.Sprintf("<QueueUrl>%s</QueueUrl>", q.URL)
		}
		xmlWrite(fmt.Sprintf(`ListQueuesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ListQueuesResult>%s</ListQueuesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListQueuesResponse>`, urlsXML))

	case "DeleteQueue":
		queueURL := form.Get("QueueUrl")
		if h.store.getQueue(queueURL) == nil {
			xmlErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		h.store.deleteQueue(queueURL)
		xmlWrite(`DeleteQueueResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></DeleteQueueResponse>`)

	case "SendMessage":
		queueURL := form.Get("QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			xmlErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		if h.state.GetCapacityRule("sqs").IsExhausted() {
			xmlErr("AWS.SimpleQueueService.InternalError", "No message slot is available")
			return
		}
		msgBody := form.Get("MessageBody")
		groupId := form.Get("MessageGroupId")
		dedupId := form.Get("MessageDeduplicationId")
		id, _ := q.sendMessage(msgBody, groupId, dedupId)
		q.checkDLQ(h.store)
		xmlWrite(fmt.Sprintf(`SendMessageResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><SendMessageResult><MessageId>%s</MessageId><MD5OfMessageBody>%s</MD5OfMessageBody></SendMessageResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></SendMessageResponse>`, id, md5sum(msgBody)))

	case "ReceiveMessage":
		queueURL := form.Get("QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			xmlErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		q.checkDLQ(h.store)
		max := 1
		if v := form.Get("MaxNumberOfMessages"); v != "" {
			fmt.Sscanf(v, "%d", &max)
		}
		msgs := q.receiveMessages(max)
		msgsXML := ""
		for _, m := range msgs {
			msgsXML += fmt.Sprintf(`<Message><MessageId>%s</MessageId><ReceiptHandle>%s</ReceiptHandle><MD5OfBody>%s</MD5OfBody><Body>%s</Body><Attribute><Name>ApproximateReceiveCount</Name><Value>%d</Value></Attribute></Message>`,
				m.MessageID, m.ReceiptHandle, md5sum(m.Body), escapeXML(m.Body), m.receiveCount)
		}
		xmlWrite(fmt.Sprintf(`ReceiveMessageResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ReceiveMessageResult>%s</ReceiveMessageResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ReceiveMessageResponse>`, msgsXML))

	case "DeleteMessage":
		queueURL := form.Get("QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			xmlErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		receiptHandle := form.Get("ReceiptHandle")
		if !q.deleteMessage(receiptHandle) {
			xmlErr("ReceiptHandleIsInvalid", "The receipt handle has expired or is invalid")
			return
		}
		xmlWrite(`DeleteMessageResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></DeleteMessageResponse>`)

	case "PurgeQueue":
		queueURL := form.Get("QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			xmlErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		q.purge()
		xmlWrite(`PurgeQueueResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></PurgeQueueResponse>`)

	case "GetQueueAttributes":
		queueURL := form.Get("QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			xmlErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found")
			return
		}
		attrs := map[string]string{
			"QueueArn":                              fmt.Sprintf("arn:aws:sqs:us-east-1:%s:%s", accountID, q.Name),
			"ApproximateNumberOfMessages":           fmt.Sprintf("%d", q.approximateCount()),
			"ApproximateNumberOfMessagesNotVisible": fmt.Sprintf("%d", q.inFlightCount()),
			"VisibilityTimeout":                     fmt.Sprintf("%d", q.VisibilityTimeout),
			"FifoQueue":                             fmt.Sprintf("%v", q.IsFifo),
		}
		if q.RedrivePolicy != nil {
			rpBytes, _ := json.Marshal(map[string]interface{}{
				"deadLetterTargetArn": q.RedrivePolicy.DeadLetterTargetArn,
				"maxReceiveCount":     q.RedrivePolicy.MaxReceiveCount,
			})
			attrs["RedrivePolicy"] = string(rpBytes)
		}
		attrsXML := ""
		for k, v := range attrs {
			attrsXML += fmt.Sprintf("<Attribute><Name>%s</Name><Value>%s</Value></Attribute>", k, v)
		}
		xmlWrite(fmt.Sprintf(`GetQueueAttributesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><GetQueueAttributesResult>%s</GetQueueAttributesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></GetQueueAttributesResponse>`, attrsXML))

	case "SetQueueAttributes":
		xmlWrite(`SetQueueAttributesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></SetQueueAttributesResponse>`)

	case "ChangeMessageVisibility":
		queueURL := form.Get("QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			xmlErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		vt := 0
		fmt.Sscanf(form.Get("VisibilityTimeout"), "%d", &vt)
		if !q.changeVisibility(form.Get("ReceiptHandle"), vt) {
			xmlErr("ReceiptHandleIsInvalid", "The receipt handle has expired or is invalid")
			return
		}
		xmlWrite(`ChangeMessageVisibilityResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ChangeMessageVisibilityResponse>`)

	case "ChangeMessageVisibilityBatch":
		xmlWrite(`ChangeMessageVisibilityBatchResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ChangeMessageVisibilityBatchResult></ChangeMessageVisibilityBatchResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ChangeMessageVisibilityBatchResponse>`)

	case "ListQueueTags":
		queueURL := form.Get("QueueUrl")
		tags := h.store.getTags(queueURL)
		tagsXML := ""
		for k, v := range tags {
			tagsXML += fmt.Sprintf("<Tag><Key>%s</Key><Value>%s</Value></Tag>", k, v)
		}
		xmlWrite(fmt.Sprintf(`ListQueueTagsResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ListQueueTagsResult>%s</ListQueueTagsResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListQueueTagsResponse>`, tagsXML))

	case "TagQueue":
		queueURL := form.Get("QueueUrl")
		tags := map[string]string{}
		for i := 1; ; i++ {
			k := form.Get(fmt.Sprintf("Tags.entry.%d.key", i))
			if k == "" {
				k = form.Get(fmt.Sprintf("Tag.%d.Key", i))
			}
			v := form.Get(fmt.Sprintf("Tags.entry.%d.value", i))
			if v == "" {
				v = form.Get(fmt.Sprintf("Tag.%d.Value", i))
			}
			if k == "" {
				break
			}
			tags[k] = v
		}
		h.store.setTags(queueURL, tags)
		xmlWrite(`TagQueueResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></TagQueueResponse>`)

	case "UntagQueue":
		queueURL := form.Get("QueueUrl")
		var tagKeys []string
		for i := 1; ; i++ {
			k := form.Get(fmt.Sprintf("TagKey.%d", i))
			if k == "" {
				break
			}
			tagKeys = append(tagKeys, k)
		}
		h.store.removeTags(queueURL, tagKeys)
		xmlWrite(`UntagQueueResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></UntagQueueResponse>`)

	case "ListDeadLetterSourceQueues":
		xmlWrite(`ListDeadLetterSourceQueuesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><ListDeadLetterSourceQueuesResult></ListDeadLetterSourceQueuesResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></ListDeadLetterSourceQueuesResponse>`)

	case "DeleteMessageBatch":
		queueURL := form.Get("QueueUrl")
		q := h.store.getQueue(queueURL)
		for i := 1; ; i++ {
			rh := form.Get(fmt.Sprintf("DeleteMessageBatchRequestEntry.%d.ReceiptHandle", i))
			if rh == "" {
				break
			}
			if q != nil {
				q.deleteMessage(rh)
			}
		}
		xmlWrite(`DeleteMessageBatchResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><DeleteMessageBatchResult></DeleteMessageBatchResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></DeleteMessageBatchResponse>`)

	case "SendMessageBatch":
		queueURL := form.Get("QueueUrl")
		q := h.store.getQueue(queueURL)
		if q == nil {
			xmlErr("AWS.SimpleQueueService.NonExistentQueue", "Queue not found: "+queueURL)
			return
		}
		successXML := ""
		for i := 1; ; i++ {
			id := form.Get(fmt.Sprintf("SendMessageBatchRequestEntry.%d.Id", i))
			if id == "" {
				break
			}
			msgBody := form.Get(fmt.Sprintf("SendMessageBatchRequestEntry.%d.MessageBody", i))
			groupId := form.Get(fmt.Sprintf("SendMessageBatchRequestEntry.%d.MessageGroupId", i))
			dedupId := form.Get(fmt.Sprintf("SendMessageBatchRequestEntry.%d.MessageDeduplicationId", i))
			msgID, _ := q.sendMessage(msgBody, groupId, dedupId)
			successXML += fmt.Sprintf(`<SendMessageBatchResultEntry><Id>%s</Id><MessageId>%s</MessageId><MD5OfMessageBody>%s</MD5OfMessageBody></SendMessageBatchResultEntry>`,
				id, msgID, md5sum(msgBody))
		}
		xmlWrite(fmt.Sprintf(`SendMessageBatchResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/"><SendMessageBatchResult>%s</SendMessageBatchResult><ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata></SendMessageBatchResponse>`, successXML))

	default:
		xmlErr("InvalidAction", "Unknown action: "+action)
	}
}

func escapeXML(s string) string {
	s = strings.ReplaceAll(s, "&", "&amp;")
	s = strings.ReplaceAll(s, "<", "&lt;")
	s = strings.ReplaceAll(s, ">", "&gt;")
	s = strings.ReplaceAll(s, `"`, "&quot;")
	s = strings.ReplaceAll(s, "'", "&apos;")
	return s
}
