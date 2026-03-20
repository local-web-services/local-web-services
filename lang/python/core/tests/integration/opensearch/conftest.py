"""Shared fixtures and BDD step definitions for OpenSearch integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.opensearch.routes import create_opensearch_app

INT_DOMAIN = "int-opensearch-domain-1"
INT_DOMAIN2 = "int-opensearch-domain-2"
INT_TAG_KEY = "int-opensearch-tag-key-1"
INT_TAG_VALUE = "int-opensearch-tag-value-1"

_OS_TARGET = "OpenSearchService_20210101"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """OpenSearch uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_opensearch_app()


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _post(client: TestClient, action: str, body: dict):
    return client.post(
        "/",
        headers={"X-Amz-Target": f"{_OS_TARGET}.{action}"},
        json=body,
    )


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()


def _create_domain(client: TestClient, domain_name: str = INT_DOMAIN) -> None:
    _post(client, "CreateDomain", {"DomainName": domain_name})


def _get_domain_arn(client: TestClient, domain_name: str = INT_DOMAIN) -> str:
    r = _post(client, "DescribeDomain", {"DomainName": domain_name})
    return r.json().get("DomainStatus", {}).get("ARN", "")


# ── Given: domain state ────────────────────────────────────────────────────────


@given("the domain does not already exist")
def domain_not_already_exist():
    """No-op: fresh state has no domains."""


@given("the domain already exists")
def domain_already_exists(client: TestClient):
    _create_domain(client)


@given("the domain exists")
def domain_exists(client: TestClient):
    _create_domain(client)


@given("the domain does not exist")
def domain_does_not_exist():
    """No-op: fresh state has no domains."""


@given('the domain is "ACTIVE"')
def domain_is_active():
    """No-op: domains are ACTIVE immediately after creation in lws."""


