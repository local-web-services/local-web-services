"""Given: a "documentdb" "instance" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_INSTANCE


@given('a "documentdb" "instance" finishes creating')
def docdb_instance_has_finished_creating(lws_session):
    lws_session.inject_state("docdb", "instance", TEST_INSTANCE, "available")
