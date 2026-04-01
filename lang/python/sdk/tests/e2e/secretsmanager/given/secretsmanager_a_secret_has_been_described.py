"""Given: a secret has been described"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET


@given("a secret has been described")
def secretsmanager_a_secret_has_been_described(lws_session):
    SecretsmanagerTestClient(lws_session).describe_secret(SecretId=TEST_SECRET)
