"""Given: the rule is "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE


@given('the rule is "DELETED"')
def rule_is_deleted_given(lws_session):
    """Delete the rule so it is in DELETED state."""
    EventsTestClient(lws_session).delete_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
