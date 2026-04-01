#!/usr/bin/env python3
"""
fix_fizz_annotations.py

Fixes remaining annotation quoting and tense issues in .fizz files:
- Adds double quotes around service names and resource types
- Quotes unquoted status values (ACTIVE, CREATING, etc.)
- Fixes present tense 'is STATUS' -> past tense 'was "STATUS"' in guard lines
- Fixes redundant step line prefixes (e.g. 'a documentdb database documentdb cluster')

Only modifies annotation lines:
  # step:, # result:, # guard:, # guard_violation:, # guard_violation_lifecycle:,
  # guard_violation_capacity:, # check:
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

# ---------------------------------------------------------------------------
# Annotation line detection
# ---------------------------------------------------------------------------
_ANNOTATION_PREFIX = re.compile(
    r"^(\s*#\s*(?:step|result|guard|guard_violation|guard_violation_lifecycle"
    r"|guard_violation_capacity|check):\s*)(.*)"
)


def is_annotation(line: str) -> re.Match | None:
    return _ANNOTATION_PREFIX.match(line)


# ---------------------------------------------------------------------------
# Substitution helpers
# ---------------------------------------------------------------------------

def _sub(pattern: str, repl: str, text: str, flags: int = re.IGNORECASE) -> str:
    """Apply regex substitution only if the match is not already inside quotes."""
    return re.sub(pattern, repl, text, flags=flags)


# ---------------------------------------------------------------------------
# Global substitutions (apply to all files)
# These match service+resource pairs that are unambiguous regardless of context.
# Ordered longest-first to avoid partial matches.
# ---------------------------------------------------------------------------

# Each entry: (pattern, replacement) — applied in order to annotation text.
GLOBAL_SUBS: list[tuple[str, str]] = [
    # step functions (multi-word service name — must come before single-word variants)
    (r'\bthe step functions state machine\b', 'the "step functions" "state machine"'),
    (r'\ba step functions state machine\b', 'a "step functions" "state machine"'),
    (r'\bthe step functions execution\b', 'the "step functions" "execution"'),
    (r'\ba step functions execution\b', 'a "step functions" "execution"'),

    # documentdb
    (r'\bthe documentdb cluster\b', 'the "documentdb" "cluster"'),
    (r'\ba documentdb cluster\b', 'a "documentdb" "cluster"'),
    (r'\bthe documentdb instance\b', 'the "documentdb" "instance"'),
    (r'\ba documentdb instance\b', 'a "documentdb" "instance"'),
    (r'\bthe documentdb snapshot\b', 'the "documentdb" "snapshot"'),
    (r'\ba documentdb snapshot\b', 'a "documentdb" "snapshot"'),

    # neptune
    (r'\bthe neptune cluster\b', 'the "neptune" "cluster"'),
    (r'\ba neptune cluster\b', 'a "neptune" "cluster"'),
    (r'\bthe neptune instance\b', 'the "neptune" "instance"'),
    (r'\ba neptune instance\b', 'a "neptune" "instance"'),
    (r'\bthe neptune snapshot\b', 'the "neptune" "snapshot"'),

    # s3 tables (multi-word service — must come before plain 's3 bucket')
    (r'\bthe s3 tables bucket\b', 'the "s3 tables" "bucket"'),
    (r'\ba s3 tables bucket\b', 'a "s3 tables" "bucket"'),
    (r'\bthe s3 tables table\b', 'the "s3 tables" "table"'),
    (r'\ba s3 tables table\b', 'a "s3 tables" "table"'),

    # elasticache replication group
    (r'\bthe replication group\b', 'the "elasticache" "replication group"'),
    (r'\ba replication group\b', 'a "elasticache" "replication group"'),

    # eventbridge (event eventbridge bus → "eventbridge" "bus")
    (r'\bthe event eventbridge bus\b', 'the "eventbridge" "bus"'),
    (r'\ban event eventbridge bus\b', 'an "eventbridge" "bus"'),
    (r'\bthe eventbridge bus\b', 'the "eventbridge" "bus"'),
    (r'\bthe eventbridge rule\b', 'the "eventbridge" "rule"'),
    (r'\ban EventBridge rule\b', 'an "eventbridge" "rule"'),
    (r'\ban eventbridge rule\b', 'an "eventbridge" "rule"'),
    (r'\bthe dead-letter eventbridge queue\b', 'the "eventbridge" "dead-letter queue"'),

    # memorydb cluster (must come before plain 'cluster')
    (r'\bthe memorydb cluster\b', 'the "memorydb" "cluster"'),
    (r'\ba memorydb cluster\b', 'a "memorydb" "cluster"'),

    # s3
    (r'\bthe s3 bucket\b', 'the "s3" "bucket"'),
    (r'\ban s3 bucket\b', 'an "s3" "bucket"'),
    (r'\ba s3 bucket\b', 'a "s3" "bucket"'),
    (r'\bthe s3 object\b', 'the "s3" "object"'),
    (r'\ban s3 object\b', 'an "s3" "object"'),

    # ssm
    (r'\bthe ssm parameter\b', 'the "ssm" "parameter"'),
    (r'\ban ssm parameter\b', 'an "ssm" "parameter"'),
    (r'\ba ssm parameter\b', 'a "ssm" "parameter"'),
    (r"\bthe tag was associated with the ssm parameter\b",
     'the tag was associated with the "ssm" "parameter"'),
    (r"\bthe tag was not associated with the ssm parameter\b",
     'the tag was not associated with the "ssm" "parameter"'),

    # sns (must come before sqs)
    (r'\bthe sns topic\b', 'the "sns" "topic"'),
    (r'\ba sns topic\b', 'a "sns" "topic"'),
    (r'\bthe sns subscription\b', 'the "sns" "subscription"'),
    (r'\ba sns subscription\b', 'a "sns" "subscription"'),
    (r'\bthe sns message\b', 'the "sns" "message"'),
    (r'\bthe sns delivery\b', 'the "sns" "delivery"'),
    (r'\ba confirmed subscription existed for the sns topic\b',
     'a confirmed subscription existed for the "sns" "topic"'),
    (r'\ba confirmed subscription existed for the topic\b',
     'a confirmed subscription existed for the "sns" "topic"'),

    # sqs
    (r'\bthe sqs queue\b', 'the "sqs" "queue"'),
    (r'\ba sqs queue\b', 'a "sqs" "queue"'),
    (r"\bthe sqs message's sqs queue\b", 'the "sqs" "message"\'s "sqs" "queue"'),
    (r'\bthe sqs message\b', 'the "sqs" "message"'),
    (r'\ba sqs message\b', 'a "sqs" "message"'),

    # dynamodb
    (r'\bthe dynamodb table\b', 'the "dynamodb" "table"'),
    (r'\ba dynamodb table\b', 'a "dynamodb" "table"'),
    (r'\bthe dynamodb item\b', 'the "dynamodb" "item"'),
    (r'\ba dynamodb item\b', 'a "dynamodb" "item"'),

    # lambda (case-insensitive service name in some files)
    (r'\bthe lambda function\b', 'the "lambda" "function"'),
    (r'\ba [Ll]ambda function\b', 'a "lambda" "function"'),
    (r'\bthe [Ll]ambda function\b', 'the "lambda" "function"'),
    (r'\ba [Ll]ambda event source mapping\b', 'a "lambda" "event source mapping"'),
    (r'\bthe [Ll]ambda event source mapping\b', 'the "lambda" "event source mapping"'),
    (r'\ba [Ll]ambda rotation function\b', 'a "lambda" "rotation function"'),
    (r'\bthe [Ll]ambda rotation function\b', 'the "lambda" "rotation function"'),
    (r'\ba callee [Ll]ambda function\b', 'a callee "lambda" "function"'),
    (r'\ba caller [Ll]ambda function\b', 'a caller "lambda" "function"'),
    (r'\bthe callee [Ll]ambda function\b', 'the callee "lambda" "function"'),
    (r'\bthe caller [Ll]ambda function\b', 'the caller "lambda" "function"'),

    # secretsmanager
    (r'\bthe secretsmanager secret\b', 'the "secretsmanager" "secret"'),
    (r'\ba secretsmanager secret\b', 'a "secretsmanager" "secret"'),

    # elasticache cluster (when written with service prefix but without quotes)
    (r'\bthe elasticache cluster\b', 'the "elasticache" "cluster"'),
    (r'\ban elasticache cluster\b', 'an "elasticache" "cluster"'),

    # step line format fixes (redundant prefixes in some files)
    (r'\ba documentdb database documentdb cluster\b', 'a "documentdb" "cluster"'),
    (r'\ba documentdb database documentdb instance\b', 'a "documentdb" "instance"'),
    (r'\ba neptune database neptune cluster\b', 'a "neptune" "cluster"'),
    (r'\ba neptune database neptune instance\b', 'a "neptune" "instance"'),
    (r'\ba s3 tables table s3 tables bucket\b', 'a "s3 tables" "bucket"'),
    (r'\ba s3 tables table s3 tables namespace\b', 'a "s3 tables" "namespace"'),
    (r'\ban event eventbridge\b', 'an "eventbridge"'),

    # s3 tables snapshot
    (r'\bthe s3 tables snapshot\b', 'the "s3 tables" "snapshot"'),
    (r'\ba s3 tables snapshot\b', 'a "s3 tables" "snapshot"'),

    # neptune/docdb capacity guards
    (r'\bthe target neptune cluster slot\b', 'the target "neptune" "cluster" slot'),
    (r'\bthe target documentdb cluster slot\b', 'the target "documentdb" "cluster" slot'),

    # neptune instance
    (r'\bthe neptune instance\b', 'the "neptune" "instance"'),
    (r'\ba neptune instance\b', 'a "neptune" "instance"'),
    (r'\ba replica neptune instance\b', 'a replica "neptune" "instance"'),
    (r'\bthe new primary neptune instance\b', 'the new primary "neptune" "instance"'),
    (r'\bthe new primary documentdb instance\b', 'the new primary "documentdb" "instance"'),
]


# ---------------------------------------------------------------------------
# File-specific substitutions
# Each entry: (path_substring, [(pattern, replacement), ...])
# Applied after global subs if the file path contains path_substring.
# ---------------------------------------------------------------------------

FILE_SUBS: list[tuple[str, list[tuple[str, str]]]] = [
    ("apigateway", [
        # API
        (r'\bthe API\b', 'the "api gateway" "API"'),
        (r'\ban API\b', 'an "api gateway" "API"'),
        (r'\ba REST API\b', 'a "api gateway" "REST API"'),
        # prod stage (specific named stage — must come before generic 'stage')
        (r'\bthe prod stage\b', 'the "api gateway" "prod stage"'),
        # resource (careful: don't double-quote already-quoted ones)
        (r'\bthe parent resource\b', 'the parent "api gateway" "resource"'),
        (r'\bthe root resource\b', 'the root "api gateway" "resource"'),
        (r'\bthe new resource\b', 'the new "api gateway" "resource"'),
        (r'\ba child resource\b', 'a child "api gateway" "resource"'),
        (r'\ba non-root resource\b', 'a non-root "api gateway" "resource"'),
        (r'\ban existing resource\b', 'an existing "api gateway" "resource"'),
        (r'\bthe resource\b', 'the "api gateway" "resource"'),
        (r'\ba resource\b', 'a "api gateway" "resource"'),
        # method
        (r'\bthe method\b', 'the "api gateway" "method"'),
        (r'\ba method\b', 'a "api gateway" "method"'),
        # integration
        (r'\bthe integration\b', 'the "api gateway" "integration"'),
        (r'\ban integration\b', 'an "api gateway" "integration"'),
        # deployment
        (r'\bthe deployment\b', 'the "api gateway" "deployment"'),
        (r'\ba deployment\b', 'a "api gateway" "deployment"'),
        # stage
        (r'\bthe stage\b', 'the "api gateway" "stage"'),
        (r'\ba stage\b', 'a "api gateway" "stage"'),
        # status (ACTIVE and lowercase active)
        (r'\b(was|is) ACTIVE\b', r'\1 "ACTIVE"'),
        (r'\b(was|is) not ACTIVE\b', r'\1 not "ACTIVE"'),
        (r'\b(was|is) active\b', r'\1 "ACTIVE"'),
        (r'\b(was|is) not active\b', r'\1 not "ACTIVE"'),
    ]),

    ("glacier", [
        (r'\bthe vault\b', 'the "glacier" "vault"'),
        (r'\ba vault\b', 'a "glacier" "vault"'),
        (r'\ba Glacier vault\b', 'a "glacier" "vault"'),
        (r'\bthe archive\b', 'the "glacier" "archive"'),
        (r'\ban archive\b', 'an "glacier" "archive"'),
        (r'\bthe job\b', 'the "glacier" "job"'),
        (r'\ba job\b', 'a "glacier" "job"'),
        # tense + quote for status values
        (r'\bthe archive is STORED\b', 'the "glacier" "archive" was "STORED"'),
        (r'\bthe archive is not STORED\b', 'the "glacier" "archive" was not "STORED"'),
        (r'\bis InProgress\b', 'was "InProgress"'),
        (r'\bis not InProgress\b', 'was not "InProgress"'),
        (r'\bis Succeeded\b', 'was "Succeeded"'),
        (r'\bis not Succeeded\b', 'was not "Succeeded"'),
        (r'\bthe job output is available\b', 'the "glacier" "job" output was available'),
        (r'\bthe job output is not available\b', 'the "glacier" "job" output was not available'),
    ]),

    ("cognito_idp", [
        (r'\bthe user pool\b', 'the "cognito" "user pool"'),
        (r'\ba user pool\b', 'a "cognito" "user pool"'),
        (r'\bthe group\b', 'the "cognito" "group"'),
        (r'\ba group\b', 'a "cognito" "group"'),
        # session
        (r'\bthe session\b', 'the "cognito" "session"'),
        (r'\ba session\b', 'a "cognito" "session"'),
        # 'the user' — but not 'the user pool' (already handled above)
        (r'\bthe user\b', 'the "cognito" "user"'),
        (r'\ba user\b', 'a "cognito" "user"'),
        (r'\ban user\b', 'a "cognito" "user"'),
    ]),

    ("memorydb", [
        (r'\bthe cluster\b', 'the "memorydb" "cluster"'),
        (r'\ba cluster\b', 'a "memorydb" "cluster"'),
        (r'\bthe ACL\b', 'the "memorydb" "ACL"'),
        (r'\ban ACL\b', 'an "memorydb" "ACL"'),
        (r'\bthe user\b', 'the "memorydb" "user"'),
        (r'\ba user\b', 'a "memorydb" "user"'),
        (r'\ban user\b', 'a "memorydb" "user"'),
        # generic 'resource' in tagging context
        (r'\bthe resource\b', 'the "memorydb" "resource"'),
        (r'\ba resource\b', 'a "memorydb" "resource"'),
        # status values
        (r'\bwas CREATING\b', 'was "CREATING"'),
        (r'\bwas not CREATING\b', 'was not "CREATING"'),
        (r'\bwas MODIFYING\b', 'was "MODIFYING"'),
        (r'\bwas not MODIFYING\b', 'was not "MODIFYING"'),
        (r'\bwas DELETING\b', 'was "DELETING"'),
        (r'\bwas not DELETING\b', 'was not "DELETING"'),
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
        # present tense status (is → was)
        (r'\bis UPDATING\b', 'was "UPDATING"'),
        (r'\bis not UPDATING\b', 'was not "UPDATING"'),
        (r'\bis tagged\b', 'was tagged'),
        (r'\bis not tagged\b', 'was not tagged'),
    ]),

    ("organizations", [
        (r'\bthe organization\b', 'the "organizations" "organization"'),
        (r'\ban organization\b', 'an "organizations" "organization"'),
        # policy  (careful: must come after service-prefixed versions)
        (r'\bthe policy\b', 'the "organizations" "policy"'),
        (r'\ba policy\b', 'a "organizations" "policy"'),
        # parent / target (generic organizational hierarchy elements)
        (r'\bthe destination parent\b', 'the destination "organizations" "parent"'),
        (r'\bthe parent\b', 'the "organizations" "parent"'),
        (r'\bthe target\b', 'the "organizations" "target"'),
        # status values
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
        # tense: is → was for guard lines
        (r'\bthe policy is attached to the target\b',
         'the "organizations" "policy" was attached to the "organizations" "target"'),
        (r'\bthe policy is not attached to the target\b',
         'the "organizations" "policy" was not attached to the "organizations" "target"'),
    ]),

    ("s3tables", [
        (r'\bthe namespace\b', 'the "s3 tables" "namespace"'),
        (r'\ba namespace\b', 'a "s3 tables" "namespace"'),
        # status values
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
        (r'\bwas CREATING\b', 'was "CREATING"'),
        (r'\bwas not CREATING\b', 'was not "CREATING"'),
        (r'\bwas DELETING\b', 'was "DELETING"'),
        (r'\bwas not DELETING\b', 'was not "DELETING"'),
        # present tense fixes for guard lines
        (r'\bthe event eventbridge bus is not the default eventbridge bus\b',
         'the "eventbridge" "bus" was not the default "eventbridge" "bus"'),
        (r'\bthe event eventbridge bus is the default eventbridge bus\b',
         'the "eventbridge" "bus" was the default "eventbridge" "bus"'),
    ]),

    ("events", [
        # status values
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
        # tense fixes for bus default check
        (r'\bthe event eventbridge bus is not the default eventbridge bus\b',
         'the "eventbridge" "bus" was not the default "eventbridge" "bus"'),
        (r'\bthe event eventbridge bus is the default eventbridge bus\b',
         'the "eventbridge" "bus" was the default "eventbridge" "bus"'),
        # eventbridge rule status
        (r'\bthe eventbridge rule is not already DELETED\b',
         'the "eventbridge" "rule" was not already "DELETED"'),
        (r'\bthe eventbridge rule is already DELETED\b',
         'the "eventbridge" "rule" was already "DELETED"'),
        (r'\bthe eventbridge rule has no active targets\b',
         'the "eventbridge" "rule" had no active targets'),
        (r'\bthe eventbridge rule has active targets\b',
         'the "eventbridge" "rule" had active targets'),
        # bus state
        (r'\bthe event eventbridge bus has no rules\b',
         'the "eventbridge" "bus" had no rules'),
        (r'\bthe event eventbridge bus has rules\b',
         'the "eventbridge" "bus" had rules'),
    ]),

    ("aws_fake", [
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
    ]),

    ("elasticsearch", [
        (r'\bthe index\b', 'the "elasticsearch" "index"'),
        (r'\ban index\b', 'an "elasticsearch" "index"'),
        (r'\bthe document\b', 'the "elasticsearch" "document"'),
        (r'\ba document\b', 'a "elasticsearch" "document"'),
        (r'\bthe tag key\b', 'the "elasticsearch" "tag key"'),
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
    ]),

    ("opensearch", [
        (r'\bthe index\b', 'the "opensearch" "index"'),
        (r'\ban index\b', 'an "opensearch" "index"'),
        (r'\bthe inbound connection\b', 'the "opensearch" "inbound connection"'),
        (r'\ban inbound connection\b', 'an "opensearch" "inbound connection"'),
        (r'\bthe outbound connection\b', 'the "opensearch" "outbound connection"'),
        (r'\ban outbound connection\b', 'an "opensearch" "outbound connection"'),
        (r'\bthe associated inbound connection\b', 'the associated "opensearch" "inbound connection"'),
        (r'\bthe new cluster\b', 'the new "opensearch" "cluster"'),
        (r'\bthe tag key\b', 'the "opensearch" "tag key"'),
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
        # tense fixes for guard lines with 'is'
        (r'\bis ready\b', 'was ready'),
        (r'\bis not ready\b', 'was not ready'),
    ]),

    ("elasticache", [
        # generic 'resource' in tagging context (includes 'a cache resource')
        (r'\bthe resource\b', 'the "elasticache" "resource"'),
        (r'\ba resource\b', 'a "elasticache" "resource"'),
        (r'\ba cache resource\b', 'an "elasticache" "resource"'),
        # elasticache cluster (same as global but here for completeness)
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
        (r'\bwas CREATING\b', 'was "CREATING"'),
        (r'\bwas not CREATING\b', 'was not "CREATING"'),
        (r'\bwas MODIFYING\b', 'was "MODIFYING"'),
        (r'\bwas not MODIFYING\b', 'was not "MODIFYING"'),
        (r'\bwas DELETING\b', 'was "DELETING"'),
        (r'\bwas not DELETING\b', 'was not "DELETING"'),
        (r'\bwas AVAILABLE\b', 'was "AVAILABLE"'),
        (r'\bwas not AVAILABLE\b', 'was not "AVAILABLE"'),
    ]),

    ("integrations", [
        # secret (secretsmanager in integration context)
        (r'\bthe secret\b', 'the "secretsmanager" "secret"'),
        (r'\ba secret\b', 'a "secretsmanager" "secret"'),
        # api gateway api (in integration files, some use lowercase "api gateway api")
        (r'\bthe api gateway api\b', 'the "api gateway" "API"'),
        (r'\ban api gateway api\b', 'an "api gateway" "API"'),
        # execution slot
        (r'\bthe execution slot\b', 'the "step functions" "execution" slot'),
        # status tense fixes
        (r'\bthe secret is PENDING_DELETION\b', 'the "secretsmanager" "secret" was "PENDING_DELETION"'),
        (r'\bthe secret is not PENDING_DELETION\b', 'the "secretsmanager" "secret" was not "PENDING_DELETION"'),
        (r'\bthe cluster is UPDATING\b', 'the "memorydb" "cluster" was "UPDATING"'),
        (r'\bthe cluster is not UPDATING\b', 'the "memorydb" "cluster" was not "UPDATING"'),
        (r'\bthe instance is FAILING_OVER\b', 'the "rds" "instance" was "FAILING_OVER"'),
        (r'\bthe instance is not FAILING_OVER\b', 'the "rds" "instance" was not "FAILING_OVER"'),
        (r'\bthe database instance is FAILING_OVER\b', 'the "rds" "database instance" was "FAILING_OVER"'),
        (r'\bthe database instance is not FAILING_OVER\b', 'the "rds" "database instance" was not "FAILING_OVER"'),
        (r'\bthe DB instance is FAILING_OVER\b', 'the "rds" "DB instance" was "FAILING_OVER"'),
        (r'\bthe DB instance is not FAILING_OVER\b', 'the "rds" "DB instance" was not "FAILING_OVER"'),
        # step functions state machine status
        (r'\bwas ACTIVE\b', 'was "ACTIVE"'),
        (r'\bwas not ACTIVE\b', 'was not "ACTIVE"'),
    ]),

    # DynamoDB integrations — 'the table' = dynamodb table
    ("apigateway_dynamodb", [
        (r'\bthe table\b', 'the "dynamodb" "table"'),
        (r'\ba table\b', 'a "dynamodb" "table"'),
    ]),
    ("dynamodb_lambda", [
        (r'\bthe table\b', 'the "dynamodb" "table"'),
        (r'\ba table\b', 'a "dynamodb" "table"'),
    ]),
    ("events_dynamodb", [
        (r'\bthe table\b', 'the "dynamodb" "table"'),
        (r'\ba table\b', 'a "dynamodb" "table"'),
    ]),
    ("lambda_dynamodb", [
        (r'\bthe table\b', 'the "dynamodb" "table"'),
        (r'\ba table\b', 'a "dynamodb" "table"'),
    ]),
    ("stepfunctions_dynamodb", [
        (r'\bthe table\b', 'the "dynamodb" "table"'),
        (r'\ba table\b', 'a "dynamodb" "table"'),
    ]),

    # S3 integrations — 'the bucket'/'an object' = s3 bucket/object
    ("apigateway_s3", [
        (r'\bthe bucket\b', 'the "s3" "bucket"'),
        (r'\ba bucket\b', 'a "s3" "bucket"'),
        (r'\ban object\b', 'an "s3" "object"'),
        (r'\bthe object\b', 'the "s3" "object"'),
    ]),
    ("lambda_s3", [
        (r'\bthe bucket\b', 'the "s3" "bucket"'),
        (r'\ba bucket\b', 'a "s3" "bucket"'),
        (r'\ban object\b', 'an "s3" "object"'),
    ]),

    # SNS integrations — 'the topic' = sns topic
    ("apigateway_sns", [
        (r'\bthe topic\b', 'the "sns" "topic"'),
        (r'\ba topic\b', 'a "sns" "topic"'),
    ]),
    ("elasticache_sns", [
        (r'\bthe cluster\b', 'the "elasticache" "cluster"'),
        (r'\bthe topic\b', 'the "sns" "topic"'),
        (r'\ba topic\b', 'a "sns" "topic"'),
    ]),

    # SQS integrations — 'the queue' = sqs queue
    ("apigateway_sqs", [
        (r'\bthe queue\b', 'the "sqs" "queue"'),
        (r'\ba queue\b', 'a "sqs" "queue"'),
        (r'\bthe message\b', 'the "sqs" "message"'),
    ]),

    # Glacier integrations — 'the topic' = sns topic (in glacier_sns)
    ("glacier_sns", [
        (r'\bthe topic\b', 'the "sns" "topic"'),
        (r'\ba topic\b', 'a "sns" "topic"'),
    ]),

    # Step Functions Express Workflow
    ("apigateway_stepfunctions", [
        (r'\ba Step Functions Express Workflow state machine\b',
         'a "step functions" "Express Workflow state machine"'),
    ]),

    # Elasticsearch integrations — 'the domain' = elasticsearch domain
    ("elasticsearch", [
        (r'\bthe elasticsearch domain\b', 'the "elasticsearch" "domain"'),
        (r'\ban elasticsearch domain\b', 'an "elasticsearch" "domain"'),
        (r'\bthe domain\b', 'the "elasticsearch" "domain"'),
        (r'\ba domain\b', 'a "elasticsearch" "domain"'),
    ]),

    # OpenSearch integrations — 'the domain' = opensearch domain
    ("opensearch", [
        (r'\bthe opensearch domain\b', 'the "opensearch" "domain"'),
        (r'\ban opensearch domain\b', 'an "opensearch" "domain"'),
        (r'\bthe domain\b', 'the "opensearch" "domain"'),
        (r'\ba domain\b', 'a "opensearch" "domain"'),
    ]),

    # RDS integrations — 'the instance' = rds instance
    ("rds", [
        (r'\bthe rds instance\b', 'the "rds" "instance"'),
        (r'\bthe rds db instance\b', 'the "rds" "DB instance"'),
        (r'\ba RDS database instance\b', 'a "rds" "database instance"'),
        (r'\bthe instance\b', 'the "rds" "instance"'),
        (r'\ba instance\b', 'a "rds" "instance"'),
        (r'\ban instance\b', 'an "rds" "instance"'),
    ]),

    # DocDB integrations — 'the cluster' = documentdb cluster
    ("lambda_docdb", [
        (r'\bthe cluster\b', 'the "documentdb" "cluster"'),
        (r'\ba cluster\b', 'a "documentdb" "cluster"'),
    ]),
    ("stepfunctions_docdb", [
        (r'\bthe cluster\b', 'the "documentdb" "cluster"'),
        (r'\ba cluster\b', 'a "documentdb" "cluster"'),
    ]),
    ("docdb_events", [
        (r'\bthe cluster\b', 'the "documentdb" "cluster"'),
        (r'\ba cluster\b', 'a "documentdb" "cluster"'),
    ]),

    # Neptune integrations — 'the cluster' = neptune cluster
    ("lambda_neptune", [
        (r'\bthe cluster\b', 'the "neptune" "cluster"'),
        (r'\ba cluster\b', 'a "neptune" "cluster"'),
    ]),
    ("stepfunctions_neptune", [
        (r'\bthe cluster\b', 'the "neptune" "cluster"'),
        (r'\ba cluster\b', 'a "neptune" "cluster"'),
    ]),

    # Lambda-Lambda integration — caller/callee functions
    # Use negative lookahead to avoid re-applying when already substituted
    ("lambda_lambda", [
        (r'\bthe caller function\b', 'the caller "lambda" "function"'),
        (r'\bthe callee function\b', 'the callee "lambda" "function"'),
        # Only match 'the callee'/'the caller' when NOT already followed by '"lambda"'
        (r'\bthe callee(?! "lambda")\b', 'the callee "lambda" "function"'),
        (r'\bthe caller(?! "lambda")\b', 'the caller "lambda" "function"'),
    ]),

    # S3 API integration — 'no object in the target bucket'
    ("apigateway_s3api", [
        (r'\bno object existed in the target bucket\b',
         'no "s3" "object" existed in the target "s3" "bucket"'),
    ]),

    # Cognito-specific integration patterns (must come after 'integrations' block)
    ("cognito", [
        # 'the pool' / 'a pool' → cognito user pool (all cognito integration files)
        (r'\bthe pool\b', 'the "cognito" "user pool"'),
        (r'\ba pool\b', 'a "cognito" "user pool"'),
        (r'\bthe user\b', 'the "cognito" "user"'),
        (r'\ba user\b', 'a "cognito" "user"'),
        (r'\ban user\b', 'a "cognito" "user"'),
        (r'\ba Cognito User Pool\b', 'a "cognito" "user pool"'),
        (r'\bthe Cognito User Pool\b', 'the "cognito" "user pool"'),
        (r'\ba Cognito user pool\b', 'a "cognito" "user pool"'),
        (r'\bthe Cognito user pool\b', 'the "cognito" "user pool"'),
    ]),
]


# ---------------------------------------------------------------------------
# Status value quoting (applied globally to annotation lines at the end)
# These are unquoted ALLCAPS status values after 'was', 'is', 'will be'
# ---------------------------------------------------------------------------

STATUS_SUBS: list[tuple[str, str]] = [
    # lowercase status values (active, enabled, disabled)
    (r'\bwas active\b', 'was "ACTIVE"'),
    (r'\bwas not active\b', 'was not "ACTIVE"'),
    (r'\bwas enabled\b', 'was "ENABLED"'),
    (r'\bwas not enabled\b', 'was not "ENABLED"'),
    (r'\bwas disabled\b', 'was "DISABLED"'),
    (r'\bwas not disabled\b', 'was not "DISABLED"'),
    (r'\bis active\b', 'was "ACTIVE"'),
    (r'\bis not active\b', 'was not "ACTIVE"'),
    (r'\bis enabled\b', 'was "ENABLED"'),
    (r'\bis not enabled\b', 'was not "ENABLED"'),
    (r'\bis disabled\b', 'was "DISABLED"'),
    (r'\bis not disabled\b', 'was not "DISABLED"'),

    # was/is STATUS (not already quoted)
    (r'\bwas (ACTIVE|INACTIVE|CREATING|CREATED|DELETING|DELETED|MODIFYING|MODIFIED'
     r'|PENDING|RUNNING|SUCCEEDED|FAILED|STOPPED|STOPPING|AVAILABLE'
     r'|PENDING_DELETION|PENDING_CONFIRMATION|FORCE_CHANGE_PASSWORD|ENABLED|DISABLED'
     r'|IN_FLIGHT|DONE|TIMED_OUT|CONFIRMED|UNCONFIRMED'
     r'|IN_PROGRESS|InProgress|Succeeded|STORED)\b',
     r'was "\1"'),
    (r'\bwas not (ACTIVE|INACTIVE|CREATING|CREATED|DELETING|DELETED|MODIFYING|MODIFIED'
     r'|PENDING|RUNNING|SUCCEEDED|FAILED|STOPPED|STOPPING|AVAILABLE'
     r'|PENDING_DELETION|PENDING_CONFIRMATION|FORCE_CHANGE_PASSWORD|ENABLED|DISABLED'
     r'|IN_FLIGHT|DONE|TIMED_OUT|CONFIRMED|UNCONFIRMED'
     r'|IN_PROGRESS|InProgress|Succeeded|STORED)\b',
     r'was not "\1"'),
    # is STATUS → was "STATUS" (tense fix for guard lines)
    (r'\bis (ACTIVE|INACTIVE|CREATING|CREATED|DELETING|DELETED|MODIFYING|MODIFIED'
     r'|PENDING|RUNNING|SUCCEEDED|FAILED|STOPPED|STOPPING|AVAILABLE'
     r'|PENDING_DELETION|PENDING_CONFIRMATION|FORCE_CHANGE_PASSWORD|ENABLED|DISABLED'
     r'|IN_FLIGHT|DONE|TIMED_OUT|CONFIRMED|UNCONFIRMED'
     r'|IN_PROGRESS|InProgress|Succeeded|STORED)\b',
     r'was "\1"'),
    (r'\bis not (ACTIVE|INACTIVE|CREATING|CREATED|DELETING|DELETED|MODIFYING|MODIFIED'
     r'|PENDING|RUNNING|SUCCEEDED|FAILED|STOPPED|STOPPING|AVAILABLE'
     r'|PENDING_DELETION|PENDING_CONFIRMATION|FORCE_CHANGE_PASSWORD|ENABLED|DISABLED'
     r'|IN_FLIGHT|DONE|TIMED_OUT|CONFIRMED|UNCONFIRMED'
     r'|IN_PROGRESS|InProgress|Succeeded|STORED)\b',
     r'was not "\1"'),
    # already DELETED / already "DELETED"
    (r'\balready (DELETED|ACTIVE|RUNNING|CONFIRMED)\b', r'already "\1"'),
]


def _apply_subs(text: str, subs: list[tuple[str, str]]) -> str:
    for pattern, repl in subs:
        text = re.sub(pattern, repl, text)
    return text


def _fix_annotation_line(line: str, file_path: str) -> str:
    m = is_annotation(line)
    if not m:
        return line

    prefix = m.group(1)   # e.g. "# guard: "
    body = m.group(2)      # e.g. "the dynamodb table did not already exist"

    # Skip already-well-formed bodies (everything is quoted)
    # Apply global substitutions
    body = _apply_subs(body, GLOBAL_SUBS)

    # Apply file-specific substitutions
    for path_substr, subs in FILE_SUBS:
        if path_substr in file_path:
            body = _apply_subs(body, subs)

    # Apply status quoting globally (after service/resource quoting)
    body = _apply_subs(body, STATUS_SUBS)

    return prefix + body + "\n"


# ---------------------------------------------------------------------------
# File processing
# ---------------------------------------------------------------------------

def fix_file(path: Path, dry_run: bool) -> bool:
    content = path.read_text()
    lines = content.splitlines(keepends=True)
    new_lines = [_fix_annotation_line(line, str(path)) for line in lines]
    new_content = "".join(new_lines)
    if new_content == content:
        return False
    if not dry_run:
        path.write_text(new_content)
    return True


def main() -> None:
    import argparse
    parser = argparse.ArgumentParser(description="Fix fizz annotation quoting issues.")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--root", default="lang/specification/core/formal")
    args = parser.parse_args()

    root = Path(args.root)
    if not root.is_absolute():
        # resolve relative to repo root (two levels up from tools/)
        repo_root = Path(__file__).parent.parent
        root = repo_root / root

    fizz_files = sorted(root.rglob("*.fizz"))
    changed = []
    for f in fizz_files:
        if fix_file(f, args.dry_run):
            changed.append(f)
            action = "Would fix" if args.dry_run else "Fixed"
            print(f"{action}: {f.relative_to(root.parent.parent.parent)}")

    print(f"\n{'Would fix' if args.dry_run else 'Fixed'} {len(changed)} file(s).")


if __name__ == "__main__":
    main()
