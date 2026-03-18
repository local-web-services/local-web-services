package lws

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
)

func managementPost(port int, path string, body interface{}) error {
	data, err := json.Marshal(body)
	if err != nil {
		return err
	}
	resp, err := http.Post(fmt.Sprintf("http://127.0.0.1:%d%s", port, path), "application/json", bytes.NewReader(data))
	if err != nil {
		return err
	}
	resp.Body.Close()
	return nil
}

func managementGet(port int, path string) (map[string]interface{}, error) {
	resp, err := http.Get(fmt.Sprintf("http://127.0.0.1:%d%s", port, path))
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	data, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}
	var result map[string]interface{}
	if err := json.Unmarshal(data, &result); err != nil {
		return nil, err
	}
	return result, nil
}

// ChaosEnable enables chaos for a service.
func ChaosEnable(port int, service string) error {
	return managementPost(port, "/_ldk/chaos", map[string]interface{}{
		service: map[string]interface{}{"enabled": true},
	})
}

// ChaosDisable disables chaos for a service.
func ChaosDisable(port int, service string) error {
	return managementPost(port, "/_ldk/chaos", map[string]interface{}{
		service: map[string]interface{}{"enabled": false},
	})
}

// ChaosSet sets chaos config for a service.
func ChaosSet(port int, service string, errorRate float64, latencyMin, latencyMax int) error {
	config := map[string]interface{}{"enabled": true}
	if errorRate > 0 {
		config["error_rate"] = errorRate
	}
	if latencyMin > 0 {
		config["latency_min_ms"] = latencyMin
	}
	if latencyMax > 0 {
		config["latency_max_ms"] = latencyMax
	}
	return managementPost(port, "/_ldk/chaos", map[string]interface{}{service: config})
}

// ChaosStatus returns chaos status for all services.
func ChaosStatus(port int) (map[string]interface{}, error) {
	return managementGet(port, "/_ldk/chaos")
}

// IamSet sets IAM mode.
func IamSet(port int, service, mode string) error {
	return managementPost(port, "/_ldk/iam-auth", map[string]interface{}{"mode": mode})
}

// IamDisable disables IAM auth.
func IamDisable(port int, service string) error {
	return managementPost(port, "/_ldk/iam-auth", map[string]interface{}{"mode": "disabled"})
}

// IamSetIdentity sets the default identity.
func IamSetIdentity(port int, identity string) error {
	return managementPost(port, "/_ldk/iam-auth", map[string]interface{}{"default_identity": identity})
}

// IamRegisterIdentities registers identity definitions.
func IamRegisterIdentities(port int, identities map[string]interface{}) error {
	return managementPost(port, "/_ldk/iam-auth", map[string]interface{}{"identities": identities})
}

// Reset resets all server state.
func Reset(port int) error {
	return managementPost(port, "/_ldk/reset", map[string]interface{}{})
}

// LifecycleSet configures lifecycle simulation for a service.
// Use createDwellMs > 0 to hold resources in CREATING state before ACTIVE.
// Use deleteDwellMs > 0 to hold resources in DELETING state before removal.
func LifecycleSet(port int, service string, createDwellMs, deleteDwellMs int) error {
	config := map[string]interface{}{"enabled": true}
	if createDwellMs > 0 {
		config["create_dwell_ms"] = createDwellMs
	}
	if deleteDwellMs > 0 {
		config["delete_dwell_ms"] = deleteDwellMs
	}
	return managementPost(port, "/_ldk/lifecycle", map[string]interface{}{service: config})
}

// LifecycleDisable disables lifecycle simulation for a service.
func LifecycleDisable(port int, service string) error {
	return managementPost(port, "/_ldk/lifecycle", map[string]interface{}{
		service: map[string]interface{}{"enabled": false, "create_dwell_ms": 0, "delete_dwell_ms": 0},
	})
}
