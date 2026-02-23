"""Architecture test: provider feature unit tests must have E2E coverage.

When a new cross-cutting feature is added to a provider (e.g. binary
payloads, CORS, multi-value headers) and tested via unit tests, there must
be at least one E2E feature file in the corresponding service directory
that covers the feature.

The test identifies "feature" unit tests by filename pattern and checks
that the feature keyword appears in an E2E feature file (as a filename
substring or a ``@tag``).  Unit tests that exercise individual CLI
command behaviour are excluded — they are already enforced by
``test_cli_command_test_coverage.py``.
"""

from __future__ import annotations

import re
from pathlib import Path

_TESTS_ROOT = Path(__file__).parent.parent.parent.parent
UNIT_PROVIDERS_DIR = _TESTS_ROOT / "unit" / "providers"
E2E_DIR = _TESTS_ROOT / "e2e"

# Regex: test_{service}_{layer}_{feature}.py
# layer = provider | routes | routes_v1 | routes_v2
_FILENAME_RE = re.compile(r"^test_([a-z]+)_(?:provider|routes(?:_v[12])?)_(.+)\.py$")

# Unit test keywords that test specific internal functions or operations
# rather than cross-cutting provider features.  These are exercised by
# the per-CLI-command E2E feature files already enforced by
# test_cli_command_test_coverage.py.
_INTERNAL_TESTS = frozenset(
    {
        # apigateway — internal function tests
        "build_http_response",
        "error_response",
        "get_request_proxy_event",
        "lambda_context_passed",
        "lambda_response_transform",
        "path_parameter_extraction",
        "post_request_with_body",
        "provider_lifecycle",
        "query_string_parameter_extraction",
        "management",
        "proxy",
        # cognito — internal flow tests
        "change_password",
        "create_user_pool",
        "delete_user_pool",
        "describe_user_pool",
        "forgot_password",
        "global_sign_out",
        "lambda_triggers",
        "list_user_pools",
        "password_policy",
        "provider_auth",
        "provider_confirmation",
        "provider_sign_up",
        "stub_operations",
        "user_store_authentication",
        "user_store_confirmation",
        "user_store_refresh_tokens",
        "user_store_required_attributes",
        "user_store_sign_up",
        "user_store_sign_up_no_auto_confirm",
        # dynamodb — internal function tests
        "batch_operations",
        "create_table",
        "delete_item",
        "delete_table",
        "describe_table",
        "ensure_dynamo_json",
        "ensure_dynamo_json_value",
        "gsi",
        "list_tables",
        "persistence",
        "put_and_get_item",
        "query",
        "scan",
        "stub_operations",
        "transact_condition_check",
        "update_item",
        "update_item_dynamo_json",
        # ecs — internal function tests
        "container_definition",
        "ecs_provider_health_check",
        "ecs_provider_lifecycle",
        "ecs_provider_restart",
        "extract_health_path",
        "extract_port",
        "merge_container_env",
        "parse_ecs_resources",
        "parse_env_list",
        "parse_task_definition",
        "resolve_command",
        "service_definition",
        # eventbridge — internal function tests
        "create_event_bus",
        "create_event_bus_route",
        "cron_expression",
        "delete_event_bus",
        "delete_event_bus_route",
        "delete_rule",
        "delete_rule_route",
        "describe_event_bus",
        "describe_event_bus_route",
        "event_bridge_provider_lifecycle",
        "event_bridge_routes",
        "event_envelope",
        "get_next_fire_time",
        "internal_publish",
        "put_events",
        "put_rule_and_targets",
        "rate_expression",
        "stub_operations",
        # lambda — internal function tests
        "event_source_mappings",
        "management",
        # s3 — internal function tests
        "create_bucket",
        "delete_bucket",
        "e_tag_computation",
        "head_bucket",
        "list_buckets",
        "local_bucket_storage_delete",
        "local_bucket_storage_head",
        "local_bucket_storage_list",
        "local_bucket_storage_put_get",
        "metadata_storage",
        "multipart",
        "notification_dispatcher",
        "presigned_urls",
        "s3_provider_crud",
        "s3_provider_lifecycle",
        # sns — internal function tests
        "create_topic",
        "delete_topic",
        "fan_out",
        "filter_policy_anything_but",
        "filter_policy_exact_string_match",
        "filter_policy_exists_check",
        "filter_policy_multiple_conditions",
        "filter_policy_no_filter",
        "filter_policy_numeric_comparison",
        "find_subscription",
        "get_subscription_attributes",
        "get_topic_attributes",
        "lambda_subscription_dispatch",
        "list_subscriptions_by_topic",
        "local_topic_publish_and_subscribe",
        "set_subscription_attribute",
        "sns_event_format",
        "sns_provider_lifecycle",
        "sns_provider_publish_subscribe",
        "sns_routes",
        "sqs_subscription_dispatch",
        "stub_operations",
        "unsubscribe",
        # sqs — internal function tests
        "create_queue",
        "dead_letter_queue",
        "delete_queue",
        "delete_queue_json",
        "delete_queue_xml",
        "fifo_queue",
        "get_queue_attributes",
        "list_queues",
        "list_queues_json",
        "list_queues_xml",
        "local_queue_basic",
        "long_polling",
        "purge_queue",
        "purge_queue_json",
        "purge_queue_xml",
        "sqs_event_source_poller",
        "sqs_provider_dlq",
        "sqs_provider_lifecycle",
        "sqs_provider_operations",
        "sqs_routes",
        "stub_operations",
        "visibility_timeout",
        # stepfunctions — internal function tests
        "asl_parser",
        "cloud_assembly_parsing",
        "create_state_machine",
        "create_state_machine_route",
        "delete_state_machine",
        "delete_state_machine_route",
        "describe_state_machine",
        "describe_state_machine_route",
        "execution_tracking",
        "express_execution",
        "get_execution_history",
        "routes",
        "standard_execution",
        "stop_execution",
        "stub_operations",
        "update_state_machine",
    }
)


