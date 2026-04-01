"""Given: an "ACL" has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient
from ..constants import TEST_ACL


@given('an "ACL" has been deleted')
def memorydb_acl_deleted_seq(lws_session):
    try:
        MemorydbTestClient(lws_session).create_acl()
    except Exception:
        pass
    MemorydbTestClient(lws_session).delete_acl(ACLName=TEST_ACL)
