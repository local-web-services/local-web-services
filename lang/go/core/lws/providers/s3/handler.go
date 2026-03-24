package s3

import (
	"bytes"
	"encoding/json"
	"encoding/xml"
	"fmt"
	"io"
	"net/http"
	"sort"
	"strconv"
	"strings"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"
const region = "us-east-1"

// ObjectVersion holds one version of an S3 object.
type ObjectVersion struct {
	VersionID    string
	Data         []byte
	ContentType  string
	LastModified time.Time
	ETag         string
	Size         int64
	IsLatest     bool
}

// S3Object is the current/latest version of an object plus all previous versions.
type S3Object struct {
	Key          string
	Data         []byte
	ContentType  string
	LastModified time.Time
	ETag         string
	Size         int64
	// versions holds all versions including the current one when versioning was active.
	versions []ObjectVersion
}

// LifecycleRule stores a single lifecycle rule.
type LifecycleRule struct {
	ID     string
	Status string
	// Raw XML body of the rule — stored verbatim for round-trip.
	Raw string
}

// MultipartPart stores data for a single uploaded part.
type MultipartPart struct {
	PartNumber int
	Data       []byte
	ETag       string
}

// MultipartUpload tracks an in-progress multipart upload.
type MultipartUpload struct {
	UploadID    string
	Bucket      string
	Key         string
	ContentType string
	Parts       map[int]*MultipartPart
}

// NotificationConfig stores the bucket notification configuration.
type NotificationConfig struct {
	Type   string // "sns", "sqs", or "eventbridge"
	Target string // ARN or bus name
}

// S3Bucket holds all state for a single bucket.
type S3Bucket struct {
	Name              string
	Objects           map[string]*S3Object
	Tags              []map[string]string
	Policy            string
	VersioningEnabled bool
	LifecycleRules    []LifecycleRule
	Notification      *NotificationConfig
}

// Store is the in-memory store for S3.
type Store struct {
	mu             sync.RWMutex
	buckets        map[string]*S3Bucket
	multiparts     map[string]*MultipartUpload // keyed by uploadId
	versionCounter int
}

// NewStore creates an empty Store.
func NewStore() *Store {
	return &Store{
		buckets:    make(map[string]*S3Bucket),
		multiparts: make(map[string]*MultipartUpload),
	}
}

// Reset clears all state (called on /_ldk/reset).
func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.buckets = make(map[string]*S3Bucket)
	s.multiparts = make(map[string]*MultipartUpload)
	s.versionCounter = 0
}

func (s *Store) createBucket(name string) *S3Bucket {
	s.mu.Lock()
	defer s.mu.Unlock()
	if b, ok := s.buckets[name]; ok {
		return b
	}
	b := &S3Bucket{Name: name, Objects: make(map[string]*S3Object)}
	s.buckets[name] = b
	return b
}

func (s *Store) getBucket(name string) *S3Bucket {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.buckets[name]
}

func (s *Store) deleteBucket(name string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	delete(s.buckets, name)
}

func (s *Store) listBuckets() []*S3Bucket {
	s.mu.RLock()
	defer s.mu.RUnlock()
	var result []*S3Bucket
	for _, b := range s.buckets {
		result = append(result, b)
	}
	return result
}

func (s *Store) newVersionID() string {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.versionCounter++
	return fmt.Sprintf("ver-%d-%d", time.Now().UnixNano(), s.versionCounter)
}

// Handler is the HTTP handler for the S3 provider.
type Handler struct {
	state      *state.ServerState
	store      *Store
	sqsPort    int
	ebPort     int
	snsPort    int
	lambdaPort int
}

// NewHandler creates a new S3 handler and registers the reset callback.
func NewHandler(ss *state.ServerState, sqsPort, ebPort, snsPort, lambdaPort int) *Handler {
	store := NewStore()
	ss.AddResetCallback(store.Reset)
	return &Handler{state: ss, store: store, sqsPort: sqsPort, ebPort: ebPort, snsPort: snsPort, lambdaPort: lambdaPort}
}

