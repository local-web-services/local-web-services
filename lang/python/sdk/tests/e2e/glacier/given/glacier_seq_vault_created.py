"""Given: a vault has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient


@given("a vault has been created")
def glacier_seq_vault_created(lws_session):
    GlacierTestClient(lws_session).create_vault()
