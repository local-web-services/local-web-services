"""Given: vid in vault_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given("vid in vault_status")
def glacier_sns_vid_in_vault_status(lws_session):
    GlacierSnsTestClient(lws_session).create_vault()
