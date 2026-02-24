"""Unit tests for load_fake_server in DSL parser."""

from __future__ import annotations

import pytest

from lws.providers.fakeserver.dsl import load_fake_server


class TestLoadFakeServer:
    def test_full_load(self, tmp_path):
        # Arrange
        fake_dir = tmp_path / "payment-api"
        fake_dir.mkdir()
        (fake_dir / "config.yaml").write_text(
            "name: payment-api\n" "protocol: rest\n" "port: 3100\n"
        )
        routes_dir = fake_dir / "routes"
        routes_dir.mkdir()
        (routes_dir / "payments.yaml").write_text(
            "routes:\n"
            "  - path: /v1/payments\n"
            "    method: POST\n"
            "    responses:\n"
            "      - match: {}\n"
            "        status: 201\n"
            "        body:\n"
            "          id: pay_new\n"
        )

        # Act
        config = load_fake_server(fake_dir)

        # Assert
        expected_name = "payment-api"
        actual_name = config.name
        assert actual_name == expected_name
        assert len(config.routes) == 1
        expected_port = 3100
        actual_port = config.port
        assert actual_port == expected_port

    def test_missing_config_raises(self, tmp_path):
        # Arrange
        fake_dir = tmp_path / "missing"
        fake_dir.mkdir()

        # Act
        # Assert
        with pytest.raises(FileNotFoundError):
            load_fake_server(fake_dir)
