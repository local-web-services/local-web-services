"""Tests for EventBridge provider management operations."""

from __future__ import annotations

import pytest

from lws.providers.eventbridge.provider import EventBridgeProvider


@pytest.fixture()
async def provider() -> EventBridgeProvider:
    p = EventBridgeProvider()
    await p.start()
    yield p
    await p.stop()


class TestDeleteRule:
    async def test_delete_existing_rule(self, provider: EventBridgeProvider) -> None:
        await provider.put_rule("my-rule", event_pattern={"source": ["test"]})
        await provider.delete_rule("my-rule")
        rules = provider.list_rules()
        rule_names = [r.rule_name for r in rules]
        assert "my-rule" not in rule_names

    async def test_delete_nonexistent_rule_raises(self, provider: EventBridgeProvider) -> None:
        with pytest.raises(KeyError, match="Rule not found"):
            await provider.delete_rule("nonexistent")
