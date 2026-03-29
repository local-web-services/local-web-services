"""Given: an archive has been uploaded to a vault"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient


@given("an archive has been uploaded to a vault")
def glacier_seq_archive_uploaded(lws_session):
    GlacierTestClient(lws_session).create_vault()
    GlacierTestClient(lws_session).upload_archive()
