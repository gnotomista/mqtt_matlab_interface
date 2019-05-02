cd ../src
javac -cp "../jars/org.eclipse.paho.client.mqttv3-1.2.0.jar" iMqttClient.java
jar cvf ../jars/iMqttClient.jar iMqttClient.class
rm iMqttClient.class
cd ../jars
