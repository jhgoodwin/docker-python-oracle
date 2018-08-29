# docker-python-oracle
docker with python and oracle instant client

# Tags

* docker-python-oracle:python3.5-oracle12.2
* docker-python-oracle:python3.6-oracle12.2
* docker-python-oracle:python3.6.6-oracle12.2

# How to build

* Download oracle linux client zips from http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

  * Be sure to get the Basic Light Package and the SDK
  * Place the files in the same folder as the Dockerfile

* Populate the variables in the following command:

  ```
  docker build -t python-oracle:AAA-BBB --build-arg="ORACLE_VERSION=CCC" --build-arg="PYTHON_VERSION=DDD" --build-arg="ORACLE_ZIP_INTERNAL_FOLDER=EEE" .
  ```

  * AAA - python version - eg 3.6
  * BBB - oracle short version - eg 12.2
  * CCC - oracle long version - eg 12.2.0.1.0
  * DDD - python version - eg 3.6 (be sure to match AAA)
  * EEE - oracle zip folder contents - eg instantclient_12_2
  * Full Example:
    ```
    docker build -t python-oracle:3.6-12.2 --build-arg="ORACLE_VERSION=12.2.0.1.0" --build-arg="PYTHON_VERSION=3.6" --build-arg="ORACLE_ZIP_INTERNAL_FOLDER=instantclient_12_2" .
    ```

# How to test

* Build the test container:

  ```
  docker build -t pythontest -f test.Dockerfile .
  ```

* Run a test (example):
  ```
  docker run --rm -e "ORACLE_CON_STR=YourUserNameHere/YourPasswordHere@IpAddressOrHostnameOfOracleServerHere/OracleInstanceNameHere" pythontest
  ```

* Result should be the version of the Oracle server.

## Other files in the folder:

* test.Dockerfile - simple container to prove the connection to Oracle works inside python
* main.py - python based test script.
* requirements.txt - python requirements for test script
* alpine.broken.Dockerfile - attempt to build the python container using alpine (reduces the container image size).

