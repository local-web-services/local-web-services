package lws

import (
	"net/http"

	lwsstate "github.com/local-web-services/local-web-services-go-core/lws/state"
)

func writeJSON(w http.ResponseWriter, data interface{}, status int) {
	lwsstate.WriteJSON(w, data, status)
}

func writeJSONError(w http.ResponseWriter, code, message string, status int) {
	lwsstate.WriteJSONError(w, code, message, status)
}

func nowISO() string {
	return lwsstate.NowISO()
}

func newRequestID() string {
	return lwsstate.NewRequestID()
}

func escapeXML(s string) string {
	return lwsstate.EscapeXML(s)
}
