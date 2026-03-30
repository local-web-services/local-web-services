"""Given: the secret is "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET


@given('the secret is "DELETED"')
def secret_is_deleted_given(lws_session):
    SecretsmanagerTestClient(lws_session).delete_secret(SecretId=TEST_SECRET)
