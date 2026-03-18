package lws

import (
	"net/http"

	lwsstate "github.com/local-web-services/local-web-services-go-core/lws/state"
)

// ApplyChaos delegates to lws/state.ApplyChaos.
func ApplyChaos(s *ServerState, service, operation string, w http.ResponseWriter, isXML bool, isS3 bool) bool {
	return lwsstate.ApplyChaos(s, service, operation, w, isXML, isS3)
}
