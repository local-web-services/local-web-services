"""Given: vid in vault_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaGlacierTestClient


@given("vid in vault_status")
def vid_in_vault_status(lws_session):
    LambdaGlacierTestClient(lws_session).create_vault()
