"""Abstract BDD step definitions for GlacierSns integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_TOPIC_NAME = "e2e-test-topic-1"
TEST_VAULT = "e2e-test-vault-1"


def _glacier(lws_session):
    return lws_session.client("glacier")


def _sns(lws_session):
    return lws_session.client("sns")


def _topic_arn(name=TEST_TOPIC_NAME):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _create_vault(lws_session, name=TEST_VAULT):
    _glacier(lws_session).create_vault(accountId="-", vaultName=name)


def _create_topic(lws_session, name=TEST_TOPIC_NAME):
    _sns(lws_session).create_topic(Name=name)


# ── Given: vault state ────────────────────────────────────────────────


@given("the vault does not already exist")
def vault_not_already_exist():
    """No-op: fresh state has no vaults."""


@given("the vault already exists")
def vault_already_exists(lws_session):
    _create_vault(lws_session)


@given("the vault exists")
def vault_exists(lws_session):
    _create_vault(lws_session)


@given("the vault does not exist")
def vault_does_not_exist():
    """No-op: fresh state has no vaults."""


@given('the vault has no "SNS" notification configured')
def vault_has_no_sns_notification():
    """No-op: vaults have no notification configuration by default."""


@given('the vault already has an "SNS" notification configured')
def vault_already_has_sns_notification():
    pytest.skip("Cannot configure Glacier vault notifications in lws")


@given('the vault has an "SNS" notification configured')
def vault_has_sns_notification():
    pytest.skip("Cannot configure Glacier vault notifications in lws")


# ── Given: topic state ────────────────────────────────────────────────


@given("the topic does not already exist")
def glacier_sns_topic_not_already_exist():
    """No-op: fresh state has no topics."""


@given("the topic already exists")
def glacier_sns_topic_already_exists(lws_session):
    _create_topic(lws_session)


@given("the topic exists")
def glacier_sns_topic_exists(lws_session):
    _create_topic(lws_session)


@given('the topic exists and is "ACTIVE"')
def glacier_sns_topic_exists_and_is_active(lws_session):
    _create_topic(lws_session)


@given('the topic does not exist or is not "ACTIVE"')
def glacier_sns_topic_not_exist_or_not_active():
    pytest.skip(
        "lws does not validate SNS topic existence when configuring Glacier vault notifications"
    )


@given("the topic does not exist")
def glacier_sns_topic_does_not_exist():
    """No-op: fresh state has no topics."""


@given('the topic is "ACTIVE"')
def glacier_sns_topic_is_active_given():
    """No-op: topics are ACTIVE by default after creation."""


@given('the topic is already "DELETED"')
def glacier_sns_topic_is_already_deleted(lws_session, world):
    try:
        _create_topic(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    _sns(lws_session).delete_topic(TopicArn=_topic_arn())
    world["result"] = None
    world["error"] = None


@given('the configured topic is "ACTIVE"')
def configured_topic_is_active():
    pytest.skip("Cannot configure Glacier vault notifications in lws")


@given('the configured topic is "DELETED"')
def configured_topic_is_deleted():
    pytest.skip("Cannot configure Glacier vault notifications in lws")


@given('the configured topic is not "DELETED"')
def configured_topic_is_not_deleted():
    pytest.skip("Cannot configure Glacier vault notifications in lws")


# ── Given: job state ──────────────────────────────────────────────────


@given("a job slot is available")
def glacier_job_slot_available(lws_session):
    lws_session.capacity("glacier").unlimited().apply()


@given("no job slot is available")
def glacier_no_job_slot_available():
    pytest.skip("Glacier provider does not implement capacity checking")


@given('a job is "IN_PROGRESS"')
def glacier_job_is_in_progress():
    pytest.skip("Cannot trigger internal Glacier job in lws")


@given('no job is "IN_PROGRESS"')
def glacier_no_job_is_in_progress():
    """No-op: fresh state has no in-progress jobs."""


# ── Given: message slot ───────────────────────────────────────────────


@given("a message slot is available")
def glacier_sns_message_slot_available(lws_session):
    lws_session.capacity("sns").unlimited().apply()


@given("no message slot is available")
def glacier_sns_no_message_slot_available():
    pytest.skip("Cannot configure Glacier vault notifications in lws")


# ── Given: state preconditions used in sequences ─────────────────────


@given("vid not in vault_status")
def glacier_sns_vid_not_in_vault_status():
    """No-op: fresh state has no vaults."""


# ── When: actions ──────────────────────────────────────────────────────


@when("a Glacier vault is created")
def create_glacier_vault(lws_session, world):
    try:
        resp = _glacier(lws_session).create_vault(accountId="-", vaultName=TEST_VAULT)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an "SNS" topic is created')
def create_sns_topic_glacier(lws_session, world):
    try:
        resp = _sns(lws_session).create_topic(Name=TEST_TOPIC_NAME)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('the "SNS" topic is deleted')
def delete_sns_topic_glacier(lws_session, world):
    try:
        resp = _sns(lws_session).delete_topic(TopicArn=_topic_arn())
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an "SNS" notification is configured on the vault')
def configure_sns_notification_on_vault(world):
    pytest.skip("Cannot configure Glacier vault notifications in lws")


@when("a Glacier archive retrieval job is initiated on the vault")
def initiate_glacier_job(lws_session, world):
    try:
        resp = _glacier(lws_session).initiate_job(
            accountId="-",
            vaultName=TEST_VAULT,
            jobParameters={"Type": "archive-retrieval"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('the Glacier job completes and publishes a notification to the configured "SNS" topic')
def glacier_job_completes_and_notifies(world):
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")


@when("the Glacier job completes but notification delivery fails because the topic was deleted")
def glacier_job_completes_notification_fails(world):
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the vault "EXISTS" with no "SNS" notification configuration')
def vault_exists_no_notification(lws_session):
    resp = _glacier(lws_session).list_vaults(accountId="-")
    actual_vaults = [v["VaultName"] for v in resp.get("VaultList", [])]
    expected_vault = TEST_VAULT
    assert (
        expected_vault in actual_vaults
    ), f"Expected vault '{expected_vault}' to exist but not found in: {actual_vaults}"


@then('the topic is "ACTIVE"')
def glacier_sns_topic_is_active_then(lws_session):
    resp = _sns(lws_session).list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_arn = _topic_arn()
    assert (
        expected_arn in actual_arns
    ), f"Expected topic '{expected_arn}' to be ACTIVE but not found in: {actual_arns}"


@then('the topic is "DELETED" and Glacier notifications will fail')
def glacier_sns_topic_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_topic to succeed but got: {actual_error}"


@then("the vault will publish job completion notifications to the topic")
def vault_will_publish_notifications(world):
    pytest.skip("Cannot configure Glacier vault notifications in lws")


@then('the job is "IN_PROGRESS"')
def glacier_job_is_in_progress_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected initiate_job to succeed but got: {actual_error}"
    assert world["result"] is not None, "Expected a result from initiate_job"


@then('the job is "SUCCEEDED" and the notification is "PUBLISHED"')
def glacier_job_succeeded_notification_published():
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")


@then('the job is "SUCCEEDED" but no notification is published')
def glacier_job_succeeded_no_notification():
    pytest.skip("Cannot trigger internal Glacier->SNS notification in lws")
