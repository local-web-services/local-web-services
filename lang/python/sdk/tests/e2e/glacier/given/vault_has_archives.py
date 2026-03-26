"""Given: the vault has archives"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient


@given("the vault has archives")
def vault_has_archives(lws_session):
    GlacierTestClient(lws_session).upload_archive()
