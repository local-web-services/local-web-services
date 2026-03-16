package lws

// ManagementSdk provides a programmatic interface to the management API.
type ManagementSdk struct {
	port int
}

// NewManagementSdk creates a new ManagementSdk.
func NewManagementSdk(port int) *ManagementSdk {
	return &ManagementSdk{port: port}
}

// ChaosEnable enables chaos for a service.
func (s *ManagementSdk) ChaosEnable(service string) error {
	return ChaosEnable(s.port, service)
}

// ChaosDisable disables chaos for a service.
func (s *ManagementSdk) ChaosDisable(service string) error {
	return ChaosDisable(s.port, service)
}

// ChaosSet sets chaos configuration for a service.
func (s *ManagementSdk) ChaosSet(service string, errorRate float64, latencyMin, latencyMax int) error {
	return ChaosSet(s.port, service, errorRate, latencyMin, latencyMax)
}

// ChaosStatus returns the current chaos status.
func (s *ManagementSdk) ChaosStatus() (map[string]interface{}, error) {
	return ChaosStatus(s.port)
}

// IamSet sets the IAM mode.
func (s *ManagementSdk) IamSet(service, mode string) error {
	return IamSet(s.port, service, mode)
}

// IamDisable disables IAM auth.
func (s *ManagementSdk) IamDisable(service string) error {
	return IamDisable(s.port, service)
}

// IamSetIdentity sets the default identity.
func (s *ManagementSdk) IamSetIdentity(identity string) error {
	return IamSetIdentity(s.port, identity)
}

// IamRegisterIdentities registers identity definitions.
func (s *ManagementSdk) IamRegisterIdentities(identities map[string]interface{}) error {
	return IamRegisterIdentities(s.port, identities)
}

// Reset resets all state.
func (s *ManagementSdk) Reset() error {
	return Reset(s.port)
}