// dispatchNotification fires an S3 event notification to the configured target.
func (h *Handler) dispatchNotification(bucket, key, eventName string) error {
	h.store.mu.RLock()
	b := h.store.buckets[bucket]
	var nc *NotificationConfig
	if b != nil {
		nc = b.Notification
	}
	h.store.mu.RUnlock()

	if nc == nil {
		return nil
	}

	event := map[string]interface{}{
		"Records": []map[string]interface{}{
			{
				"eventSource": "aws:s3",
				"eventName":   eventName,
				"s3": map[string]interface{}{
					"bucket": map[string]string{"name": bucket},
					"object": map[string]string{"key": key},
				},
			},
		},
	}
	eventBody, _ := json.Marshal(event)

	switch nc.Type {
	case "sqs":
		parts := strings.Split(nc.Target, ":")
		queueName := parts[len(parts)-1]
		queueURL := fmt.Sprintf("http://127.0.0.1:%d/000000000000/%s", h.sqsPort, queueName)
		payload, _ := json.Marshal(map[string]string{
			"QueueUrl":    queueURL,
			"MessageBody": string(eventBody),
		})
		req, _ := http.NewRequest("POST", fmt.Sprintf("http://127.0.0.1:%d/", h.sqsPort), bytes.NewReader(payload))
		req.Header.Set("Content-Type", "application/x-amz-json-1.0")
		req.Header.Set("X-Amz-Target", "AmazonSQS.SendMessage")
		resp, err := http.DefaultClient.Do(req)
		if err != nil {
			return err
		}
		resp.Body.Close()
	case "sns":
		payload, _ := json.Marshal(map[string]string{
			"TopicArn": nc.Target,
			"Message":  string(eventBody),
		})
		req, _ := http.NewRequest("POST", fmt.Sprintf("http://127.0.0.1:%d/", h.snsPort), bytes.NewReader(payload))
		req.Header.Set("Content-Type", "application/x-amz-json-1.0")
		req.Header.Set("X-Amz-Target", "SNS.Publish")
		resp, err := http.DefaultClient.Do(req)
		if err != nil {
			return err
		}
		resp.Body.Close()
	case "eventbridge":
		detailType := "Object Created"
		if strings.HasPrefix(eventName, "ObjectRemoved") {
			detailType = "Object Deleted"
		}
		payload, _ := json.Marshal(map[string]interface{}{
			"Entries": []map[string]string{
				{
					"Source":       "aws.s3",
					"DetailType":   detailType,
					"Detail":       string(eventBody),
					"EventBusName": nc.Target,
				},
			},
		})
		req, _ := http.NewRequest("POST", fmt.Sprintf("http://127.0.0.1:%d/", h.ebPort), bytes.NewReader(payload))
		req.Header.Set("Content-Type", "application/x-amz-json-1.0")
		req.Header.Set("X-Amz-Target", "AWSEvents.PutEvents")
		resp, err := http.DefaultClient.Do(req)
		if err != nil {
			return err
		}
		resp.Body.Close()
	case "lambda":
		parts := strings.Split(nc.Target, ":")
		functionName := parts[len(parts)-1]
		url := fmt.Sprintf("http://127.0.0.1:%d/2015-03-31/functions/%s/invocations", h.lambdaPort, functionName)
		req, _ := http.NewRequest("POST", url, bytes.NewReader(eventBody))
		req.Header.Set("Content-Type", "application/json")
		resp, err := http.DefaultClient.Do(req)
		if err != nil {
			return err
		}
		resp.Body.Close()
	}
	return nil
}

func xmlReply(w http.ResponseWriter, content string, status int) {
	w.Header().Set("Content-Type", "application/xml")
	w.WriteHeader(status)
	fmt.Fprintf(w, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>%s", content)
}

func xmlErr(w http.ResponseWriter, code, msg string, status int) {
	xmlReply(w, fmt.Sprintf("<Error><Code>%s</Code><Message>%s</Message></Error>", code, escapeXML(msg)), status)
}

func escapeXML(s string) string {
	s = strings.ReplaceAll(s, "&", "&amp;")
	s = strings.ReplaceAll(s, "<", "&lt;")
	s = strings.ReplaceAll(s, ">", "&gt;")
	return s
}

// ServeHTTP dispatches S3 REST requests.
func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	path := r.URL.Path
	parts := strings.SplitN(strings.TrimPrefix(path, "/"), "/", 2)
	bucket := ""
	key := ""
	if len(parts) >= 1 {
		bucket = parts[0]
	}
	if len(parts) >= 2 {
		key = parts[1]
	}

	operation := s3Operation(r, bucket, key)

	if state.ApplyIAMAuth(h.state, "s3", operation, r, w, true) {
		return
	}
	if state.ApplyChaos(h.state, "s3", operation, w, false, true) {
		return
	}

	h.handle(w, r, bucket, key, operation)
}

