package lws

import (
	"net/http"

	lwsstate "github.com/local-web-services/local-web-services-go-core/lws/state"
)

// ApplyIAMAuth delegates to lws/state.ApplyIAMAuth.
func ApplyIAMAuth(s *ServerState, service, operation string, r *http.Request, w http.ResponseWriter, isXML bool) bool {
	return lwsstate.ApplyIAMAuth(s, service, operation, r, w, isXML)
}
