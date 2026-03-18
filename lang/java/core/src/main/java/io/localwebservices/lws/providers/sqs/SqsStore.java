package io.localwebservices.lws.providers.sqs;

import java.security.MessageDigest;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory SQS storage. */
public class SqsStore {

  public static class SqsMessage {
    public final String messageId;
    public final String receiptHandle;
    public final String body;
    public final Map<String, String> attributes;
    public long visibleAt; // epoch ms when visible

    public SqsMessage(
        String messageId, String receiptHandle, String body, Map<String, String> attrs) {
      this.messageId = messageId;
      this.receiptHandle = receiptHandle;
      this.body = body;
      this.attributes = attrs;
      this.visibleAt = System.currentTimeMillis();
    }
  }

  public static class LocalQueue {
    public final String name;
    public final String url;
    public final boolean isFifo;
    public final int visibilityTimeout;
    public final List<SqsMessage> messages = Collections.synchronizedList(new ArrayList<>());

    public LocalQueue(String name, String url, boolean isFifo, int visibilityTimeout) {
      this.name = name;
      this.url = url;
      this.isFifo = isFifo;
      this.visibilityTimeout = visibilityTimeout;
    }

    public String sendMessage(String body, int delaySeconds) {
      String msgId = UUID.randomUUID().toString();
      String receiptHandle = UUID.randomUUID().toString();
      Map<String, String> attrs = new LinkedHashMap<>();
      attrs.put("ApproximateFirstReceiveTimestamp", String.valueOf(System.currentTimeMillis()));
      attrs.put("ApproximateReceiveCount", "0");
      attrs.put("SentTimestamp", String.valueOf(System.currentTimeMillis()));
      SqsMessage msg = new SqsMessage(msgId, receiptHandle, body, attrs);
      msg.visibleAt = System.currentTimeMillis() + (delaySeconds * 1000L);
      messages.add(msg);
      return msgId;
    }

    public List<SqsMessage> receiveMessages(int maxMessages) {
      long now = System.currentTimeMillis();
      List<SqsMessage> result = new ArrayList<>();
      synchronized (messages) {
        for (SqsMessage msg : messages) {
          if (result.size() >= maxMessages) break;
          if (msg.visibleAt <= now) {
            result.add(msg);
            msg.visibleAt = now + (visibilityTimeout * 1000L);
            msg.attributes.put(
                "ApproximateReceiveCount",
                String.valueOf(
                    Integer.parseInt(msg.attributes.getOrDefault("ApproximateReceiveCount", "0"))
                        + 1));
          }
        }
      }
      return result;
    }

    public boolean hasMessage(String receiptHandle) {
      if (receiptHandle == null) return false;
      synchronized (messages) {
        return messages.stream().anyMatch(m -> receiptHandle.equals(m.receiptHandle));
      }
    }

    public void deleteMessage(String receiptHandle) {
      synchronized (messages) {
        messages.removeIf(m -> receiptHandle.equals(m.receiptHandle));
      }
    }

    public void changeVisibility(String receiptHandle, int timeoutSeconds) {
      synchronized (messages) {
        for (SqsMessage msg : messages) {
          if (receiptHandle.equals(msg.receiptHandle)) {
            msg.visibleAt = System.currentTimeMillis() + (timeoutSeconds * 1000L);
            break;
          }
        }
      }
    }

    public void purge() {
      messages.clear();
    }

    public int approximateMessageCount() {
      long now = System.currentTimeMillis();
      synchronized (messages) {
        return (int) messages.stream().filter(m -> m.visibleAt <= now).count();
      }
    }
  }

  private final Map<String, LocalQueue> queues = new ConcurrentHashMap<>();
  private final Map<String, Map<String, String>> queueTags = new ConcurrentHashMap<>();
  private final int port;
  private static final String ACCOUNT_ID = "000000000000";

  public SqsStore(int port) {
    this.port = port;
  }

  public void reset() {
    queues.clear();
    queueTags.clear();
  }

  public String queueUrl(String name) {
    return "http://127.0.0.1:" + port + "/" + ACCOUNT_ID + "/" + name;
  }

  public LocalQueue createQueue(String name, Map<String, String> attributes) {
    boolean isFifo = "true".equals(attributes.get("FifoQueue")) || name.endsWith(".fifo");
    int visTimeout = Integer.parseInt(attributes.getOrDefault("VisibilityTimeout", "30"));
    String url = queueUrl(name);
    LocalQueue queue = new LocalQueue(name, url, isFifo, visTimeout);
    queues.put(name, queue);
    return queue;
  }

  public LocalQueue getQueue(String nameOrUrl) {
    if (nameOrUrl == null) return null;
    if (nameOrUrl.contains("/")) {
      String[] parts = nameOrUrl.split("/");
      String name = parts[parts.length - 1];
      return queues.get(name);
    }
    return queues.get(nameOrUrl);
  }

  public List<LocalQueue> listQueues(String prefix) {
    List<LocalQueue> all = new ArrayList<>(queues.values());
    if (prefix != null && !prefix.isEmpty()) {
      all.removeIf(q -> !q.name.startsWith(prefix));
    }
    return all;
  }

  public void deleteQueue(String nameOrUrl) {
    LocalQueue queue = getQueue(nameOrUrl);
    if (queue != null) queues.remove(queue.name);
  }

  public Map<String, String> getQueueTags(String nameOrUrl) {
    LocalQueue queue = getQueue(nameOrUrl);
    if (queue == null) return Map.of();
    return queueTags.getOrDefault(queue.name, Map.of());
  }

  public void setQueueTags(String nameOrUrl, Map<String, String> tags) {
    LocalQueue queue = getQueue(nameOrUrl);
    if (queue != null) {
      Map<String, String> existing =
          queueTags.computeIfAbsent(queue.name, k -> new LinkedHashMap<>());
      existing.putAll(tags);
    }
  }

  public void removeQueueTags(String nameOrUrl, List<String> tagKeys) {
    LocalQueue queue = getQueue(nameOrUrl);
    if (queue != null) {
      Map<String, String> existing = queueTags.get(queue.name);
      if (existing != null) tagKeys.forEach(existing::remove);
    }
  }

  public static String md5(String text) {
    try {
      MessageDigest md = MessageDigest.getInstance("MD5");
      byte[] bytes = md.digest(text.getBytes(java.nio.charset.StandardCharsets.UTF_8));
      StringBuilder sb = new StringBuilder();
      for (byte b : bytes) sb.append(String.format("%02x", b));
      return sb.toString();
    } catch (Exception e) {
      return "00000000000000000000000000000000";
    }
  }
}
