# Ubuntu 22.04 LTS in Docker for Laboratories (v2.2)


# Ubuntu in Docker for Labs v2.2

## Using lab-docker

<html>
 <table>
  <tr>
  <th>Summary</th>
  <th>Example of work session</th>
  </tr>
  <tr>
  <td>
</html>

  * First time + "each time u22-dockerfile is updated":
    * ./lab.sh build

  * To start **3** containers:
    *  ./lab.sh start **3**

  * To get into container **2**:
    *  ./lab.sh bash **2**

  * Being within **2**, to exit:
    *  exit

  * To stop the containers:
    *  ./lab.sh stop

  * Available options for debugging:
    *  ./lab.sh status
    *  ./lab.sh network

<html>
  </td>
  <td>
</html>

  * To start:
    * To start a work session with **3** containers, please execute:
      *  ./lab.sh start **3**
    * To check the containers are running please use:
      *  ./lab.sh status
    * To get the containers internal IP address please use:
      *  ./lab.sh network

  * To work with some container:
    * To get into container **1** out of 3 please execute:
      *  ./lab.sh bash **1**
    * example of some work inside container **1** at /work directory:
      * su - lab
      * ssh localhost sudo /work/script/hosts.sh
      * ssh nodo2     sudo /work/script/hosts.sh
      * ssh nodo3     sudo /work/script/hosts.sh
      * ./data/eqdlm.sh
      * exit
    * To exit from container **1** please use:
      *  exit

  * To stop:
    * To stop the work session please use:
      *  ./lab.sh stop

<html>
  </td>
  </tr>
 </table>
</html>


**Please beware of**:
  * Any modification outside /work will be discarded on container stopping.
  * Please make a backup of your work "frequently".
  * You might need to use "sudo" before ./lab.sh if your user doesn't belong to the docker group (could be solved by using "sudo usermod -aG docker ${USER}")


## Authors
* :technologist: Félix García-Carballeira
* :technologist: Alejandro Calderón Mateos
* :technologist: José Rivadeneira López-Bravo (HDFS)
* :technologist: Diego Camarmas Alonso (XPN)
* :technologist: Elias del Pozo Puñal (XPN)
* :technologist: Saúl Alonso Monsalve

