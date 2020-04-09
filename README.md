# mqtt_matlab_interface
MATLAB interface to MQTT, based on the [Paho Java client](https://www.eclipse.org/paho/clients/java/). Updated versions of the Java client `org.eclipse.paho.client.mqttv3-1.2.2.jar` included in the `jars` directory can be found on [this](https://repo.eclipse.org/content/repositories/paho-releases/org/eclipse/paho/org.eclipse.paho.client.mqttv3/) page.

Bare bones implementation which allows to connect to a MQTT broker (e.g. EMQ X Broker https://www.emqx.io/products/broker), publish and subscribe to multiple topics. The `MqttInterface` matlab class allows for an easy interface to the basic functionalities of MQTT-based message exchange. Besides strings and JSON messages, it is also possible to directly send and receive MATLAB objects.

Minimal test:
1. run a MQTT broker (e.g. in the case of EMQ X Broker: in a terminal, `cd emqx_downloaded_folder/bin` and run `./emqx start`)
2. open MATLAB and run `example.m`
3. if the class `iMqttClient` is not found by MATLAB, follow step 2 below to recompile the Java source.

Extending functionalities:
1. the source file `iMqttClient.java` in the `src` directory can be modified to add the desired functionalities
2. a `iMqttClient.jar` file can be (re)generated as follows:
  * `javac` is required for this to work (on Ubuntu 18.04, for instance, it can be installed through `sudo apt install default-jdk`)
  * run `version -java` in the MATLAB command window to get the version of Java of your MATLAB installation (e.g. *Java 1.8.0...*)
  * in a terminal, cd to the `jars` directory and run `pack_to_jar.sh` passing the MATLAB Java version as argument (e.g. `sh pack_to_jar.sh 1.8`)
  * a file `iMqttClient.jar` should appear in the folder `jars`
3. the updated Java class packed in the `iMqttClient.jar` file in the `jars` folder can be then imported, together with its dependencies `org.eclipse.paho.client.mqttv3-1.2.2.jar`, in MATLAB using the `javaaddpath` command as done in `example.m`
