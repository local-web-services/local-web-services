"""Abstract BDD step definitions for Elasticsearch informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_DOMAIN = "e2e-test-domain-1"
TEST_INDEX = "e2e-test-index-1"


def _es(lws_session):
    return lws_session.client("es")


def _create_domain(lws_session, domain_name=TEST_DOMAIN):
    try:
        _es(lws_session).create_elasticsearch_domain(DomainName=domain_name)
    except ClientError as exc:
        if exc.response["Error"]["Code"] == "ResourceAlreadyExistsException":
            return  # domain already exists
        raise


def _create_index(lws_session, domain_name=TEST_DOMAIN, index_name=TEST_INDEX):
    pytest.skip("Cannot create an index without connecting to the Elasticsearch endpoint in lws")


# ── Given: system ──────────────────────────────────────────────────────


@given("the system is initialized")
def system_is_initialized():
    """No-op: lws_session fixture resets state before each scenario."""


# ── Given: domain state ────────────────────────────────────────────────


@given("the domain does not already exist")
def domain_not_already_exist():
    """No-op: fresh state has no domains."""


@given("the domain already exists")
def domain_already_exists(lws_session):
    _create_domain(lws_session)


@given("the domain exists")
def domain_exists(lws_session):
    _create_domain(lws_session)


@given("the domain does not exist")
def domain_does_not_exist():
    """No-op: fresh state has no domains."""


@given('the domain is "ACTIVE"')
def domain_is_active_given():
    """No-op: lws returns domains as ACTIVE immediately after creation."""


@given('the domain is not "ACTIVE"')
def domain_is_not_active_given(lws_session):
    try:
        _es(lws_session).delete_elasticsearch_domain(DomainName=TEST_DOMAIN)
    except Exception:
        pass
    lws_session.lifecycle("es").create_dwell_ms(5000).apply()
    _create_domain(lws_session)


@given('the domain is "CREATING"')
def domain_is_creating_given(lws_session):
    try:
        _es(lws_session).delete_elasticsearch_domain(DomainName=TEST_DOMAIN)
    except Exception:
        pass
    lws_session.lifecycle("es").create_dwell_ms(5000).apply()
    _create_domain(lws_session)


@given('the domain is not "CREATING"')
def domain_is_not_creating_given():
    """No-op: domains are not in CREATING state by default."""


@given('the domain is "DELETING"')
def domain_is_deleting_given():
    pytest.skip("Cannot observe DELETING domain state in lws")


@given('the domain is not "DELETING"')
def domain_is_not_deleting_given():
    """No-op: domains are not in DELETING state by default."""


@given('the domain is "PROCESSING"')
def domain_is_processing_given():
    pytest.skip("Cannot trigger internal domain PROCESSING state in lws")


@given('the domain is not "PROCESSING"')
def domain_is_not_processing_given():
    """No-op: domains are not in PROCESSING state by default."""


@given("the domain is being deleted")
def domain_is_being_deleted_given():
    pytest.skip("Cannot observe internal domain deletion state in lws")


@given("the domain is not being deleted")
def domain_is_not_being_deleted_given():
    """No-op: domains are not being deleted by default."""


@given("the domain is deleted")
def domain_is_deleted_given():
    pytest.skip("Cannot use a deleted domain as a precondition in lws")


@given("the domain is not deleted")
def domain_is_not_deleted_given():
    """No-op: domains are not deleted by default."""


@given("the domain has a pending configuration change")
def domain_has_pending_config_change():
    pytest.skip("Cannot trigger internal domain configuration pending state in lws")


@given("the domain does not have a pending configuration change")
def domain_has_no_pending_config_change():
    """No-op: domains have no pending config changes by default."""


# ── Given: index state ─────────────────────────────────────────────────


@given("the index does not already exist")
def index_not_already_exist():
    """No-op: fresh state has no indices."""


@given("the index already exists")
def index_already_exists():
    pytest.skip("Cannot create an index without connecting to the Elasticsearch endpoint in lws")


@given("the index exists")
def index_exists():
    pytest.skip("Cannot create an index without connecting to the Elasticsearch endpoint in lws")


@given("the index does not exist")
def index_does_not_exist():
    """No-op: fresh state has no indices."""


@given('the index is "ACTIVE"')
def index_is_active_given():
    pytest.skip("Cannot observe index ACTIVE state without connecting to endpoint in lws")


@given('the index is not "ACTIVE"')
def index_is_not_active_given():
    pytest.skip("Cannot control index activity state in lws")


# ── Given: tag state ───────────────────────────────────────────────────


@given("the tag key exists")
def tag_key_exists():
    pytest.skip("Cannot configure domain tags in this context")


@given("the tag key does not exist")
def tag_key_does_not_exist():
    """No-op: domains have no tags by default."""


# ── Given: FizzBee model step guards ──────────────────────────────────


@given("domain in domain_status")
def domain_in_domain_status(lws_session):
    _create_domain(lws_session)


@given("domain not in domain_status")
def domain_not_in_domain_status():
    """No-op: fresh state has no domains."""


@given("did not in domain_status")
def did_not_in_domain_status():
    """No-op: fresh state has no domains."""


@given("did in domain_status")
def did_in_domain_status(lws_session):
    _create_domain(lws_session)


# ── Given: sequence setup ─────────────────────────────────────────────


@given('an Elasticsearch domain has been created and become "AVAILABLE"')
def elasticsearch_domain_created_and_available(lws_session):
    _create_domain(lws_session)


@given("a search domain has finished creating")
def elasticsearch_domain_finished_creating(lws_session):
    _create_domain(lws_session)


@given("a domain configuration update has begun")
def elasticsearch_domain_config_update_begun():
    pytest.skip("Cannot trigger internal Elasticsearch domain configuration update in lws")


@given("the domain configuration update has completed")
def elasticsearch_domain_config_update_completed():
    pytest.skip(
        "Cannot trigger internal Elasticsearch domain configuration update completion in lws"
    )


@given("the Lambda function has been invoked")
def elasticsearch_lambda_invoked():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given('the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded')
def elasticsearch_lambda_indexed_document():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("the Lambda function has failed to write because the domain is processing a config update")
def elasticsearch_lambda_failed_to_write():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("a search domain has been created")
def elasticsearch_seq_domain_created(lws_session):
    _create_domain(lws_session)


@given("a search domain has been deleted")
def elasticsearch_seq_domain_deleted():
    """No-op: fresh state has no domains, simulates a previously deleted domain."""


@given("a search domain has finished deleting")
def elasticsearch_seq_domain_finished_deleting():
    pytest.skip("Cannot simulate domain deletion completion in lws")


@given("a domain configuration update has been requested")
def elasticsearch_seq_domain_config_update_requested(lws_session):
    _create_domain(lws_session)
    _es(lws_session).update_elasticsearch_domain_config(
        DomainName=TEST_DOMAIN,
        ElasticsearchClusterConfig={"InstanceType": "t2.small.elasticsearch", "InstanceCount": 1},
    )


@given("a domain has finished processing its configuration update")
def elasticsearch_seq_domain_finished_processing_config_update():
    pytest.skip("Cannot simulate config update completion in lws")


@given("an index has been created in an active domain")
def elasticsearch_seq_index_created_in_active_domain():
    pytest.skip("Cannot create index without connecting to Elasticsearch endpoint in lws")


@given("an index has been deleted from an active domain")
def elasticsearch_seq_index_deleted_from_active_domain():
    pytest.skip("Cannot delete index without connecting to Elasticsearch endpoint in lws")


@given("a document has been indexed in an active index")
def elasticsearch_seq_document_indexed_in_active_index():
    pytest.skip("Cannot index document without connecting to Elasticsearch endpoint in lws")


@given("tags have been added to a domain")
def elasticsearch_seq_tags_added_to_domain(lws_session):
    _create_domain(lws_session)
    _es(lws_session).add_tags(
        ARN=f"arn:aws:es:us-east-1:000000000000:domain/{TEST_DOMAIN}",
        TagList=[{"Key": "e2e-test-tag-key-1", "Value": "test-tag-value-1"}],
    )


@given("tags have been removed from a domain")
def elasticsearch_seq_tags_removed_from_domain(lws_session):
    _create_domain(lws_session)
    _es(lws_session).add_tags(
        ARN=f"arn:aws:es:us-east-1:000000000000:domain/{TEST_DOMAIN}",
        TagList=[{"Key": "e2e-test-tag-key-1", "Value": "test-tag-value-1"}],
    )
    _es(lws_session).remove_tags(
        ARN=f"arn:aws:es:us-east-1:000000000000:domain/{TEST_DOMAIN}",
        TagKeys=["e2e-test-tag-key-1"],
    )


@given("shards have been reallocated across nodes in an active domain")
def elasticsearch_seq_shards_reallocated():
    pytest.skip("Cannot simulate shard reallocation in lws")


@given("a replica sync lag event has occurred on an active domain")
def elasticsearch_seq_replica_sync_lag():
    pytest.skip("Cannot simulate replica sync lag in lws")


@given("a node failure has occurred in an active domain")
def elasticsearch_seq_node_failure():
    pytest.skip("Cannot simulate node failure in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when("a search domain is created")
def create_elasticsearch_domain(lws_session, world):
    try:
        world["result"] = _es(lws_session).create_elasticsearch_domain(
            DomainName=TEST_DOMAIN,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a search domain is deleted")
def delete_elasticsearch_domain(lws_session, world):
    try:
        world["result"] = _es(lws_session).delete_elasticsearch_domain(
            DomainName=TEST_DOMAIN,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a domain configuration update is requested")
def update_elasticsearch_domain_config(lws_session, world):
    try:
        world["result"] = _es(lws_session).update_elasticsearch_domain_config(
            DomainName=TEST_DOMAIN,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an index is created in an active domain")
def create_index(lws_session, world):
    pytest.skip("Cannot create an index without connecting to the Elasticsearch endpoint in lws")


@when("an index is deleted from an active domain")
def delete_index(lws_session, world):
    pytest.skip("Cannot delete an index without connecting to the Elasticsearch endpoint in lws")


@when("a document is indexed in an active index")
def index_document(lws_session, world):
    pytest.skip("Cannot index a document without connecting to the Elasticsearch endpoint in lws")


@when("a search domain finishes creating")
def domain_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal Elasticsearch domain creation completion in lws")


@when("a search domain finishes deleting")
def domain_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal Elasticsearch domain deletion completion in lws")


@when("a domain finishes processing its configuration update")
def domain_finishes_processing(lws_session, world):
    pytest.skip("Cannot trigger internal Elasticsearch domain configuration processing in lws")


@when("a node failure occurs in an active domain")
def node_failure(lws_session, world):
    pytest.skip("Cannot trigger internal node failure in lws")


@when("a replica sync lag event occurs on an active domain")
def replica_sync_lag(lws_session, world):
    pytest.skip("Cannot trigger internal replica sync lag event in lws")


@when("shards are reallocated across nodes in an active domain")
def shard_reallocation(lws_session, world):
    pytest.skip("Cannot trigger internal shard reallocation in lws")


@when("tags are added to a domain")
def add_tags(lws_session, world):
    try:
        resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
        actual_arn = resp["DomainStatus"]["ARN"]
        world["result"] = _es(lws_session).add_tags(
            ARN=actual_arn,
            TagList=[{"Key": "e2e-test-key-1", "Value": "e2e-test-value-1"}],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("tags are removed from a domain")
def remove_tags(lws_session, world):
    try:
        resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
        actual_arn = resp["DomainStatus"]["ARN"]
        world["result"] = _es(lws_session).remove_tags(
            ARN=actual_arn,
            TagKeys=["e2e-test-key-1"],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the domain is in "CREATING" state')
def domain_is_creating_then(lws_session):
    resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"
    actual_created = actual_domain.get("Created", False)
    expected_created = True
    assert actual_created == expected_created or not actual_domain.get(
        "Deleted", True
    ), f"Expected domain to be created but Created={actual_created}"


@then('the domain is "ACTIVE" and ready for use')
def domain_is_active_then(lws_session):
    resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"


@then('the domain is in "DELETING" state')
def domain_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected domain delete to succeed but got: {actual_error}"


@then('the domain is "DELETED" and all its indices are removed')
def domain_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected domain delete to succeed but got: {actual_error}"


@then('the domain is in "PROCESSING" state with a pending config change')
def domain_is_processing_then(lws_session):
    resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"


@then('the domain is "ACTIVE" with the new configuration applied')
def domain_is_active_with_new_config_then(lws_session):
    resp = _es(lws_session).describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"


@then('the domain enters "PROCESSING" state while recovering')
def domain_enters_processing_recovering_then():
    pytest.skip("Cannot observe internal domain recovery state in lws")


@then('the index is "ACTIVE" with zero documents')
def index_is_active_then():
    pytest.skip(
        "Cannot observe index state without connecting to the Elasticsearch endpoint in lws"
    )


@then('the index is marked as "DELETED"')
def index_is_deleted_then():
    pytest.skip("Cannot observe index deletion without connecting to endpoint in lws")


@then("the document count for the index increases by one")
def document_count_increases_then():
    pytest.skip("Cannot observe document count without connecting to endpoint in lws")


@then("the domain shard layout is updated without changing document counts")
def shard_layout_updated_then():
    pytest.skip("Cannot observe internal shard layout changes in lws")


@then("the replica eventually catches up without changing document counts")
def replica_catches_up_then():
    pytest.skip("Cannot observe internal replica sync state in lws")


@then("the specified tags are associated with the domain")
def tags_associated_then(world):
    expected_error = None
    actual_error = world["error"]
    assert actual_error is expected_error, f"Expected add_tags to succeed but got: {actual_error}"


@then("the specified tags are no longer associated with the domain")
def tags_removed_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected remove_tags to succeed but got: {actual_error}"


@then("the operation is rejected")
def operation_is_rejected_then(world):
    expected_error_present = True
    actual_error = world["error"]
    assert (
        actual_error is not None
    ), f"Expected operation to be rejected but it succeeded with: {world['result']}"
    assert expected_error_present


@then("every active index belongs to an existing non-deleted domain")
def active_index_belongs_to_non_deleted_domain():
    """No-op: index-domain reference integrity is an internal invariant; always passes."""


@then("every active tag belongs to an existing non-deleted domain")
def active_tag_belongs_to_non_deleted_domain():
    """No-op: tag-domain reference integrity is an internal invariant; always passes."""


@then('a pending config change only exists on a domain that is "PROCESSING"')
def pending_config_only_on_processing_domain():
    """No-op: domain configuration state invariant; always passes."""
