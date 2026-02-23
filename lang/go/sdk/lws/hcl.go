package lws

import (
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

var (
	reResourceHeader = regexp.MustCompile(`^\s*resource\s+"(\w+)"\s+"\w+"\s*\{\s*$`)
	reAttrStr        = regexp.MustCompile(`^\s*(\w+)\s*=\s*"([^"]*)"\s*$`)
	reAttrHeredoc    = regexp.MustCompile(`^\s*(\w+)\s*=\s*<<(\w+)\s*$`)
)

// DiscoverHcl scans all .tf files under projectDir and returns a SessionSpec
// describing the discovered resources.
func DiscoverHcl(projectDir string) (SessionSpec, error) {
	var spec SessionSpec
	err := filepath.Walk(projectDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() && strings.HasSuffix(path, ".tf") {
			partial, parseErr := parseTfFile(path)
			if parseErr != nil {
				return parseErr
			}
			spec.Tables = append(spec.Tables, partial.Tables...)
			spec.Queues = append(spec.Queues, partial.Queues...)
			spec.Buckets = append(spec.Buckets, partial.Buckets...)
			spec.Topics = append(spec.Topics, partial.Topics...)
			spec.StateMachines = append(spec.StateMachines, partial.StateMachines...)
			spec.Parameters = append(spec.Parameters, partial.Parameters...)
			spec.Secrets = append(spec.Secrets, partial.Secrets...)
		}
		return nil
	})
	return spec, err
}

func parseTfFile(path string) (SessionSpec, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return SessionSpec{}, err
	}
	lines := strings.Split(string(data), "\n")
	var spec SessionSpec
	i := 0
	for i < len(lines) {
		m := reResourceHeader.FindStringSubmatch(lines[i])
		if m != nil {
			resourceType := m[1]
			i++
			switch resourceType {
			case "aws_sfn_state_machine":
				sm, next := collectStateMachine(lines, i)
				if sm != nil {
					spec.StateMachines = append(spec.StateMachines, *sm)
				}
				i = next
			case "aws_dynamodb_table":
				t, next := collectDynamoTable(lines, i)
				if t != nil {
					spec.Tables = append(spec.Tables, *t)
				}
				i = next
			case "aws_sqs_queue":
				name, next := collectSimpleAttr(lines, i, "name")
				if name != "" {
					spec.Queues = append(spec.Queues, name)
				}
				i = next
			case "aws_s3_bucket":
				name, next := collectS3Bucket(lines, i)
				if name != "" {
					spec.Buckets = append(spec.Buckets, name)
				}
				i = next
			case "aws_sns_topic":
				name, next := collectSimpleAttr(lines, i, "name")
				if name != "" {
					spec.Topics = append(spec.Topics, name)
				}
				i = next
			case "aws_ssm_parameter":
				name, next := collectSimpleAttr(lines, i, "name")
				if name != "" {
					spec.Parameters = append(spec.Parameters, name)
				}
				i = next
			case "aws_secretsmanager_secret":
				name, next := collectSimpleAttr(lines, i, "name")
				if name != "" {
					spec.Secrets = append(spec.Secrets, name)
				}
				i = next
			default:
				i = skipBlock(lines, i)
			}
		} else {
			i++
		}
	}
	return spec, nil
}

func collectStateMachine(lines []string, start int) (*StateMachineSpec, int) {
	var name, definition, roleArn string
	depth := 1
	i := start
	for i < len(lines) && depth > 0 {
		line := lines[i]
		if depth == 1 {
			if m := reAttrHeredoc.FindStringSubmatch(line); m != nil {
				key, marker := m[1], m[2]
				i++
				var body []string
				for i < len(lines) && strings.TrimRight(lines[i], "\r") != marker {
					body = append(body, lines[i])
					i++
				}
				if key == "definition" {
					definition = strings.Join(body, "\n")
				}
				i++ // skip closing marker
				continue
			}
			if m := reAttrStr.FindStringSubmatch(line); m != nil {
				switch m[1] {
				case "name":
					name = m[2]
				case "role_arn":
					roleArn = m[2]
				case "definition":
					definition = `"` + m[2] + `"`
				}
			}
		}
		depth += strings.Count(line, "{") - strings.Count(line, "}")
		i++
	}
	if name == "" || definition == "" {
		return nil, i
	}
	return &StateMachineSpec{Name: name, Definition: definition, RoleArn: roleArn}, i
}

func collectDynamoTable(lines []string, start int) (*TableSpec, int) {
	var name, hashKey, rangeKey string
	depth := 1
	i := start
	for i < len(lines) && depth > 0 {
		line := lines[i]
		if depth == 1 {
			if m := reAttrStr.FindStringSubmatch(line); m != nil {
				switch m[1] {
				case "name":
					name = m[2]
				case "hash_key":
					hashKey = m[2]
				case "range_key":
					rangeKey = m[2]
				}
			}
		}
		depth += strings.Count(line, "{") - strings.Count(line, "}")
		i++
	}
	if name == "" || hashKey == "" {
		return nil, i
	}
	return &TableSpec{Name: name, PartitionKey: hashKey, SortKey: rangeKey}, i
}

// collectSimpleAttr extracts a single named string attribute from a block.
func collectSimpleAttr(lines []string, start int, attrName string) (string, int) {
	var value string
	depth := 1
	i := start
	for i < len(lines) && depth > 0 {
		line := lines[i]
		if depth == 1 {
			if m := reAttrStr.FindStringSubmatch(line); m != nil {
				if m[1] == attrName {
					value = m[2]
				}
			}
		}
		depth += strings.Count(line, "{") - strings.Count(line, "}")
		i++
	}
	return value, i
}

// collectS3Bucket collects the bucket name, falling back from "bucket" to "name".
func collectS3Bucket(lines []string, start int) (string, int) {
	var bucket, name string
	depth := 1
	i := start
	for i < len(lines) && depth > 0 {
		line := lines[i]
		if depth == 1 {
			if m := reAttrStr.FindStringSubmatch(line); m != nil {
				switch m[1] {
				case "bucket":
					bucket = m[2]
				case "name":
					name = m[2]
				}
			}
		}
		depth += strings.Count(line, "{") - strings.Count(line, "}")
		i++
	}
	if bucket != "" {
		return bucket, i
	}
	return name, i
}

func skipBlock(lines []string, start int) int {
	depth := 1
	i := start
	for i < len(lines) && depth > 0 {
		depth += strings.Count(lines[i], "{") - strings.Count(lines[i], "}")
		i++
	}
	return i
}
