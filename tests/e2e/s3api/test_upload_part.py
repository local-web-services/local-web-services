"""E2E test for S3 upload-part CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestUploadPart:
    def test_upload_part(self, e2e_port, tmp_path, lws_invoke, parse_output):
        # Arrange
        bucket = "e2e-upload-part"
        key = "e2e-part.bin"
        part_content = b"part-data"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket, "--port", str(e2e_port)])
        create_body = lws_invoke(
            [
                "s3api",
                "create-multipart-upload",
                "--bucket",
                bucket,
                "--key",
                key,
                "--port",
                str(e2e_port),
            ]
        )
        upload_id = create_body["InitiateMultipartUploadResult"]["UploadId"]
        part_file = tmp_path / "part.bin"
        part_file.write_bytes(part_content)

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "upload-part",
                "--bucket",
                bucket,
                "--key",
                key,
                "--upload-id",
                upload_id,
                "--part-number",
                "1",
                "--body",
                str(part_file),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = parse_output(result.output)
        assert "ETag" in body
