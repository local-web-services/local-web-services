"""Given: tags have been added to an active secret"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET, TEST_TAG_KEY, TEST_TAG_VALUE


@given("tags have been added to an active secret")
def secretsmanager_tags_have_been_added(lws_session):
    try:
        SecretsmanagerTestClient(lws_session).create_secret()
    except Exception:
        pass
    SecretsmanagerTestClient(lws_session).tag_resource(
        SecretId=TEST_SECRET, Tags=[{"Key": TEST_TAG_KEY, "Value": TEST_TAG_VALUE}]
    )