def _collect_feature_keywords() -> dict[str, set[str]]:
    """Return {service: {feature_keyword, ...}} from unit test filenames.

    Only includes keywords that are NOT in the internal-tests skip list.
    """
    features: dict[str, set[str]] = {}
    for path in sorted(UNIT_PROVIDERS_DIR.glob("test_*.py")):
        m = _FILENAME_RE.match(path.name)
        if not m:
            continue
        service, feature = m.group(1), m.group(2)
        if feature in _INTERNAL_TESTS:
            continue
        features.setdefault(service, set()).add(feature)
    return features


def _collect_e2e_identifiers(service: str) -> set[str]:
    """Collect all feature file stems and @tags for a service."""
    identifiers: set[str] = set()
    features_dir = E2E_DIR / service / "features"
    if not features_dir.exists():
        return identifiers
    for feature_file in features_dir.glob("*.feature"):
        identifiers.add(feature_file.stem)
        for line in feature_file.read_text().splitlines():
            stripped = line.strip()
            if stripped.startswith("@"):
                for tag in stripped.split():
                    if tag.startswith("@"):
                        identifiers.add(tag[1:])
    return identifiers


def _feature_has_e2e_match(feature: str, identifiers: set[str]) -> bool:
    """Check if a feature keyword matches any E2E identifier."""
    singular = feature.rstrip("s")
    for ident in identifiers:
        if feature in ident or singular in ident:
            return True
    return False


class TestProviderFeatureE2eCoverage:
    """Every cross-cutting provider feature must have E2E test coverage."""

    def test_features_have_e2e_coverage(self):
        # Arrange
        missing = []
        features_by_service = _collect_feature_keywords()

        # Act
        for service, features in sorted(features_by_service.items()):
            identifiers = _collect_e2e_identifiers(service)
            for feature in sorted(features):
                if not _feature_has_e2e_match(feature, identifiers):
                    missing.append(f"{service}/{feature}")

        # Assert
        assert missing == [], (
            f"Provider features missing E2E coverage ({len(missing)}):\n"
            + "\n".join(f"  - {m}" for m in sorted(missing))
            + "\n\nFor each missing feature, either:\n"
            "  1. Add a .feature file with a matching @tag or filename\n"
            "  2. Add the keyword to _INTERNAL_TESTS if it tests an "
            "internal function (not a cross-cutting feature)"
        )
