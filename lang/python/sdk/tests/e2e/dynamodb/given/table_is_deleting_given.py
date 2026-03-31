"""Given: the "dynamodb" "table" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" was "DELETING"')
def table_is_deleting_given(lws_session):
    """Enable lifecycle delete dwell so the next DeleteTable call returns DELETING."""
    lws_session.lifecycle("dynamodb").delete_dwell_ms(5000).apply()
