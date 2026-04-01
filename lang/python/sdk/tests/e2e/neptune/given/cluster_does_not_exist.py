"""Given: the "neptune" "cluster" did not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER, TEST_INSTANCE


@given('the "neptune" "cluster" did not exist')
def cluster_does_not_exist(lws_session):
    """Delete the cluster if it exists so any instance cluster reference is orphaned."""
    # Advance instance out of CREATING state so instance delete guard passes
    try:
        lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "available")
    except Exception:  # noqa: BLE001
        pass
    # Delete instance from state so cluster deletion is not blocked
    try:
        lws_session.client("neptune").delete_db_instance(DBInstanceIdentifier=TEST_INSTANCE)
    except Exception:  # noqa: BLE001
        pass
    # Remove instance from tracker (handles DELETING state after above delete)
    try:
        lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "deleted")
    except Exception:  # noqa: BLE001
        pass
    # Delete the cluster
    try:
        lws_session.client("neptune").delete_db_cluster(DBClusterIdentifier=TEST_CLUSTER)
    except Exception:  # noqa: BLE001
        pass
