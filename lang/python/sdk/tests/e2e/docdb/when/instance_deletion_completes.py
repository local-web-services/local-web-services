"""When: a "documentdb" "instance" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_INSTANCE


@when('a "documentdb" "instance" deletion completes')
def instance_deletion_completes(lws_session, world):
    lws_session.inject_state("docdb", "instance", TEST_INSTANCE, "deleted")
