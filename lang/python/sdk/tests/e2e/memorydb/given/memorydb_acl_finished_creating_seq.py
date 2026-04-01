"""Given: an "memorydb" "ACL" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_ACL


@given('an "memorydb" "ACL" finishes creating')
def memorydb_acl_finished_creating_seq(lws_session):
    lws_session.inject_state("memorydb", "acl", TEST_ACL, "available")
