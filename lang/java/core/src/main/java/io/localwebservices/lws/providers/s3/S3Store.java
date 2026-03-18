package io.localwebservices.lws.providers.s3;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory S3 state storage. */
public class S3Store {

  public final Map<String, Map<String, Object>> buckets = new ConcurrentHashMap<>();
  public final Map<String, Map<String, byte[]>> objects = new ConcurrentHashMap<>();
  public final Map<String, Map<String, String>> objectMetadata = new ConcurrentHashMap<>();
  public final Map<String, Map<String, String>> bucketTags = new ConcurrentHashMap<>();
  public final Map<String, String> bucketPolicies = new ConcurrentHashMap<>();
  public final Map<String, Map<String, String>> bucketWebsites = new ConcurrentHashMap<>();
  public final Map<String, Map<String, Object>> multipartUploads = new ConcurrentHashMap<>();
  public final Map<String, Map<Integer, byte[]>> multipartParts = new ConcurrentHashMap<>();

  public void reset() {
    buckets.clear();
    objects.clear();
    objectMetadata.clear();
    bucketTags.clear();
    bucketPolicies.clear();
    bucketWebsites.clear();
    multipartUploads.clear();
    multipartParts.clear();
  }
}
