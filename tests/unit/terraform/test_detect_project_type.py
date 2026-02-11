"""Tests for lws.terraform.detect -- project type detection."""

from __future__ import annotations

from pathlib import Path

from lws.terraform.detect import detect_project_type


class TestDetectProjectType:
    """Tests for the detect_project_type function."""

    def test_cdk_project(self, tmp_path: Path) -> None:
        """Detect CDK project when cdk.out directory exists."""
        # Arrange
        expected_type = "cdk"
        cdk_out_dir = tmp_path / "cdk.out"
        cdk_out_dir.mkdir()

        # Act
        actual_type = detect_project_type(tmp_path)

        # Assert
        assert actual_type == expected_type

    def test_terraform_project(self, tmp_path: Path) -> None:
        """Detect Terraform project when .tf files exist."""
        # Arrange
        expected_type = "terraform"
        tf_file = tmp_path / "main.tf"
        tf_file.write_text("# Terraform configuration")

        # Act
        actual_type = detect_project_type(tmp_path)

        # Assert
        assert actual_type == expected_type

    def test_ambiguous_project(self, tmp_path: Path) -> None:
        """Detect ambiguous project when both cdk.out and .tf files exist."""
        # Arrange
        expected_type = "ambiguous"
        cdk_out_dir = tmp_path / "cdk.out"
        cdk_out_dir.mkdir()
        tf_file = tmp_path / "main.tf"
        tf_file.write_text("# Terraform configuration")

        # Act
        actual_type = detect_project_type(tmp_path)

        # Assert
        assert actual_type == expected_type

    def test_no_project(self, tmp_path: Path) -> None:
        """Detect no project when directory is empty."""
        # Arrange
        expected_type = "none"

        # Act
        actual_type = detect_project_type(tmp_path)

        # Assert
        assert actual_type == expected_type
