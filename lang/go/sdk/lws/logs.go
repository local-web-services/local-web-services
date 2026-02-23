package lws

import (
	"encoding/json"
	"fmt"
	"sync"
	"testing"
	"time"

	"github.com/gorilla/websocket"
)

// LogEntry represents a single request log entry streamed from ldk.
type LogEntry struct {
	Service    string  `json:"service"`
	Operation  string  `json:"handler"`
	Level      string  `json:"level"`
	StatusCode int     `json:"status_code"`
	DurationMs float64 `json:"duration_ms"`
	Timestamp  string  `json:"timestamp"`
}

// LogCapture records log entries streamed from the ldk WebSocket endpoint.
// Obtain one via Session.StartLogCapture() and call Stop() when done.
type LogCapture struct {
	mu      sync.Mutex
	entries []LogEntry
	conn    *websocket.Conn
	done    chan struct{}
}

func newLogCapture(s *Session) (*LogCapture, error) {
	url := fmt.Sprintf("ws://127.0.0.1:%d/_ldk/ws/logs", s.basePort)
	conn, _, err := websocket.DefaultDialer.Dial(url, nil)
	if err != nil {
		return nil, fmt.Errorf("log capture: dial: %w", err)
	}

	lc := &LogCapture{
		conn: conn,
		done: make(chan struct{}),
	}

	go lc.readLoop()
	return lc, nil
}

func (c *LogCapture) readLoop() {
	defer close(c.done)
	for {
		_, msg, err := c.conn.ReadMessage()
		if err != nil {
			return
		}
		var entry LogEntry
		if jsonErr := json.Unmarshal(msg, &entry); jsonErr == nil {
			c.mu.Lock()
			c.entries = append(c.entries, entry)
			c.mu.Unlock()
		}
	}
}

// Stop closes the WebSocket connection and waits for the read loop to finish.
func (c *LogCapture) Stop() {
	c.conn.Close() //nolint:errcheck
	<-c.done
}

// Entries returns a snapshot of all captured log entries.
func (c *LogCapture) Entries() []LogEntry {
	c.mu.Lock()
	defer c.mu.Unlock()
	result := make([]LogEntry, len(c.entries))
	copy(result, c.entries)
	return result
}

// AssertCalled fails the test if no log entry matches the given service and operation.
// It polls for up to 5 seconds to allow for asynchronous WebSocket delivery.
func (c *LogCapture) AssertCalled(t testing.TB, service, operation string) {
	t.Helper()
	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		for _, e := range c.Entries() {
			if e.Service == service && e.Operation == operation {
				return
			}
		}
		time.Sleep(50 * time.Millisecond)
	}
	t.Errorf("log capture: expected call to %s/%s but none was recorded", service, operation)
}

// AssertNotCalled fails the test if any log entry matches the given service and operation.
func (c *LogCapture) AssertNotCalled(t testing.TB, service, operation string) {
	t.Helper()
	for _, e := range c.Entries() {
		if e.Service == service && e.Operation == operation {
			t.Errorf("log capture: expected no call to %s/%s but one was recorded", service, operation)
			return
		}
	}
}

// AssertCallCount fails the test if the number of matching entries differs from n.
func (c *LogCapture) AssertCallCount(t testing.TB, service, operation string, n int) {
	t.Helper()
	count := 0
	for _, e := range c.Entries() {
		if e.Service == service && e.Operation == operation {
			count++
		}
	}
	if count != n {
		t.Errorf("log capture: expected %d call(s) to %s/%s but got %d", n, service, operation, count)
	}
}

// AssertNoErrors fails the test if any log entry has a 5xx status code.
func (c *LogCapture) AssertNoErrors(t testing.TB) {
	t.Helper()
	for _, e := range c.Entries() {
		if e.StatusCode >= 500 {
			t.Errorf("log capture: unexpected error entry: service=%s operation=%s status=%d",
				e.Service, e.Operation, e.StatusCode)
		}
	}
}
