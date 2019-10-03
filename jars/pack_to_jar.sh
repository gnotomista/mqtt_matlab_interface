javac -source $1 -target $1 -cp 'org.eclipse.paho.client.mqttv3-1.2.2.jar' ../src/iMqttClient.java
mv ../src/iMqttClient.class .
jar cvf iMqttClient.jar iMqttClient.class
rm iMqttClient.class
