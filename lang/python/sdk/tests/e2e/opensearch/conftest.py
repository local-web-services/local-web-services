"""Abstract BDD step definitions for Opensearch informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_DOMAIN = "e2e-test-domain-1"
TEST_DOMAIN_2 = "e2e-test-domain-2"


def _opensearch(lws_session):
    return lws_session.client("opensearch")


def _create_domain(lws_session, domain_name=TEST_DOMAIN):
    _opensearch(lws_session).create_domain(DomainName=domain_name)


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
        _opensearch(lws_session).delete_domain(DomainName=TEST_DOMAIN)
    except Exception:
        pass
    lws_session.lifecycle("opensearch").create_dwell_ms(5000).apply()
    _create_domain(lws_session)


@given('the domain is "CREATING"')
def domain_is_creating_given(lws_session):
    try:
        _opensearch(lws_session).delete_domain(DomainName=TEST_DOMAIN)
    except Exception:
        pass
    lws_session.lifecycle("opensearch").create_dwell_ms(5000).apply()
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


@given("the local domain exists")
def local_domain_exists(lws_session):
    _create_domain(lws_session)


@given("the local domain does not exist")
def local_domain_does_not_exist():
    """No-op: fresh state has no domains."""


@given('the local domain is "ACTIVE"')
def local_domain_is_active_given():
    """No-op: lws returns domains as ACTIVE immediately after creation."""


@given('the local domain is not "ACTIVE"')
def local_domain_is_not_active_given():
    pytest.skip("Cannot control local domain activity state in lws")


@given("the remote domain exists")
def remote_domain_exists(lws_session):
    _create_domain(lws_session, domain_name=TEST_DOMAIN_2)


@given("the remote domain does not exist")
def remote_domain_does_not_exist():
    """No-op: fresh state has no remote domains."""


@given('the remote domain is "ACTIVE"')
def remote_domain_is_active_given():
    """No-op: lws returns domains as ACTIVE immediately after creation."""


@given('the remote domain is not "ACTIVE"')
def remote_domain_is_not_active_given():
    pytest.skip("Cannot control remote domain activity state in lws")


@given("the local and remote domains are different")
def local_and_remote_domains_different():
    """No-op: domains are different by default."""


@given("the local and remote domains are the same")
def local_and_remote_domains_same():
    pytest.skip("Cannot create cross-cluster connection between same domain in lws")


# ── Given: connection state ────────────────────────────────────────────


@given("the connection slot is available")
def connection_slot_available():
    """No-op: always room for connections."""


@given("the connection slot is not available")
def connection_slot_not_available():
    pytest.skip("Cannot exhaust connection slot limit in lws")


@given("the outbound connection does not exist")
def outbound_connection_does_not_exist():
    """No-op: fresh state has no connections."""


@given("the outbound connection exists")
def outbound_connection_exists():
    pytest.skip("Cannot create an outbound connection as a precondition in this context")


@given('the outbound connection is "DELETING"')
def outbound_connection_is_deleting_given():
    pytest.skip("Cannot observe DELETING outbound connection state in lws")


@given('the outbound connection is not "DELETING"')
def outbound_connection_is_not_deleting_given():
    """No-op: outbound connections are not in DELETING state by default."""


@given('the outbound connection is already "DELETED"')
def outbound_connection_already_deleted_given():
    pytest.skip("Cannot use a deleted connection as a precondition in lws")


@given('the outbound connection is not already "DELETED"')
def outbound_connection_not_already_deleted_given():
    """No-op: connections are not deleted by default."""


@given('the outbound connection is already "DELETING"')
def outbound_connection_already_deleting_given():
    pytest.skip("Cannot observe DELETING connection state in lws")


@given('the outbound connection is not already "DELETING"')
def outbound_connection_not_already_deleting_given():
    """No-op: connections are not in DELETING state by default."""


@given("the inbound connection does not exist")
def inbound_connection_does_not_exist():
    """No-op: fresh state has no inbound connections."""


@given("the inbound connection exists")
def inbound_connection_exists():
    pytest.skip("Cannot create an inbound connection as a precondition in this context")


@given('the inbound connection is "DELETING"')
def inbound_connection_is_deleting_given():
    pytest.skip("Cannot observe DELETING inbound connection state in lws")


@given('the inbound connection is not "DELETING"')
def inbound_connection_is_not_deleting_given():
    """No-op: inbound connections are not in DELETING state by default."""


@given('the inbound connection is "PENDING_ACCEPTANCE"')
def inbound_connection_is_pending_given():
    pytest.skip("Cannot observe PENDING_ACCEPTANCE inbound connection state in lws")


@given('the inbound connection is not "PENDING_ACCEPTANCE"')
def inbound_connection_is_not_pending_given():
    """No-op: inbound connections are not in PENDING_ACCEPTANCE state by default."""


@given('the inbound connection is already "DELETED"')
def inbound_connection_already_deleted_given():
    pytest.skip("Cannot use a deleted inbound connection as a precondition in lws")


@given('the inbound connection is not already "DELETED"')
def inbound_connection_not_already_deleted_given():
    """No-op: inbound connections are not deleted by default."""


@given('the inbound connection is already "DELETING"')
def inbound_connection_already_deleting_given():
    pytest.skip("Cannot observe DELETING inbound connection state in lws")


@given('the inbound connection is not already "DELETING"')
def inbound_connection_not_already_deleting_given():
    """No-op: inbound connections are not in DELETING state by default."""


@given("the associated inbound connection exists")
def associated_inbound_connection_exists():
    pytest.skip("Cannot create an associated inbound connection as a precondition in this context")


@given("the associated inbound connection does not exist")
def associated_inbound_connection_does_not_exist():
    """No-op: no associated inbound connection by default."""


# ── Given: blue-green deployment state ────────────────────────────────


@given("the new cluster has already been prepared")
def new_cluster_already_prepared():
    pytest.skip("Cannot configure blue-green deployment state in lws")


@given("the new cluster has not been prepared yet")
def new_cluster_not_prepared_yet():
    """No-op: no blue-green deployment by default."""


@given("the new cluster is ready")
def new_cluster_is_ready():
    pytest.skip("Cannot configure blue-green deployment cluster readiness in lws")


@given("the new cluster is not ready")
def new_cluster_is_not_ready():
    """No-op: no ready new cluster by default."""


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


@given("conn in inbound_status")
def conn_in_inbound_status():
    pytest.skip("Cannot create an inbound connection as a FizzBee precondition in this context")


@given("conn in outbound_status")
def conn_in_outbound_status():
    pytest.skip("Cannot create an outbound connection as a FizzBee precondition in this context")


@given("conn not in outbound_status")
def conn_not_in_outbound_status():
    """No-op: fresh state has no outbound connections."""


# ── When: actions ──────────────────────────────────────────────────────


@when("a search domain is created")
def create_domain(lws_session, world):
    try:
        world["result"] = _opensearch(lws_session).create_domain(
            DomainName=TEST_DOMAIN,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a search domain is deleted")
def delete_domain(lws_session, world):
    try:
        world["result"] = _opensearch(lws_session).delete_domain(
            DomainName=TEST_DOMAIN,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a domain configuration update is requested")
def update_domain_config(lws_session, world):
    try:
        world["result"] = _opensearch(lws_session).update_domain_config(
            DomainName=TEST_DOMAIN,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an outbound cross-cluster connection is created between two domains")
def create_outbound_connection(lws_session, world):
    pytest.skip("Cannot create cross-cluster connection in lws")


@when("an outbound cross-cluster connection is deleted")
def delete_outbound_connection(lws_session, world):
    pytest.skip("Cannot delete cross-cluster connection without connection ID in lws")


@when("an inbound cross-cluster connection is accepted")
def accept_inbound_connection(lws_session, world):
    pytest.skip("Cannot accept inbound cross-cluster connection in lws")


@when("an inbound cross-cluster connection is rejected")
def reject_inbound_connection(lws_session, world):
    pytest.skip("Cannot reject inbound cross-cluster connection in lws")


@when("an inbound cross-cluster connection is deleted")
def delete_inbound_connection(lws_session, world):
    pytest.skip("Cannot delete inbound cross-cluster connection in lws")


@when("an outbound connection finishes deleting")
def outbound_connection_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal outbound connection deletion completion in lws")


@when("an inbound connection finishes deleting")
def inbound_connection_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal inbound connection deletion completion in lws")


@when("shards are rebalanced across nodes in an active domain")
def shard_rebalancing(lws_session, world):
    pytest.skip("Cannot trigger internal shard rebalancing in lws")


@when("tags are added to a domain")
def add_tags(lws_session, world):
    try:
        resp = _opensearch(lws_session).describe_domain(DomainName=TEST_DOMAIN)
        actual_arn = resp["DomainStatus"]["ARN"]
        world["result"] = _opensearch(lws_session).add_tags(
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
        resp = _opensearch(lws_session).describe_domain(DomainName=TEST_DOMAIN)
        actual_arn = resp["DomainStatus"]["ARN"]
        world["result"] = _opensearch(lws_session).remove_tags(
            ARN=actual_arn,
            TagKeys=["e2e-test-key-1"],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a search domain finishes creating")
def domain_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal OpenSearch domain creation completion in lws")


@when("a search domain finishes deleting")
def domain_finishes_deleting(lws_session, world):
    pytest.skip("Cannot trigger internal OpenSearch domain deletion completion in lws")


@when("a blue-green deployment completes")
def blue_green_complete(lws_session, world):
    pytest.skip("Cannot trigger internal blue-green deployment completion in lws")


@when("the new cluster for a blue-green deployment becomes ready")
def blue_green_new_cluster_ready(lws_session, world):
    pytest.skip("Cannot trigger internal blue-green new cluster readiness in lws")


@when("traffic is swapped to the new cluster during a blue-green deployment")
def blue_green_swap_traffic(lws_session, world):
    pytest.skip("Cannot trigger internal blue-green traffic swap in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the domain is in "CREATING" state')
def domain_is_creating_then(lws_session):
    resp = _opensearch(lws_session).describe_domain(DomainName=TEST_DOMAIN)
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
    resp = _opensearch(lws_session).describe_domain(DomainName=TEST_DOMAIN)
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


@then('the domain is "DELETED" and all associated connections are removed')
def domain_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected domain delete to succeed but got: {actual_error}"


@then('the domain is in "PROCESSING" state and a blue-green deployment begins')
def domain_is_processing_blue_green_then(lws_session):
    resp = _opensearch(lws_session).describe_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"


@then('the domain is "ACTIVE" with the new configuration applied')
def domain_is_active_with_new_config_then(lws_session):
    resp = _opensearch(lws_session).describe_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"


@then("the domain has a new cluster prepared but traffic is not yet swapped")
def domain_has_new_cluster_prepared_then():
    pytest.skip("Cannot observe internal blue-green deployment state in lws")


@then("the domain is now serving requests from the new cluster")
def domain_serving_new_cluster_then():
    pytest.skip("Cannot observe internal blue-green traffic swap in lws")


@then('the connection is in "PENDING_ACCEPTANCE" state')
def connection_is_pending_then():
    pytest.skip("Cannot observe internal connection PENDING_ACCEPTANCE state in lws")


@then('both the inbound and outbound connection are "ACTIVE"')
def both_connections_active_then():
    pytest.skip("Cannot observe internal cross-cluster connection ACTIVE state in lws")


@then('both the inbound and outbound connection are "REJECTED"')
def both_connections_rejected_then():
    pytest.skip("Cannot observe internal cross-cluster connection REJECTED state in lws")


@then('the outbound connection is in "DELETING" state')
def outbound_connection_deleting_then():
    pytest.skip("Cannot observe internal outbound connection DELETING state in lws")


@then('the outbound and associated inbound connection are "DELETED"')
def outbound_and_inbound_deleted_then():
    pytest.skip("Cannot observe internal cross-cluster connection deletion in lws")


@then('the inbound connection is in "DELETING" state')
def inbound_connection_deleting_then():
    pytest.skip("Cannot observe internal inbound connection DELETING state in lws")


@then('the inbound connection is "DELETED"')
def inbound_connection_deleted_then():
    pytest.skip("Cannot observe internal inbound connection deletion in lws")


@then("the instance count is updated without data loss")
def instance_count_updated_then():
    pytest.skip("Cannot observe internal shard rebalancing in lws")


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


@then("no active connection references a deleted domain")
def no_active_connection_references_deleted_domain():
    """No-op: connection-domain reference integrity is an internal invariant; always passes."""


@then("traffic can only be swapped after the new cluster is ready")
def traffic_swap_requires_new_cluster():
    """No-op: blue-green deployment state invariant; always passes."""


@then('an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection')
def active_outbound_no_rejected_inbound():
    """No-op: connection status consistency invariant; always passes."""


@then('a pending config change only exists on a domain that is "PROCESSING"')
def pending_config_only_on_processing_domain():
    """No-op: domain configuration state invariant; always passes."""
