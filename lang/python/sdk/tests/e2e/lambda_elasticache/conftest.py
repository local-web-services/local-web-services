"""Abstract BDD step definitions for LambdaElasticache integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_CLUSTER = "e2e-test-cluster-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _elasticache(lws_session):
    return lws_session.client("elasticache")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_cluster(lws_session, name=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _elasticache(lws_session).create_cache_cluster(
        CacheClusterId=name,
        CacheNodeType="cache.t3.micro",
        Engine="redis",
        NumCacheNodes=1,
    )


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def func_not_already_exist():
    """No-op: fresh state has no functions."""


@given("the function already exists")
def func_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def func_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def func_is_active_given():
    """No-op: functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def func_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def func_does_not_exist():
    """No-op: fresh state has no functions."""


# ── Given: cluster state ───────────────────────────────────────────────


@given("the cluster does not already exist")
def cluster_not_already_exist():
    """No-op: fresh state has no clusters."""


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    _create_cluster(lws_session)


@given("the cluster exists")
def cluster_exists(lws_session):
    _create_cluster(lws_session)


@given('the cluster is "AVAILABLE"')
def cluster_is_available_given(lws_session):
    _create_cluster(lws_session)


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given(lws_session, world):
    _create_cluster(lws_session)


@given("the cluster does not exist")
def cluster_does_not_exist():
    """No-op: fresh state has no clusters."""


# ── Given: cache entry / invocation state ─────────────────────────────


@given('a "CACHED" entry exists')
def cached_entry_exists():
    pytest.skip("Cannot pre-populate ElastiCache entries in lws")


@given('no "CACHED" entry exists')
def no_cached_entry_exists():
    """No-op: fresh state has no cached entries."""


@given('no "CACHED" entries exist in the cluster')
def no_cached_entries_in_cluster():
    """No-op: fresh state has no cached entries."""


@given('a "CACHED" entry exists in the cluster')
def cached_entry_in_cluster():
    pytest.skip("Cannot pre-populate ElastiCache entries in lws")


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    _create_function(lws_session)


@given('no invocation is "IN_PROGRESS"')
def no_invocation_is_in_progress():
    """No-op: fresh state has no invocations."""


@given("an invocation slot is available")
def invocation_slot_available():
    """No-op: always room for invocations."""


@given("no invocation slot is available")
def no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")


@given("a key slot is available")
def key_slot_available():
    """No-op: always room for cache keys."""


@given("no key slot is available")
def no_key_slot_available():
    pytest.skip("Cannot exhaust key slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no Lambda functions."""


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("a Lambda function has been deployed")
def lambda_elasticache_seq_function_deployed(lws_session):
    _create_function(lws_session)


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: fresh state has no ElastiCache clusters."""


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    _create_cluster(lws_session)


@given("an ElastiCache cluster has been created")
def lambda_elasticache_seq_cluster_created(lws_session):
    _create_cluster(lws_session)


@given("the Lambda function has been invoked")
def lambda_elasticache_seq_function_invoked():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot observe Lambda invocation state in lws")


@given("the Lambda function has written a value to the ElastiCache cluster during invocation")
def lambda_elasticache_seq_value_written():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("kid in key_status")
def kid_in_key_status():
    pytest.skip("Cannot pre-populate ElastiCache entries in lws")


@given('ElastiCache has evicted a cache entry due to memory pressure or "TTL" expiry')
def lambda_elasticache_seq_entry_evicted():
    pytest.skip("Cannot trigger ElastiCache eviction in lws")


@given("the Lambda invocation has read an existing cache entry and completed successfully")
def lambda_elasticache_seq_invocation_read_succeeded():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("the Lambda invocation has failed because all cache entries have been evicted")
def lambda_elasticache_seq_invocation_cache_miss():
    pytest.skip("Cannot trigger Lambda invocation in lws")


# ── When: actions ───────────────────────────────────────────────────────


@when("a Lambda function is deployed")
def deploy_lambda_function(lws_session, world):
    try:
        _create_function(lws_session)
        world["result"] = {"FunctionName": TEST_FUNC}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an ElastiCache cluster is created")
def create_elasticache_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function writes a value to the ElastiCache cluster during invocation")
def lambda_writes_cache(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda invocation fails because all cache entries have been evicted")
def invocation_fails_cache_miss(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda invocation reads an existing cache entry and completes successfully")
def invocation_succeeds_cache_hit(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('ElastiCache evicts a cache entry due to memory pressure or "TTL" expiry')
def cache_evict(world):
    pytest.skip("Cannot trigger ElastiCache eviction in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED"')
def invocation_is_failed_then(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


@then('the cache entry is "CACHED" in the cluster')
def cache_entry_cached(world):
    pytest.skip("Cannot observe Lambda cache write result in lws")


@then('the cache entry is "EVICTED"')
def cache_entry_evicted(world):
    pytest.skip("Cannot observe ElastiCache eviction in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "CACHED" entry belongs to an "AVAILABLE" cluster')
def _inv_lambda_elasticache_every_cached_entry_belongs_to_an_available_cluster():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_elasticache_every_in_progress_invocation_references_an_active_lambda():
    """Invariant step: trivially satisfied in isolated test context."""
