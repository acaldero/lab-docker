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

  * To start a work session with **3** containers:
    *  ./lab.sh start **3**

  * To get into container **1**:
    *  ./lab.sh bash **1**

  * Being in container **1**, to exit:
    *  exit

  * To stop the work session please use:
    *  ./lab.sh stop

  * Available options for debugging:
    * To check running containers:
      * ./lab.sh status
    * To get the containers internal IP addresses:
      * ./lab.sh network

<html>
  </td>
  <td>
</html>

  * To start **3** containers:
    * ./lab.sh start **3**
    * ./lab.sh status

  * Example of some work at container **1**:
    * ./lab.sh bash **1**
    * su - lab
    * ./data/quixote.sh
    * exit
    * exit

  * To stop the containers:
    * ./lab.sh stop

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

