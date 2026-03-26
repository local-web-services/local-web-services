"""Given: a Glacier vault has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given("a Glacier vault has been created")
def glacier_sns_seq_vault_created(lws_session):
    GlacierSnsTestClient(lws_session).create_vault()