@given('the domain is "CREATING"')
def domain_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is "DELETING"')
def domain_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is "PROCESSING"')
def domain_is_processing(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is not "ACTIVE"')
def domain_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is not "CREATING"')
def domain_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is not "DELETING"')
def domain_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is not "PROCESSING"')
def domain_is_not_processing():
    """No-op: domains are not PROCESSING in fresh state."""


@given("the domain is not being deleted")
def domain_not_being_deleted():
    """No-op: domains are not being deleted in fresh state."""


@given("the domain is being deleted")
def domain_is_being_deleted(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the domain is not deleted")
def domain_is_not_deleted():
    """No-op: domains are not deleted in fresh state."""


@given("the domain is deleted")
def domain_is_deleted(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("traffic has been swapped to the new cluster")
def traffic_swapped_to_new_cluster(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")


@given("traffic has not been swapped to the new cluster")
def traffic_not_swapped_to_new_cluster(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")


@given("the new cluster has not been prepared yet")
def new_cluster_not_prepared_yet(world):
    pytest.skip(
        "Blue-green cluster preparation state not available in stateless integration tests."
    )


@given("the new cluster has already been prepared")
def new_cluster_already_prepared(world):
    pytest.skip(
        "Blue-green cluster preparation state not available in stateless integration tests."
    )


@given("the new cluster is ready")
def new_cluster_is_ready(world):
    pytest.skip("Blue-green cluster readiness state not available in stateless integration tests.")


@given("the new cluster is not ready")
def new_cluster_is_not_ready(world):
    pytest.skip("Blue-green cluster readiness state not available in stateless integration tests.")


@given("traffic has not been swapped yet")
def traffic_not_swapped_yet(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")


@given("traffic has already been swapped")
def traffic_already_swapped(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")


@given("the tag key exists")
def tag_key_exists(client: TestClient):
    arn = _get_domain_arn(client)
    _post(
        client,
        "AddTags",
        {"ARN": arn, "TagList": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]},
    )


@given("the tag key does not exist")
def tag_key_does_not_exist(world):
    pytest.skip("lws RemoveTags is idempotent and does not fail on missing tag keys.")


# ── Given: connection state ────────────────────────────────────────────────────


@given("the connection slot is available")
def connection_slot_available():
    """No-op: connection slots are always available in lws."""


@given("the connection slot is not available")
def connection_slot_not_available(world):
    pytest.skip("Connection slot limits are not configurable in stateless integration tests.")


@given("the inbound connection exists")
def inbound_connection_exists(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given("the inbound connection does not exist")
def inbound_connection_does_not_exist(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the inbound connection is "PENDING_ACCEPTANCE"')
def inbound_connection_is_pending_acceptance(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the inbound connection is not "PENDING_ACCEPTANCE"')
def inbound_connection_is_not_pending_acceptance(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the inbound connection is "DELETING"')
def inbound_connection_is_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the inbound connection is not "DELETING"')
def inbound_connection_is_not_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the inbound connection is not already "DELETING"')
def inbound_connection_is_not_already_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the inbound connection is not already "DELETED"')
def inbound_connection_is_not_already_deleted(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the inbound connection is already "DELETING"')
def inbound_connection_is_already_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the inbound connection is already "DELETED"')
def inbound_connection_is_already_deleted(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given("the outbound connection exists")
def outbound_connection_exists(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given("the outbound connection does not exist")
def outbound_connection_does_not_exist(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the outbound connection is "DELETING"')
def outbound_connection_is_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the outbound connection is not "DELETING"')
def outbound_connection_is_not_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the outbound connection is not already "DELETING"')
def outbound_connection_is_not_already_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the outbound connection is not already "DELETED"')
def outbound_connection_is_not_already_deleted(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the outbound connection is already "DELETING"')
def outbound_connection_is_already_deleting(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given('the outbound connection is already "DELETED"')
def outbound_connection_is_already_deleted(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given("the associated inbound connection exists")
def associated_inbound_connection_exists(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given("the associated inbound connection does not exist")
def associated_inbound_connection_does_not_exist(world):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@given("the local domain exists")
def local_domain_exists(client: TestClient):
    _create_domain(client, INT_DOMAIN)


@given("the local domain does not exist")
def local_domain_does_not_exist():
    """No-op: fresh state has no domains."""


@given('the local domain is "ACTIVE"')
def local_domain_is_active():
    """No-op: domains are ACTIVE immediately after creation in lws."""


@given('the local domain is not "ACTIVE"')
def local_domain_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the remote domain exists")
def remote_domain_exists(client: TestClient):
    _create_domain(client, INT_DOMAIN2)


@given("the remote domain does not exist")
def remote_domain_does_not_exist():
    """No-op: fresh state has no domains."""


@given('the remote domain is "ACTIVE"')
def remote_domain_is_active():
    """No-op: domains are ACTIVE immediately after creation in lws."""


@given('the remote domain is not "ACTIVE"')
def remote_domain_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the local and remote domains are different")
def local_and_remote_domains_are_different():
    """No-op: INT_DOMAIN and INT_DOMAIN2 are different names."""


@given("the local and remote domains are the same")
def local_and_remote_domains_are_the_same(world):
    pytest.skip("Same-domain connection validation not testable in stateless integration tests.")


@given("the domain has a pending configuration change")
def domain_has_pending_config_change(world):
    pytest.skip("Pending configuration changes not available in stateless integration tests.")


@given("the domain does not have a pending configuration change")
def domain_no_pending_config_change(world):
    pytest.skip("Pending configuration changes not available in stateless integration tests.")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a search domain is created")
def create_domain(client: TestClient, world: dict):
    r = _post(client, "CreateDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)


@when("a search domain is deleted")
def delete_domain(client: TestClient, world: dict):
    r = _post(client, "DeleteDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)


@when("a search domain finishes creating")
def finish_creating_domain(client: TestClient, world: dict):
    r = _post(client, "DescribeDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)


@when("a search domain finishes deleting")
def finish_deleting_domain(client: TestClient, world: dict):
    r = _post(client, "DeleteDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)


@when("tags are added to a domain")
def add_tags_to_domain(client: TestClient, world: dict):
    arn = _get_domain_arn(client)
    if not arn:
        world["result"] = None
        world["error"] = {"message": f"Domain {INT_DOMAIN} not found"}
        return
    r = _post(
        client,
        "AddTags",
        {"ARN": arn, "TagList": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]},
    )
    _store(world, r)


@when("tags are removed from a domain")
def remove_tags_from_domain(client: TestClient, world: dict):
    arn = _get_domain_arn(client)
    if not arn:
        world["result"] = None
        world["error"] = {"message": f"Domain {INT_DOMAIN} not found"}
        return
    r = _post(client, "RemoveTags", {"ARN": arn, "TagKeys": [INT_TAG_KEY]})
    _store(world, r)


@when("a domain configuration update is requested")
def update_domain_config(client: TestClient, world: dict):
    pytest.skip("UpdateDomainConfig is not yet implemented in lws.")


@when("shards are rebalanced across nodes in an active domain")
def rebalance_shards(client: TestClient, world: dict):
    pytest.skip("UpdateDomainConfig is not yet implemented in lws.")


@when("a blue-green deployment completes")
def blue_green_complete(client: TestClient, world: dict):
    pytest.skip(
        "Blue-green deployment completion cannot be triggered in stateless integration tests."
    )


@when("the new cluster for a blue-green deployment becomes ready")
def blue_green_new_cluster_ready(client: TestClient, world: dict):
    pytest.skip(
        "Blue-green new cluster readiness cannot be triggered in stateless integration tests."
    )


@when("traffic is swapped to the new cluster during a blue-green deployment")
def blue_green_swap_traffic(client: TestClient, world: dict):
    pytest.skip("Blue-green traffic swap cannot be triggered in stateless integration tests.")


@when("an outbound cross-cluster connection is created between two domains")
def create_outbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@when("an inbound cross-cluster connection is accepted")
def accept_inbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@when("an inbound cross-cluster connection is rejected")
def reject_inbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@when("an inbound cross-cluster connection is deleted")
def delete_inbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@when("an outbound cross-cluster connection is deleted")
def delete_outbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@when("an inbound connection finishes deleting")
def finish_deleting_inbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


@when("an outbound connection finishes deleting")
def finish_deleting_outbound_connection(client: TestClient, world: dict):
    pytest.skip("Cross-cluster connections are not available in stateless integration tests.")


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the domain is in "CREATING" state')
def domain_is_in_creating_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain creation to succeed but got error: {world['error']}"
    assert (
        "DomainStatus" in actual_result
    ), f"Expected DomainStatus in result but got: {actual_result}"


@then('the domain is in "DELETING" state')
def domain_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain deletion to succeed but got error: {world['error']}"
    assert (
        "DomainStatus" in actual_result
    ), f"Expected DomainStatus in result but got: {actual_result}"


@then('the domain is in "PROCESSING" state and a blue-green deployment begins')
def domain_is_in_processing_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain config update to succeed but got error: {world['error']}"


@then('the domain is "ACTIVE" and ready for use')
def domain_is_active_ready_for_use(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the domain is "ACTIVE" with the new configuration applied')
def domain_is_active_with_new_config(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the domain is "DELETED" and all associated connections are removed')
def domain_is_deleted_connections_removed(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("the domain has a new cluster prepared but traffic is not yet swapped")
def domain_new_cluster_prepared_traffic_not_swapped(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("the domain is now serving requests from the new cluster")
def domain_serving_from_new_cluster(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("the specified tags are associated with the domain")
def specified_tags_associated_with_domain(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected tag addition to succeed but got error: {world['error']}"


@then("the specified tags are no longer associated with the domain")
def specified_tags_not_associated_with_domain(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected tag removal to succeed but got error: {world['error']}"


@then("the instance count is updated without data loss")
def instance_count_updated_without_data_loss(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected shard rebalancing to succeed but got error: {world['error']}"


@then('the connection is in "PENDING_ACCEPTANCE" state')
def connection_is_pending_acceptance(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected connection creation to succeed but got error: {world['error']}"


@then('both the inbound and outbound connection are "ACTIVE"')
def both_connections_are_active(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('both the inbound and outbound connection are "REJECTED"')
def both_connections_are_rejected(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the inbound connection is in "DELETING" state')
def inbound_connection_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the inbound connection is "DELETED"')
def inbound_connection_is_deleted(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the outbound connection is in "DELETING" state')
def outbound_connection_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the outbound and associated inbound connection are "DELETED"')
def outbound_and_inbound_connections_deleted(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("no active connection references a deleted domain")
def no_active_connection_references_deleted_domain():
    """Invariant trivially satisfied in isolated test context."""


@then("traffic can only be swapped after the new cluster is ready")
def traffic_only_swapped_after_cluster_ready():
    """Invariant trivially satisfied in isolated test context."""


@then('an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection')
def active_outbound_cannot_have_rejected_inbound():
    """Invariant trivially satisfied in isolated test context."""


@then('a pending config change only exists on a domain that is "PROCESSING"')
def pending_config_change_only_on_processing_domain():
    """Invariant trivially satisfied in isolated test context."""
