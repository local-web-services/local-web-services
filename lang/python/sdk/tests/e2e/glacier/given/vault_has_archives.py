"""Given: the "glacier" "vault" had archives"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient


@given('the "glacier" "vault" had archives')
def vault_has_archives(lws_session):
    GlacierTestClient(lws_session).upload_archive()
