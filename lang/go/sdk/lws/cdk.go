package lws

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
)

// cdkManifest is the top-level structure of a CDK cloud assembly manifest.json.
type cdkManifest struct {
	Artifacts map[string]cdkArtifact `json:"artifacts"`
}

type cdkArtifact struct {
	Type       string             `json:"type"`
	Properties cdkArtifactProps   `json:"properties"`
}

type cdkArtifactProps struct {
	TemplateFile string `json:"templateFile"`
}

// cdkTemplate is the structure of a CloudFormation template file produced by CDK synthesis.
type cdkTemplate struct {
	Resources map[string]cdkResource `json:"Resources"`
}

type cdkResource struct {
	Type       string                 `json:"Type"`
	Properties map[string]interface{} `json:"Properties"`
}

// FromCdk creates a session by discovering resources from a synthesised CDK
// cloud assembly located at projectDir/cdk.out.
func FromCdk(projectDir string) (*Session, error) {
	spec, err := DiscoverCdk(projectDir)
	if err != nil {
		return nil, fmt.Errorf("CDK discovery failed: %w", err)
	}
	return New(spec)
}

// DiscoverCdk parses a synthesised CDK cloud assembly at projectDir/cdk.out
// and returns a SessionSpec describing the discovered resources.
//
// Only resources with plain-string name properties are included; resources
// whose names are defined via CloudFormation intrinsic functions are skipped.
func DiscoverCdk(projectDir string) (SessionSpec, error) {
	cdkOut := filepath.Join(projectDir, "cdk.out")
	manifestPath := filepath.Join(cdkOut, "manifest.json")
	manifestData, err := os.ReadFile(manifestPath)
	if err != nil {
		return SessionSpec{}, fmt.Errorf("read cdk manifest: %w", err)
	}

	var manifest cdkManifest
	if err := json.Unmarshal(manifestData, &manifest); err != nil {
		return SessionSpec{}, fmt.Errorf("parse cdk manifest: %w", err)
	}

	var spec SessionSpec
	for _, artifact := range manifest.Artifacts {
		if artifact.Type != "aws:cloudformation:stack" {
			continue
		}
		templatePath := filepath.Join(cdkOut, artifact.Properties.TemplateFile)
		templateData, err := os.ReadFile(templatePath)
		if err != nil {
			return SessionSpec{}, fmt.Errorf("read template %q: %w", artifact.Properties.TemplateFile, err)
		}

		var tmpl cdkTemplate
		if err := json.Unmarshal(templateData, &tmpl); err != nil {
			return SessionSpec{}, fmt.Errorf("parse template %q: %w", artifact.Properties.TemplateFile, err)
		}

		for _, resource := range tmpl.Resources {
			props := resource.Properties
			switch resource.Type {
			case "AWS::DynamoDB::Table":
				name := stringProp(props, "TableName")
				if name == "" {
					continue
				}
				ts := TableSpec{Name: name}
				if ks, ok := props["KeySchema"].([]interface{}); ok {
					for _, elem := range ks {
						m, ok := elem.(map[string]interface{})
						if !ok {
							continue
						}
						attrName, _ := m["AttributeName"].(string)
						keyType, _ := m["KeyType"].(string)
						switch keyType {
						case "HASH":
							ts.PartitionKey = attrName
						case "RANGE":
							ts.SortKey = attrName
						}
					}
				}
				if ts.PartitionKey != "" {
					spec.Tables = append(spec.Tables, ts)
				}
			case "AWS::SQS::Queue":
				name := stringProp(props, "QueueName")
				if name != "" {
					spec.Queues = append(spec.Queues, name)
				}
			case "AWS::S3::Bucket":
				name := stringProp(props, "BucketName")
				if name != "" {
					spec.Buckets = append(spec.Buckets, name)
				}
			case "AWS::SNS::Topic":
				name := stringProp(props, "TopicName")
				if name != "" {
					spec.Topics = append(spec.Topics, name)
				}
			case "AWS::StepFunctions::StateMachine":
				name := stringProp(props, "StateMachineName")
				if name == "" {
					continue
				}
				def := stringProp(props, "DefinitionString")
				if def == "" {
					def = "{}"
				}
				spec.StateMachines = append(spec.StateMachines, StateMachineSpec{
					Name:       name,
					Definition: def,
				})
			case "AWS::SSM::Parameter":
				name := stringProp(props, "Name")
				if name != "" {
					spec.Parameters = append(spec.Parameters, name)
				}
			case "AWS::SecretsManager::Secret":
				name := stringProp(props, "Name")
				if name != "" {
					spec.Secrets = append(spec.Secrets, name)
				}
			}
		}
	}

	return spec, nil
}

// stringProp extracts a plain-string value from a CloudFormation properties map.
// Returns "" if the key is absent or its value is not a plain string
// (e.g. a CloudFormation intrinsic function object).
func stringProp(props map[string]interface{}, key string) string {
	v, ok := props[key]
	if !ok {
		return ""
	}
	s, ok := v.(string)
	if !ok {
		return ""
	}
	return s
}
