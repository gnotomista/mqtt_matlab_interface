import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import java.util.Map;
import java.util.HashMap;
import java.time.Instant;

public class iMqttClient implements MqttCallback {

  private MqttClient client;
  Map<String, String> mqttMessage = new HashMap<String, String>();
  Map<String, long[]> unixTime = new HashMap<String, long[]>();
  
  // constructor
  public iMqttClient(String clientId, String ip, String port, int maxInflight) throws MqttException {
    MqttConnectOptions conOpt = new MqttConnectOptions();
    conOpt.setCleanSession(true);
  	conOpt.setMaxInflight(maxInflight);

    this.client = new MqttClient(String.format("tcp://%s:%s", ip, port), clientId, new MemoryPersistence());
    this.client.setCallback(this);
    this.client.connect(conOpt);
  }

  // constructor: overload with maxInflight=1000
  public iMqttClient(String clientId, String ip, String port) throws MqttException {
    MqttConnectOptions conOpt = new MqttConnectOptions();
    conOpt.setCleanSession(true);
  	conOpt.setMaxInflight(1000);

    this.client = new MqttClient(String.format("tcp://%s:%s", ip, port), clientId, new MemoryPersistence());
    this.client.setCallback(this);
    this.client.connect(conOpt);
  }

  // add subscriber
  public void subscribe(String topic, int qos) throws MqttException {
    mqttMessage.put(topic, "");
    this.client.subscribe(topic, qos);
  }

  // add subscriber: overload with qos=0
  public void subscribe(String topic) throws MqttException {
    mqttMessage.put(topic, "");
    this.client.subscribe(topic, 0);
  }

  // send message
  public void sendMessage(String topic, String payload, int qos) throws MqttException {
    MqttMessage message = new MqttMessage(payload.getBytes());
    message.setQos(qos);
    this.client.publish(topic, message);
  }

  // send message: overload with qos=0
  public void sendMessage(String topic, String payload) throws MqttException {
    MqttMessage message = new MqttMessage(payload.getBytes());
    message.setQos(0);
    this.client.publish(topic, message);
  }

  // get message
  public String getMessage(String topic) throws MqttException {
    return this.mqttMessage.get(topic);
  }

  // connection lost
  public void connectionLost(Throwable cause) {
    //System.out.println("Connection lost. " + cause);
  }

  // delivery complete
  public void deliveryComplete(IMqttDeliveryToken token) {
  }

  // message arrived
  public void messageArrived(String topic, MqttMessage message) throws MqttException {
    this.mqttMessage.put(topic, new String(message.getPayload()));
    this.unixTime.put(topic, new long[] {Instant.now().getEpochSecond(), Instant.now().getNano()});
  }
  
  public long[] getMessageArrivalTime(String topic) {
      return this.unixTime.get(topic);   
  }

  // shutdown
  public void shutdown() {
    try {
      this.client.disconnect();
    } catch (MqttException e) {
      System.out.println(String.format("%s", e));
    }
  }

}
