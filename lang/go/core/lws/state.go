package lws

import (
	lwsstate "github.com/local-web-services/local-web-services-go-core/lws/state"
)

// Re-export types from lws/state so callers of the lws package don't need to
// import lws/state directly.

type ServerState = lwsstate.ServerState
type ChaosRule = lwsstate.ChaosRule
type IamStatement = lwsstate.IamStatement
type IamPolicy = lwsstate.IamPolicy
type IamIdentity = lwsstate.IamIdentity
type IamConfig = lwsstate.IamConfig
type LogEntry = lwsstate.LogEntry

func NewServerState() *ServerState {
	return lwsstate.NewServerState()
}

type FakeResponse = lwsstate.FakeResponse
type FakeRule = lwsstate.FakeRule
type CapacityRule = lwsstate.CapacityRule
type LifecycleRule = lwsstate.LifecycleRule
