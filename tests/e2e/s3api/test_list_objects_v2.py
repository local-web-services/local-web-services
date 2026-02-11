import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListObjectsV2:
    def test_list_objects_v2(self, e2e_port, tmp_path, lws_invoke):
        # Arrange
        bucket_name = "e2e-listobj"
        key = "l.txt"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])
        body_file = tmp_path / "l.txt"
        body_file.write_text("x")
        lws_invoke(
            [
                "s3api",
                "put-object",
                "--bucket",
                bucket_name,
                "--key",
                key,
                "--body",
                str(body_file),
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "list-objects-v2",
                "--bucket",
                bucket_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
        contents = data["ListBucketResult"].get("Contents", [])
        if isinstance(contents, dict):
            contents = [contents]
        actual_keys = [obj["Key"] for obj in contents]
        assert key in actual_keys
