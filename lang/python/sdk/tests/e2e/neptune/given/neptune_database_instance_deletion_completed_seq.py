"""Given: a "neptune" "instance" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_INSTANCE


@given('a "neptune" "instance" deletion completes')
def neptune_database_instance_deletion_completed_seq(lws_session):
    lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "deleted")
