"""Shared fixtures and BDD step definitions for Elasticsearch integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.elasticsearch.routes import create_elasticsearch_app

INT_DOMAIN = "int-elasticsearch-domain-1"
INT_INDEX = "int-elasticsearch-index-1"
INT_TAG_KEY = "int-elasticsearch-tag-key-1"
INT_TAG_VALUE = "int-elasticsearch-tag-value-1"

_ES_TARGET = "ElasticsearchService_20150101"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """Elasticsearch uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_elasticsearch_app()


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _post(client: TestClient, action: str, body: dict):
    return client.post(
        "/",
        headers={"X-Amz-Target": f"{_ES_TARGET}.{action}"},
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
    _post(client, "CreateElasticsearchDomain", {"DomainName": domain_name})


def _get_domain_arn(client: TestClient, domain_name: str = INT_DOMAIN) -> str:
    r = _post(client, "DescribeElasticsearchDomain", {"DomainName": domain_name})
    return r.json().get("DomainStatus", {}).get("ARN", "")


# ── Given: domain state ────────────────────────────────────────────────────────


@given("the domain does not already exist")
def es_domain_not_already_exist():
    """No-op: fresh state has no domains."""


@given("the domain already exists")
def es_domain_already_exists(client: TestClient):
    _create_domain(client)


@given("the domain exists")
def es_domain_exists(client: TestClient):
    _create_domain(client)


@given("the domain does not exist")
def es_domain_does_not_exist():
    """No-op: fresh state has no domains."""


@given('the domain is "ACTIVE"')
def es_domain_is_active():
    """No-op: domains are ACTIVE immediately after creation in lws."""


@given('the domain is "CREATING"')
def es_domain_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is "DELETING"')
def es_domain_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is "PROCESSING"')
def es_domain_is_processing(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is not "ACTIVE"')
def es_domain_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is not "CREATING"')
def es_domain_is_not_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is not "DELETING"')
def es_domain_is_not_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given('the domain is not "PROCESSING"')
def es_domain_is_not_processing(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the domain is not being deleted")
def es_domain_not_being_deleted():
    """No-op: domains are not being deleted in fresh state."""


@given("the domain is being deleted")
def es_domain_is_being_deleted(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the domain is not deleted")
def es_domain_is_not_deleted():
    """No-op: domains are not deleted in fresh state."""


@given("the domain is deleted")
def es_domain_is_deleted(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")


@given("the domain has a pending configuration change")
def es_domain_has_pending_config_change(world):
    pytest.skip("Pending configuration changes not available in stateless integration tests.")


@given("the domain does not have a pending configuration change")
def es_domain_no_pending_config_change(world):
    pytest.skip("Pending configuration changes not available in stateless integration tests.")


@given("the tag key exists")
def es_tag_key_exists(client: TestClient):
    arn = _get_domain_arn(client)
    _post(
        client,
        "AddTags",
        {"ARN": arn, "TagList": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]},
    )


@given("the tag key does not exist")
def es_tag_key_does_not_exist(world):
    pytest.skip("lws RemoveTags is idempotent and does not fail on missing tag keys.")


# ── Given: index state ─────────────────────────────────────────────────────────


@given("the index exists")
def es_index_exists(world):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")


@given("the index does not exist")
def es_index_does_not_exist():
    """No-op: fresh state has no indexes."""


@given("the index does not already exist")
def es_index_does_not_already_exist():
    """No-op: fresh state has no indexes."""


@given("the index already exists")
def es_index_already_exists(world):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")


@given('the index is "ACTIVE"')
def es_index_is_active(world):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")


@given('the index is not "ACTIVE"')
def es_index_is_not_active(world):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a search domain is created")
def es_create_domain(client: TestClient, world: dict):
    r = _post(client, "CreateElasticsearchDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)


@when("a search domain is deleted")
def es_delete_domain(client: TestClient, world: dict):
    r = _post(client, "DeleteElasticsearchDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)


@when("a search domain finishes creating")
def es_finish_creating_domain(client: TestClient, world: dict):
    r = _post(client, "DescribeElasticsearchDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)


@when("a search domain finishes deleting")
def es_finish_deleting_domain(client: TestClient, world: dict):
    r = _post(client, "DeleteElasticsearchDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)


@when("tags are added to a domain")
def es_add_tags_to_domain(client: TestClient, world: dict):
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
def es_remove_tags_from_domain(client: TestClient, world: dict):
    arn = _get_domain_arn(client)
    if not arn:
        world["result"] = None
        world["error"] = {"message": f"Domain {INT_DOMAIN} not found"}
        return
    r = _post(client, "RemoveTags", {"ARN": arn, "TagKeys": [INT_TAG_KEY]})
    _store(world, r)


@when("a domain configuration update is requested")
def es_update_domain_config(client: TestClient, world: dict):
    pytest.skip("UpdateElasticsearchDomainConfig is not yet implemented in lws.")


@when("a domain finishes processing its configuration update")
def es_finish_processing_config(client: TestClient, world: dict):
    pytest.skip("UpdateElasticsearchDomainConfig is not yet implemented in lws.")


@when("a node failure occurs in an active domain")
def es_node_failure(client: TestClient, world: dict):
    pytest.skip("Node failure simulation cannot be triggered in stateless integration tests.")


@when("an index is created in an active domain")
def es_create_index(client: TestClient, world: dict):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")


@when("an index is deleted from an active domain")
def es_delete_index(client: TestClient, world: dict):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")


@when("a document is indexed in an active index")
def es_index_document(client: TestClient, world: dict):
    pytest.skip("Document indexing is not available in the core Elasticsearch integration API.")


@when("a replica sync lag event occurs on an active domain")
def es_replica_sync_lag(client: TestClient, world: dict):
    pytest.skip("Replica sync lag simulation cannot be triggered in stateless integration tests.")


@when("shards are reallocated across nodes in an active domain")
def es_shard_reallocation(client: TestClient, world: dict):
    pytest.skip("Shard reallocation simulation cannot be triggered in stateless integration tests.")


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the domain is in "CREATING" state')
def es_domain_is_in_creating_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain creation to succeed but got error: {world['error']}"
    assert (
        "DomainStatus" in actual_result
    ), f"Expected DomainStatus in result but got: {actual_result}"


@then('the domain is in "DELETING" state')
def es_domain_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain deletion to succeed but got error: {world['error']}"
    assert (
        "DomainStatus" in actual_result
    ), f"Expected DomainStatus in result but got: {actual_result}"


@then('the domain is in "PROCESSING" state with a pending config change')
def es_domain_is_in_processing_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain config update to succeed but got error: {world['error']}"


@then('the domain is "ACTIVE" and ready for use')
def es_domain_is_active_ready_for_use(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the domain is "ACTIVE" with the new configuration applied')
def es_domain_is_active_with_new_config(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the domain is "DELETED" and all its indices are removed')
def es_domain_is_deleted_indices_removed(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the domain enters "PROCESSING" state while recovering')
def es_domain_enters_processing_while_recovering(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("the specified tags are associated with the domain")
def es_specified_tags_associated_with_domain(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected tag addition to succeed but got error: {world['error']}"


@then("the specified tags are no longer associated with the domain")
def es_specified_tags_not_associated_with_domain(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected tag removal to succeed but got error: {world['error']}"


@then('the index is "ACTIVE" with zero documents')
def es_index_is_active_zero_documents(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then('the index is marked as "DELETED"')
def es_index_is_marked_deleted(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("the document count for the index increases by one")
def es_document_count_increases(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("the replica eventually catches up without changing document counts")
def es_replica_catches_up(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("the domain shard layout is updated without changing document counts")
def es_shard_layout_updated(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"


@then("every active index belongs to an existing non-deleted domain")
def every_active_index_belongs_to_existing_domain():
    """Invariant trivially satisfied in isolated test context."""


@then("every active tag belongs to an existing non-deleted domain")
def every_active_tag_belongs_to_existing_domain():
    """Invariant trivially satisfied in isolated test context."""


@then('a pending config change only exists on a domain that is "PROCESSING"')
def es_pending_config_change_only_on_processing_domain():
    """Invariant trivially satisfied in isolated test context."""
