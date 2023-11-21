# Ubuntu 22.04 LTS in Docker for Laboratories (v2.2)

## Contents

 * [Using lab-docker](https://github.com/acaldero/lab-docker/blob/main/README.md#using-lab-docker)
 * [Some use cases with lab-docker](https://github.com/acaldero/lab-docker/blob/main/README.md#some-use-cases-with-lab-docker)


## Using lab-docker

<html>
 <table>
  <tr>
  <th>Action</th>
  <th>Command</th>
  </tr>

  <tr>
  <td> First time + "each time u22-dockerfile is updated"  </td>
  <td><pre>./lab.sh build</pre>
  </td>
  </tr>

  <tr>
  <td> To start a work session with <b>3</b> containers </td>
  <td><pre>./lab.sh start <b>3</b></pre>
  </td>
  </tr>

  <tr>
  <td> To get into container <b>1</b>  </td>
  <td><pre> ./lab.sh bash <b>1</b></pre>
  </td>
  </tr>

  <tr>
  <td> Being in container <b>1</b>, to exit  </td>
  <td>   <pre>exit</pre>  </td>
  </tr>

  <tr>
  <td>To stop the work session please use  </td>
  <td><pre>./lab.sh stop</pre>
  </td>
  </tr>

  <tr>
  <td>
</html>

  * Available options for debugging:
    * To check running containers:
    * To get the containers internal IP addresses:
  
<html>
  </td>
  <td>
</html>

  * Available options for debugging:
    * ./lab.sh status
    * ./lab.sh network

<html>
  </td>
  </tr>
 </table>
</html>

**Please beware of**:
  * Any modification outside /work will be discarded on container stopping.
  * Please make a backup of your work "frequently".
  * You might need to use "sudo" before ./lab.sh if your user doesn't belong to the docker group (could be solved by using "sudo usermod -aG docker ${USER}")


## Some use cases with lab-docker

<html>
 <table>
  <tr>
  <th>Session</th>
  <th>Example spark</th>
  <th>Example XPN</th>
  </tr>

  <tr>
  <td>
    To start <b>3</b> containers:
  </td>
  <td colspan="2">
   <pre>
./lab.sh start <b>3</b>
./lab.sh status
   </pre>
  </td>
  </tr>

  <tr>
  <td>
    Some work at container <b>1</b>:
  </td>
  <td>
   <pre>
./lab.sh bash <b>1</b>
source .profile
./data/quixote.sh
exit
   </pre>
  </td>
  <td>
   <pre>
./lab.sh bash <b>1</b>
source .profile
./data/xpn-1.sh
exit
   </pre>
  </td>
  </tr>

  <tr>
  <td>
     To stop the containers:
  </td>
  <td colspan="2">
   <pre>
./lab.sh stop
   </pre>
  </td>
  </tr>

 </table>
</html>


## Authors
* :technologist: Félix García-Carballeira
* :technologist: Alejandro Calderón Mateos
* :technologist: José Rivadeneira López-Bravo (HDFS)
* :technologist: Diego Camarmas Alonso (XPN)
* :technologist: Elias del Pozo Puñal (XPN)
* :technologist: Saúl Alonso Monsalve