func s3Operation(r *http.Request, bucket, key string) string {
	q := r.URL.Query()
	switch r.Method {
	case http.MethodGet:
		if bucket == "" {
			return "ListBuckets"
		}
		if key == "" {
			if _, ok := q["location"]; ok {
				return "GetBucketLocation"
			}
			if _, ok := q["tagging"]; ok {
				return "GetBucketTagging"
			}
			if _, ok := q["policy"]; ok {
				return "GetBucketPolicy"
			}
			if _, ok := q["notification"]; ok {
				return "GetBucketNotificationConfiguration"
			}
			if _, ok := q["website"]; ok {
				return "GetBucketWebsite"
			}
			if _, ok := q["uploads"]; ok {
				return "ListMultipartUploads"
			}
			if _, ok := q["versioning"]; ok {
				return "GetBucketVersioning"
			}
			if _, ok := q["versions"]; ok {
				return "ListObjectVersions"
			}
			if _, ok := q["lifecycle"]; ok {
				return "GetBucketLifecycleConfiguration"
			}
			return "ListObjectsV2"
		}
		if _, ok := q["uploadId"]; ok {
			return "ListParts"
		}
		return "GetObject"
	case http.MethodPut:
		if key == "" {
			if _, ok := q["tagging"]; ok {
				return "PutBucketTagging"
			}
			if _, ok := q["policy"]; ok {
				return "PutBucketPolicy"
			}
			if _, ok := q["notification"]; ok {
				return "PutBucketNotificationConfiguration"
			}
			if _, ok := q["website"]; ok {
				return "PutBucketWebsite"
			}
			if _, ok := q["versioning"]; ok {
				return "PutBucketVersioning"
			}
			if _, ok := q["lifecycle"]; ok {
				return "PutBucketLifecycleConfiguration"
			}
			return "CreateBucket"
		}
		if _, ok := q["uploadId"]; ok {
			return "UploadPart"
		}
		if copySource := r.Header.Get("X-Amz-Copy-Source"); copySource != "" {
			return "CopyObject"
		}
		return "PutObject"
	case http.MethodDelete:
		if key == "" {
			if _, ok := q["tagging"]; ok {
				return "DeleteBucketTagging"
			}
			if _, ok := q["website"]; ok {
				return "DeleteBucketWebsite"
			}
			if _, ok := q["policy"]; ok {
				return "DeleteBucketPolicy"
			}
			if _, ok := q["lifecycle"]; ok {
				return "DeleteBucketLifecycle"
			}
			return "DeleteBucket"
		}
		if _, ok := q["uploadId"]; ok {
			return "AbortMultipartUpload"
		}
		return "DeleteObject"
	case http.MethodHead:
		if key == "" {
			return "HeadBucket"
		}
		return "HeadObject"
	case http.MethodPost:
		if _, ok := q["delete"]; ok {
			return "DeleteObjects"
		}
		if _, ok := q["uploads"]; ok {
			return "CreateMultipartUpload"
		}
		if _, ok := q["uploadId"]; ok {
			return "CompleteMultipartUpload"
		}
		return "PostObject"
	}
	return "Unknown"
}

// completeMultipartXML is used to parse the CompleteMultipartUpload body.
type completeMultipartXML struct {
	Parts []struct {
		PartNumber int    `xml:"PartNumber"`
		ETag       string `xml:"ETag"`
	} `xml:"Part"`
}

