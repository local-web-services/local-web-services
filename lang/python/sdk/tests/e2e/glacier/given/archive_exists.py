"""Given: the archive exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient


@given("the archive exists")
def archive_exists(lws_session):
    GlacierTestClient(lws_session).upload_archive()
