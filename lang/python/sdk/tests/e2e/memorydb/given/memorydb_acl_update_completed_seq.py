"""Given: an "memorydb" "ACL" update completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_ACL


@given('an "memorydb" "ACL" update completes')
def memorydb_acl_update_completed_seq(lws_session):
    lws_session.inject_state("memorydb", "acl", TEST_ACL, "available")
