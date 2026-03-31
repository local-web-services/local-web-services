"""Given: a "neptune" "instance" reboot completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_INSTANCE


@given('a "neptune" "instance" reboot completes')
def neptune_database_instance_reboot_completed_seq(lws_session):
    # Arrange / Act
    lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "available")
    # Assert
    pass
