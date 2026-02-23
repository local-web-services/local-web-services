"""Unit tests for empty spec import."""

from __future__ import annotations

from lws.providers.mockserver.openapi_import import import_openapi_spec


class TestEmptySpec:
    def test_empty_spec(self, tmp_path):
        # Arrange
        spec = tmp_path / "spec.yaml"
        spec.write_text("")
        output_dir = tmp_path / "mock-api"
        output_dir.mkdir()

        # Act
        generated = import_openapi_spec(spec, output_dir)

        # Assert
        assert len(generated) == 0
