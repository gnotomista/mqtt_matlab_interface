import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;

public class Subscriber implements MqttCallback {

    private final int qos = 0;
    private String topic = "default";
    private MqttClient client;
    public String mqtt_message = "";

    public Subscriber(String client_id, String ip, String port, String topic_sub) throws MqttException {
        String host = String.format("tcp://%s:%s", ip, port);
        String clientId = client_id;
        
        MqttConnectOptions conOpt = new MqttConnectOptions();
        conOpt.setCleanSession(true);
		conOpt.setMaxInflight(1000);

        this.topic = topic_sub;

        this.client = new MqttClient(host, clientId, new MemoryPersistence());
        this.client.setCallback(this);
        this.client.connect(conOpt);

        this.client.subscribe(this.topic, qos);
    }

    public void connectionLost(Throwable cause) {
        System.out.println("Connection lost: " + cause);
    }

    public void deliveryComplete(IMqttDeliveryToken token) {
    }

    public void messageArrived(String topic, MqttMessage message) throws MqttException {
        this.mqtt_message = new String(message.getPayload());
    }

    public void shutdown() {
        try {
            this.client.disconnect();
        } catch (MqttException e) {
            System.out.println(String.format("%s", e));
        }
    }

}
