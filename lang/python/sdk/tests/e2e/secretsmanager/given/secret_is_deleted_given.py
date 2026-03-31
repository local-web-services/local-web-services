"""Given: the "secrets manager" "secret" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET


@given('the "secrets manager" "secret" was "DELETED"')
def secret_is_deleted_given(lws_session):
    SecretsmanagerTestClient(lws_session).delete_secret(SecretId=TEST_SECRET)
