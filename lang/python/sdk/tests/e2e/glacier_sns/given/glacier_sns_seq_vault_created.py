"""Given: a "glacier" "vault" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given('a "glacier" "vault" is created')
def glacier_sns_seq_vault_created(lws_session):
    GlacierSnsTestClient(lws_session).create_vault()
