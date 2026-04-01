"""Given: a "documentdb" "instance" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_INSTANCE


@given('a "documentdb" "instance" deletion completes')
def docdb_instance_deletion_completed(lws_session):
    lws_session.inject_state("docdb", "instance", TEST_INSTANCE, "deleted")
