javac -cp "../jars/org.eclipse.paho.client.mqttv3-1.2.0.jar" Subscriber.java 
jar cvf ../jars/Subscriber.jar *.class
rm Subscriber.class
