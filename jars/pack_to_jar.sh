javac -cp "org.eclipse.paho.client.mqttv3-1.2.0.jar" ../src/iMqttClient.java
jar cvf iMqttClient.jar ../src/iMqttClient.class
rm ../src/iMqttClient.class
