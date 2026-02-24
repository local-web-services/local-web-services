package lws

// SessionSpec declares the AWS resources to create in the local session.
type SessionSpec struct {
	Tables        []TableSpec
	Queues        []string
	Buckets       []string
	Topics        []string
	StateMachines []StateMachineSpec
	Parameters    []string
	Secrets       []string
}

// TableSpec describes a DynamoDB table.
type TableSpec struct {
	Name         string
	PartitionKey string
	SortKey      string
}

// StateMachineSpec describes a Step Functions state machine.
type StateMachineSpec struct {
	Name       string
	Definition string
	RoleArn    string
}
