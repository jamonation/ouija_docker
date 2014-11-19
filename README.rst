ouija development using Docker
######################################

The development environment relies on using a Python Virtualenv for tools and portability across platforms. Ensure that you have Python Pip installed for your platform before proceeding with these instructions.

Windows users can use the following guide. Specifically get Python installed and then use the get-pip.py installer once Python is working.
http://docs.python-guide.org/en/latest/starting/install/win/

OSX users can use the built in version of Python as long as Pip is available, or better, install Brew and Python:
http://docs.python-guide.org/en/latest/starting/install/osx/

Linux users should have Python already installed. Ensure Pip is installed via your package manager and you should be all set.

Linux based Ouija development with Docker:
==================================================

0. Visit https://docs.docker.com/installation/ and get docker up and running on your system
1. ``git clone https://github.com/jamonation/ouija_docker.git`` to a directory of your choosing
2. Run ``virtualenv ouija_docker`` or whatever directory you decided to clone into to setup the Python virtual environment
3. ``cd ouija_docker`` or into the name of the directory into which you cloned the git repository
4. ``source bin/activate`` to activate the virtual environment
5. ``git submodule update --init --recursive`` to pull forked ouija into your working directory
6. Run ``cd dockerfiles; ./build_docker_images.sh`` to create your local docker containers
7. Run ``fig up`` to start the collection of containers.
8. Visit http://localhost:8080/alerts.html in your browser


OSX based Ouija development with Docker:
==================================================

0. Visit https://docs.docker.com/installation/ and get boot2docker up and running on your Mac
1. Run ``boot2docker start`` in a terminal once it is installed. Ensure that you run the ``export DOCKER_HOST=...`` lines when prompted.
2. ``git clone https://github.com/jamonation/ouija_docker.git`` to a directory of your choosing
3. Run ``virtualenv ouija_docker`` or whatever directory you decided to clone into to setup the Python virtual environment
4. ``cd ouija_docker`` or into the name of the directory into which you cloned the git repository
5. ``source bin/activate`` to activate the virtual environment,
6. ``git submodule update --init --recursive`` to pull forked ouija into your working directory
7. Run ``cd dockerfiles; ./build_docker_images.sh`` to create your local docker containers
8. Run ``fig up`` to start the collection of containers.
9. Browse the address that the shell script noted.


Windows based Ouija development with Docker:
================================================

Windows users will need to install Vagrant and rely on a shim VM like boot2docker. boot2docker itself is not recommended because the commandline tools for docker are not integrated in the Windows version.

Examine and edit the Vagrantfile and vagrantconfig.yaml in this directory and edit to suit your needs.

More instructions as to how to use this shim VM will be forthcoming once the provisioning process is fully automated.
