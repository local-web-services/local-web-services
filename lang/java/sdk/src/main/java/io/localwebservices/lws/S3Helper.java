package io.localwebservices.lws;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.HeadObjectRequest;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Response;
import software.amazon.awssdk.services.s3.model.NoSuchKeyException;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Object;

/**
 * Wraps a single S3 bucket for easy test object operations.
 *
 * <p>Obtain one via {@link LwsSession#s3(String)}:
 *
 * <pre>{@code
 * S3Helper bucket = session.s3("my-bucket");
 * bucket.put("key", "hello".getBytes());
 * bucket.assertObjectExists("key");
 * bucket.assertObjectCount(1, "");
 * }</pre>
 */
public class S3Helper {

  private final String bucket;
  private final S3Client client;

  S3Helper(String bucket, S3Client client) {
    this.bucket = bucket;
    this.client = client;
  }

  /** Uploads a byte array as an object to the bucket. */
  public void put(String key, byte[] body) {
    client.putObject(
        PutObjectRequest.builder().bucket(bucket).key(key).build(), RequestBody.fromBytes(body));
  }

  /** Downloads an object and returns its contents as a byte array. */
  public byte[] get(String key) {
    return client
        .getObjectAsBytes(GetObjectRequest.builder().bucket(bucket).key(key).build())
        .asByteArray();
  }

  /** Downloads an object and returns its contents as a UTF-8 string. */
  public String getText(String key) {
    return new String(get(key), StandardCharsets.UTF_8);
  }

  /** Removes an object from the bucket. */
  public void delete(String key) {
    client.deleteObject(DeleteObjectRequest.builder().bucket(bucket).key(key).build());
  }

  /**
   * Returns the keys of all objects in the bucket with the given prefix. Use an empty string to
   * list all objects.
   */
  public List<String> listKeys(String prefix) {
    ListObjectsV2Response response =
        client.listObjectsV2(ListObjectsV2Request.builder().bucket(bucket).prefix(prefix).build());
    return response.contents().stream().map(S3Object::key).collect(Collectors.toList());
  }

  /** Throws {@link AssertionError} if the given key does not exist in the bucket. */
  public void assertObjectExists(String key) {
    try {
      client.headObject(HeadObjectRequest.builder().bucket(bucket).key(key).build());
    } catch (NoSuchKeyException e) {
      throw new AssertionError(
          "S3Helper.assertObjectExists: key '" + key + "' not found in bucket '" + bucket + "'");
    }
  }

  /**
   * Throws {@link AssertionError} if the number of objects with the given prefix differs from
   * {@code expected}.
   */
  public void assertObjectCount(int expected, String prefix) {
    List<String> keys = listKeys(prefix);
    int actual = keys.size();
    if (actual != expected) {
      throw new AssertionError(
          "S3Helper.assertObjectCount: got "
              + actual
              + " objects, want "
              + expected
              + " (bucket: "
              + bucket
              + ", prefix: '"
              + prefix
              + "')");
    }
  }
}