func (h *Handler) handle(w http.ResponseWriter, r *http.Request, bucket, key, operation string) {
	switch operation {

	// -----------------------------------------------------------------------
	// Bucket-level operations
	// -----------------------------------------------------------------------
	case "ListBuckets":
		buckets := h.store.listBuckets()
		bucketsXML := ""
		for _, b := range buckets {
			bucketsXML += fmt.Sprintf("<Bucket><Name>%s</Name><CreationDate>%s</CreationDate></Bucket>",
				escapeXML(b.Name), time.Now().UTC().Format(time.RFC3339))
		}
		xmlReply(w, fmt.Sprintf(`<ListAllMyBucketsResult><Owner><ID>%s</ID></Owner><Buckets>%s</Buckets></ListAllMyBucketsResult>`, accountID, bucketsXML), 200)

	case "CreateBucket":
		h.store.mu.Lock()
		if _, exists := h.store.buckets[bucket]; exists {
			h.store.mu.Unlock()
			xmlErr(w, "BucketAlreadyOwnedByYou", "Your previous request to create the named bucket succeeded and you already own it: "+bucket, 409)
			return
		}
		h.store.buckets[bucket] = &S3Bucket{Name: bucket, Objects: make(map[string]*S3Object)}
		h.store.mu.Unlock()
		w.Header().Set("Location", "/"+bucket)
		w.WriteHeader(200)

	case "DeleteBucket":
		h.store.mu.Lock()
		b, exists := h.store.buckets[bucket]
		if !exists {
			h.store.mu.Unlock()
			xmlErr(w, "NoSuchBucket", "The bucket does not exist: "+bucket, 404)
			return
		}
		if len(b.Objects) > 0 {
			h.store.mu.Unlock()
			xmlErr(w, "BucketNotEmpty", "The bucket you tried to delete is not empty: "+bucket, 409)
			return
		}
		delete(h.store.buckets, bucket)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "HeadBucket":
		b := h.store.getBucket(bucket)
		if b == nil {
			w.WriteHeader(404)
			return
		}
		w.WriteHeader(200)

	// -----------------------------------------------------------------------
	// Object listing
	// -----------------------------------------------------------------------
	case "ListObjectsV2":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "The bucket does not exist: "+bucket, 404)
			return
		}
		prefix := r.URL.Query().Get("prefix")
		var objsXML string
		count := 0
		h.store.mu.RLock()
		for _, obj := range b.Objects {
			if prefix == "" || strings.HasPrefix(obj.Key, prefix) {
				objsXML += fmt.Sprintf("<Contents><Key>%s</Key><Size>%d</Size><LastModified>%s</LastModified><ETag>%s</ETag></Contents>",
					escapeXML(obj.Key), obj.Size, obj.LastModified.Format(time.RFC3339), obj.ETag)
				count++
			}
		}
		h.store.mu.RUnlock()
		xmlReply(w, fmt.Sprintf(`<ListBucketResult><Name>%s</Name><KeyCount>%d</KeyCount><MaxKeys>1000</MaxKeys><IsTruncated>false</IsTruncated>%s</ListBucketResult>`,
			escapeXML(bucket), count, objsXML), 200)

	// -----------------------------------------------------------------------
	// Object CRUD
	// -----------------------------------------------------------------------
	case "PutObject":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "The bucket does not exist: "+bucket, 404)
			return
		}
		data, _ := io.ReadAll(r.Body)
		etag := fmt.Sprintf("\"%x\"", len(data))
		now := time.Now()

		h.store.mu.Lock()
		existing := b.Objects[key]
		newObj := &S3Object{
			Key:          key,
			Data:         data,
			ContentType:  r.Header.Get("Content-Type"),
			LastModified: now,
			ETag:         etag,
			Size:         int64(len(data)),
		}
		if b.VersioningEnabled {
			// Carry forward existing versions.
			if existing != nil {
				newObj.versions = append(existing.versions, ObjectVersion{
					VersionID:    h.store.newVersionIDLocked(),
					Data:         existing.Data,
					ContentType:  existing.ContentType,
					LastModified: existing.LastModified,
					ETag:         existing.ETag,
					Size:         existing.Size,
					IsLatest:     false,
				})
			}
			versionID := h.store.newVersionIDLocked()
			newObj.versions = append(newObj.versions, ObjectVersion{
				VersionID:    versionID,
				Data:         data,
				ContentType:  r.Header.Get("Content-Type"),
				LastModified: now,
				ETag:         etag,
				Size:         int64(len(data)),
				IsLatest:     true,
			})
			w.Header().Set("x-amz-version-id", versionID)
		}
		b.Objects[key] = newObj
		h.store.mu.Unlock()

		h.dispatchNotification(bucket, key, "ObjectCreated:Put") //nolint:errcheck
		w.Header().Set("ETag", etag)
		w.WriteHeader(200)

	case "GetObject":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "The bucket does not exist", 404)
			return
		}
		h.store.mu.RLock()
		obj, ok := b.Objects[key]
		h.store.mu.RUnlock()
		if !ok {
			xmlErr(w, "NoSuchKey", "The key does not exist: "+key, 404)
			return
		}

		// Version-specific GET.
		versionID := r.URL.Query().Get("versionId")
		if versionID != "" {
			h.store.mu.RLock()
			var found *ObjectVersion
			for i := range obj.versions {
				if obj.versions[i].VersionID == versionID {
					found = &obj.versions[i]
					break
				}
			}
			h.store.mu.RUnlock()
			if found == nil {
				xmlErr(w, "NoSuchVersion", "The version does not exist: "+versionID, 404)
				return
			}
			w.Header().Set("Content-Type", found.ContentType)
			w.Header().Set("ETag", found.ETag)
			w.Header().Set("Content-Length", fmt.Sprintf("%d", found.Size))
			w.Header().Set("x-amz-version-id", found.VersionID)
			w.WriteHeader(200)
			w.Write(found.Data)
			return
		}

		w.Header().Set("Content-Type", obj.ContentType)
		w.Header().Set("ETag", obj.ETag)
		w.Header().Set("Content-Length", fmt.Sprintf("%d", obj.Size))
		w.WriteHeader(200)
		w.Write(obj.Data)

	case "DeleteObject":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "The bucket does not exist: "+bucket, 404)
			return
		}
		h.store.mu.Lock()
		if _, ok := b.Objects[key]; !ok {
			h.store.mu.Unlock()
			xmlErr(w, "NoSuchKey", "The key does not exist: "+key, 404)
			return
		}
		delete(b.Objects, key)
		h.store.mu.Unlock()
		h.dispatchNotification(bucket, key, "ObjectRemoved:Delete") //nolint:errcheck
		w.WriteHeader(204)

	case "DeleteObjects":
		b := h.store.getBucket(bucket)
		// Parse XML body for multi-object delete.
		type deleteInput struct {
			Objects []struct {
				Key string `xml:"Key"`
			} `xml:"Object"`
		}
		var di deleteInput
		body, _ := io.ReadAll(r.Body)
		xml.Unmarshal(body, &di)
		var deletedXML string
		if b != nil {
			h.store.mu.Lock()
			for _, obj := range di.Objects {
				delete(b.Objects, obj.Key)
				deletedXML += fmt.Sprintf("<Deleted><Key>%s</Key></Deleted>", escapeXML(obj.Key))
			}
			h.store.mu.Unlock()
		}
		xmlReply(w, fmt.Sprintf("<DeleteResult>%s</DeleteResult>", deletedXML), 200)

	case "HeadObject":
		b := h.store.getBucket(bucket)
		if b == nil {
			w.WriteHeader(404)
			return
		}
		h.store.mu.RLock()
		obj, ok := b.Objects[key]
		h.store.mu.RUnlock()
		if !ok {
			w.WriteHeader(404)
			return
		}
		w.Header().Set("Content-Type", obj.ContentType)
		w.Header().Set("ETag", obj.ETag)
		w.Header().Set("Content-Length", fmt.Sprintf("%d", obj.Size))
		w.Header().Set("Last-Modified", obj.LastModified.UTC().Format(http.TimeFormat))
		w.WriteHeader(200)

	case "CopyObject":
		copySource := r.Header.Get("X-Amz-Copy-Source")
		copySource = strings.TrimPrefix(copySource, "/")
		srcParts := strings.SplitN(copySource, "/", 2)
		if len(srcParts) != 2 {
			xmlErr(w, "InvalidArgument", "Invalid copy source", 400)
			return
		}
		srcBucket := srcParts[0]
		srcKey := srcParts[1]
		sb := h.store.getBucket(srcBucket)
		if sb == nil {
			xmlErr(w, "NoSuchBucket", "Source bucket not found", 404)
			return
		}
		h.store.mu.RLock()
		srcObj, ok := sb.Objects[srcKey]
		h.store.mu.RUnlock()
		if !ok {
			xmlErr(w, "NoSuchKey", "Source key not found", 404)
			return
		}
		db := h.store.getBucket(bucket)
		if db == nil {
			xmlErr(w, "NoSuchBucket", "Destination bucket not found", 404)
			return
		}
		now := time.Now()
		newObj := &S3Object{
			Key:          key,
			Data:         srcObj.Data,
			ContentType:  srcObj.ContentType,
			LastModified: now,
			ETag:         srcObj.ETag,
			Size:         srcObj.Size,
		}
		h.store.mu.Lock()
		db.Objects[key] = newObj
		h.store.mu.Unlock()
		xmlReply(w, fmt.Sprintf(`<CopyObjectResult><LastModified>%s</LastModified><ETag>%s</ETag></CopyObjectResult>`,
			now.Format(time.RFC3339), newObj.ETag), 200)

	// -----------------------------------------------------------------------
	// Versioning
	// -----------------------------------------------------------------------
	case "GetBucketVersioning":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "Bucket not found", 404)
			return
		}
		h.store.mu.RLock()
		enabled := b.VersioningEnabled
		h.store.mu.RUnlock()
		status := ""
		if enabled {
			status = "<Status>Enabled</Status>"
		}
		xmlReply(w, fmt.Sprintf(`<VersioningConfiguration>%s</VersioningConfiguration>`, status), 200)

	case "PutBucketVersioning":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "Bucket not found", 404)
			return
		}
		body, _ := io.ReadAll(r.Body)
		bodyStr := string(body)
		h.store.mu.Lock()
		b.VersioningEnabled = strings.Contains(bodyStr, "<Status>Enabled</Status>")
		h.store.mu.Unlock()
		w.WriteHeader(200)

	case "ListObjectVersions":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "Bucket not found", 404)
			return
		}
		prefix := r.URL.Query().Get("prefix")
		var versionsXML string
		h.store.mu.RLock()
		for _, obj := range b.Objects {
			if prefix != "" && !strings.HasPrefix(obj.Key, prefix) {
				continue
			}
			for _, v := range obj.versions {
				isLatest := "false"
				if v.IsLatest {
					isLatest = "true"
				}
				versionsXML += fmt.Sprintf(`<Version><Key>%s</Key><VersionId>%s</VersionId><IsLatest>%s</IsLatest><LastModified>%s</LastModified><ETag>%s</ETag><Size>%d</Size></Version>`,
					escapeXML(obj.Key), v.VersionID, isLatest, v.LastModified.Format(time.RFC3339), v.ETag, v.Size)
			}
		}
		h.store.mu.RUnlock()
		xmlReply(w, fmt.Sprintf(`<ListVersionsResult><Name>%s</Name>%s</ListVersionsResult>`, escapeXML(bucket), versionsXML), 200)

	// -----------------------------------------------------------------------
	// Lifecycle
	// -----------------------------------------------------------------------
	case "GetBucketLifecycleConfiguration":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "Bucket not found", 404)
			return
		}
		h.store.mu.RLock()
		rules := b.LifecycleRules
		h.store.mu.RUnlock()
		if len(rules) == 0 {
			xmlErr(w, "NoSuchLifecycleConfiguration", "Lifecycle configuration does not exist", 404)
			return
		}
		var rulesXML string
		for _, rule := range rules {
			rulesXML += fmt.Sprintf("<Rule><ID>%s</ID><Status>%s</Status></Rule>", escapeXML(rule.ID), escapeXML(rule.Status))
		}
		xmlReply(w, fmt.Sprintf(`<LifecycleConfiguration>%s</LifecycleConfiguration>`, rulesXML), 200)

	case "PutBucketLifecycleConfiguration":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "Bucket not found", 404)
			return
		}
		body, _ := io.ReadAll(r.Body)
		// Parse rules from XML.
		type ruleXML struct {
			ID     string `xml:"ID"`
			Status string `xml:"Status"`
		}
		type lifecycleXML struct {
			Rules []ruleXML `xml:"Rule"`
		}
		var lc lifecycleXML
		xml.Unmarshal(body, &lc)
		h.store.mu.Lock()
		b.LifecycleRules = nil
		for _, r := range lc.Rules {
			b.LifecycleRules = append(b.LifecycleRules, LifecycleRule{
				ID:     r.ID,
				Status: r.Status,
			})
		}
		h.store.mu.Unlock()
		w.WriteHeader(200)

	case "DeleteBucketLifecycle":
		b := h.store.getBucket(bucket)
		if b != nil {
			h.store.mu.Lock()
			b.LifecycleRules = nil
			h.store.mu.Unlock()
		}
		w.WriteHeader(204)

	// -----------------------------------------------------------------------
	// Multipart uploads
	// -----------------------------------------------------------------------
	case "CreateMultipartUpload":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "The bucket does not exist: "+bucket, 404)
			return
		}
		// Check if an in-progress upload already exists for this bucket+key.
		h.store.mu.RLock()
		for _, mp := range h.store.multiparts {
			if mp.Bucket == bucket && mp.Key == key {
				h.store.mu.RUnlock()
				xmlErr(w, "OperationAborted", "A conflicting conditional operation is currently in progress against this resource: "+bucket+"/"+key, 409)
				return
			}
		}
		h.store.mu.RUnlock()
		uploadID := fmt.Sprintf("upload-%d", time.Now().UnixNano())
		h.store.mu.Lock()
		h.store.multiparts[uploadID] = &MultipartUpload{
			UploadID:    uploadID,
			Bucket:      bucket,
			Key:         key,
			ContentType: r.Header.Get("Content-Type"),
			Parts:       make(map[int]*MultipartPart),
		}
		h.store.mu.Unlock()
		xmlReply(w, fmt.Sprintf(`<InitiateMultipartUploadResult><Bucket>%s</Bucket><Key>%s</Key><UploadId>%s</UploadId></InitiateMultipartUploadResult>`,
			escapeXML(bucket), escapeXML(key), uploadID), 200)

	case "UploadPart":
		uploadID := r.URL.Query().Get("uploadId")
		partNumberStr := r.URL.Query().Get("partNumber")
		partNumber, _ := strconv.Atoi(partNumberStr)
		data, _ := io.ReadAll(r.Body)
		etag := fmt.Sprintf("\"%x\"", len(data))

		h.store.mu.Lock()
		mp, ok := h.store.multiparts[uploadID]
		if !ok {
			h.store.mu.Unlock()
			xmlErr(w, "NoSuchUpload", "The specified upload does not exist: "+uploadID, 404)
			return
		}
		mp.Parts[partNumber] = &MultipartPart{
			PartNumber: partNumber,
			Data:       data,
			ETag:       etag,
		}
		h.store.mu.Unlock()

		w.Header().Set("ETag", etag)
		w.WriteHeader(200)

	case "CompleteMultipartUpload":
		uploadID := r.URL.Query().Get("uploadId")
		body, _ := io.ReadAll(r.Body)

		var cmp completeMultipartXML
		xml.Unmarshal(body, &cmp)

		h.store.mu.Lock()
		mp, ok := h.store.multiparts[uploadID]
		if !ok {
			h.store.mu.Unlock()
			xmlErr(w, "NoSuchUpload", "Upload not found: "+uploadID, 404)
			return
		}
		// Fail if the upload has no parts.
		if len(mp.Parts) == 0 && len(cmp.Parts) == 0 {
			h.store.mu.Unlock()
			xmlErr(w, "InvalidRequest", "You must specify at least one part", 400)
			return
		}

		// Sort parts by PartNumber and concatenate.
		partNums := make([]int, 0, len(cmp.Parts))
		for _, p := range cmp.Parts {
			partNums = append(partNums, p.PartNumber)
		}
		sort.Ints(partNums)

		var combined []byte
		for _, pn := range partNums {
			if part, exists := mp.Parts[pn]; exists {
				combined = append(combined, part.Data...)
			}
		}

		etag := fmt.Sprintf("\"%x\"", len(combined))
		now := time.Now()
		bkt := h.store.buckets[mp.Bucket]
		if bkt != nil {
			bkt.Objects[mp.Key] = &S3Object{
				Key:          mp.Key,
				Data:         combined,
				ContentType:  mp.ContentType,
				LastModified: now,
				ETag:         etag,
				Size:         int64(len(combined)),
			}
		}
		delete(h.store.multiparts, uploadID)
		h.store.mu.Unlock()

		xmlReply(w, fmt.Sprintf(`<CompleteMultipartUploadResult><Location>http://127.0.0.1/%s/%s</Location><Bucket>%s</Bucket><Key>%s</Key><ETag>%s</ETag></CompleteMultipartUploadResult>`,
			escapeXML(bucket), escapeXML(key), escapeXML(bucket), escapeXML(key), etag), 200)

	case "AbortMultipartUpload":
		uploadID := r.URL.Query().Get("uploadId")
		h.store.mu.Lock()
		if _, ok := h.store.multiparts[uploadID]; !ok {
			h.store.mu.Unlock()
			xmlErr(w, "NoSuchUpload", "The specified upload does not exist: "+uploadID, 404)
			return
		}
		delete(h.store.multiparts, uploadID)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "ListParts":
		uploadID := r.URL.Query().Get("uploadId")
		h.store.mu.RLock()
		mp, ok := h.store.multiparts[uploadID]
		h.store.mu.RUnlock()
		var partsXML string
		if ok {
			var partNums []int
			for pn := range mp.Parts {
				partNums = append(partNums, pn)
			}
			sort.Ints(partNums)
			for _, pn := range partNums {
				p := mp.Parts[pn]
				partsXML += fmt.Sprintf("<Part><PartNumber>%d</PartNumber><ETag>%s</ETag><Size>%d</Size></Part>",
					p.PartNumber, p.ETag, len(p.Data))
			}
		}
		xmlReply(w, fmt.Sprintf(`<ListPartsResult><Bucket>%s</Bucket><Key>%s</Key><UploadId>%s</UploadId><Parts>%s</Parts></ListPartsResult>`,
			escapeXML(bucket), escapeXML(key), uploadID, partsXML), 200)

	case "ListMultipartUploads":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "Bucket not found", 404)
			return
		}
		h.store.mu.RLock()
		var uploadsXML string
		for _, mp := range h.store.multiparts {
			if mp.Bucket == bucket {
				uploadsXML += fmt.Sprintf("<Upload><Key>%s</Key><UploadId>%s</UploadId></Upload>",
					escapeXML(mp.Key), mp.UploadID)
			}
		}
		h.store.mu.RUnlock()
		xmlReply(w, fmt.Sprintf(`<ListMultipartUploadsResult><Bucket>%s</Bucket>%s</ListMultipartUploadsResult>`,
			escapeXML(bucket), uploadsXML), 200)

	// -----------------------------------------------------------------------
	// Bucket tag / policy / notification / website / location
	// -----------------------------------------------------------------------
	case "GetBucketLocation":
		xmlReply(w, fmt.Sprintf(`<LocationConstraint>%s</LocationConstraint>`, region), 200)

	case "GetBucketTagging":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "Bucket not found", 404)
			return
		}
		tagsXML := ""
		for _, tag := range b.Tags {
			tagsXML += fmt.Sprintf("<Tag><Key>%s</Key><Value>%s</Value></Tag>", tag["Key"], tag["Value"])
		}
		xmlReply(w, fmt.Sprintf(`<Tagging><TagSet>%s</TagSet></Tagging>`, tagsXML), 200)

	case "PutBucketTagging":
		b := h.store.getBucket(bucket)
		if b != nil {
			b.Tags = nil
		}
		w.WriteHeader(204)

	case "DeleteBucketTagging":
		b := h.store.getBucket(bucket)
		if b != nil {
			b.Tags = nil
		}
		w.WriteHeader(204)

	case "GetBucketPolicy":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "Bucket not found", 404)
			return
		}
		if b.Policy == "" {
			xmlErr(w, "NoSuchBucketPolicy", "The bucket policy does not exist", 404)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(200)
		w.Write([]byte(b.Policy))

	case "PutBucketPolicy":
		b := h.store.getBucket(bucket)
		if b != nil {
			data, _ := io.ReadAll(r.Body)
			b.Policy = string(data)
		}
		w.WriteHeader(204)

	case "DeleteBucketPolicy":
		b := h.store.getBucket(bucket)
		if b != nil {
			b.Policy = ""
		}
		w.WriteHeader(204)

	case "GetBucketNotificationConfiguration":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "The bucket does not exist", 404)
			return
		}
		h.store.mu.RLock()
		nc := b.Notification
		h.store.mu.RUnlock()
		if nc == nil || nc.Type == "" {
			xmlReply(w, `<NotificationConfiguration></NotificationConfiguration>`, 200)
			return
		}
		var inner string
		switch nc.Type {
		case "sqs":
			inner = fmt.Sprintf(`<QueueConfiguration><Queue>%s</Queue><Event>s3:ObjectCreated:*</Event></QueueConfiguration>`, escapeXML(nc.Target))
		case "sns":
			inner = fmt.Sprintf(`<TopicConfiguration><Topic>%s</Topic><Event>s3:ObjectCreated:*</Event></TopicConfiguration>`, escapeXML(nc.Target))
		case "eventbridge":
			inner = `<EventBridgeConfiguration></EventBridgeConfiguration>`
		}
		xmlReply(w, fmt.Sprintf(`<NotificationConfiguration>%s</NotificationConfiguration>`, inner), 200)

	case "PutBucketNotificationConfiguration":
		b := h.store.getBucket(bucket)
		if b == nil {
			xmlErr(w, "NoSuchBucket", "The bucket does not exist", 404)
			return
		}
		var xmlConfig struct {
			QueueConfig *struct {
				QueueArn string `xml:"Queue"`
			} `xml:"QueueConfiguration"`
			TopicConfig *struct {
				TopicArn string `xml:"Topic"`
			} `xml:"TopicConfiguration"`
			EventBridgeConfig  *struct{} `xml:"EventBridgeConfiguration"`
			LambdaFunctionConfig *struct {
				FunctionArn string `xml:"CloudFunction"`
			} `xml:"CloudFunctionConfiguration"`
		}
		body, _ := io.ReadAll(r.Body)
		if err := xml.Unmarshal(body, &xmlConfig); err != nil {
			xmlErr(w, "MalformedXML", "Malformed notification configuration XML", 400)
			return
		}
		var nc NotificationConfig
		if xmlConfig.QueueConfig != nil {
			nc.Type = "sqs"
			nc.Target = xmlConfig.QueueConfig.QueueArn
		} else if xmlConfig.TopicConfig != nil {
			nc.Type = "sns"
			nc.Target = xmlConfig.TopicConfig.TopicArn
		} else if xmlConfig.EventBridgeConfig != nil {
			nc.Type = "eventbridge"
			nc.Target = "default"
		} else if xmlConfig.LambdaFunctionConfig != nil {
			nc.Type = "lambda"
			nc.Target = xmlConfig.LambdaFunctionConfig.FunctionArn
		}
		if nc.Type == "sqs" {
			parts := strings.Split(nc.Target, ":")
			queueName := parts[len(parts)-1]
			queueURL := fmt.Sprintf("http://127.0.0.1:%d/000000000000/%s", h.sqsPort, queueName)
			payload, _ := json.Marshal(map[string]string{
				"QueueUrl":       queueURL,
				"AttributeNames": "All",
			})
			req, _ := http.NewRequest("POST", fmt.Sprintf("http://127.0.0.1:%d/", h.sqsPort), bytes.NewReader(payload))
			req.Header.Set("Content-Type", "application/x-amz-json-1.0")
			req.Header.Set("X-Amz-Target", "AmazonSQS.GetQueueAttributes")
			resp, err := http.DefaultClient.Do(req)
			if err == nil {
				vbody, _ := io.ReadAll(resp.Body)
				resp.Body.Close()
				if resp.StatusCode != 200 {
					xmlErr(w, "InvalidArgument", "SQS queue not found or not active: "+string(vbody), 400)
					return
				}
			}
		} else if nc.Type == "eventbridge" {
			payload, _ := json.Marshal(map[string]string{"Name": nc.Target})
			req, _ := http.NewRequest("POST", fmt.Sprintf("http://127.0.0.1:%d/", h.ebPort), bytes.NewReader(payload))
			req.Header.Set("Content-Type", "application/x-amz-json-1.0")
			req.Header.Set("X-Amz-Target", "AWSEvents.DescribeEventBus")
			resp, err := http.DefaultClient.Do(req)
			if err == nil {
				vbody, _ := io.ReadAll(resp.Body)
				resp.Body.Close()
				if resp.StatusCode != 200 {
					xmlErr(w, "InvalidArgument", "EventBridge bus not found or not active: "+string(vbody), 400)
					return
				}
			}
		} else if nc.Type == "lambda" {
			parts := strings.Split(nc.Target, ":")
			functionName := parts[len(parts)-1]
			url := fmt.Sprintf("http://127.0.0.1:%d/2015-03-31/functions/%s", h.lambdaPort, functionName)
			req, _ := http.NewRequest("GET", url, nil)
			resp, err := http.DefaultClient.Do(req)
			if err == nil {
				vbody, _ := io.ReadAll(resp.Body)
				resp.Body.Close()
				if resp.StatusCode != 200 {
					xmlErr(w, "InvalidArgument", "Lambda function not found: "+string(vbody), 400)
					return
				}
			}
		}
		h.store.mu.Lock()
		b.Notification = &nc
		h.store.mu.Unlock()
		w.WriteHeader(200)

	case "GetBucketWebsite":
		xmlErr(w, "NoSuchWebsiteConfiguration", "The specified bucket does not have a website configuration", 404)

	case "PutBucketWebsite":
		w.WriteHeader(200)

	case "DeleteBucketWebsite":
		w.WriteHeader(204)

	default:
		xmlErr(w, "NotImplemented", "Operation not implemented: "+operation, 501)
	}
}

// newVersionIDLocked generates a new version ID; caller must hold s.mu write lock.
func (s *Store) newVersionIDLocked() string {
	s.versionCounter++
	return fmt.Sprintf("ver-%d-%d", time.Now().UnixNano(), s.versionCounter)
}
