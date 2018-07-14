# auto install
	./docker-install.sh
It will load the docker container and after that add a dvim command in your ~/.local/bin/.\
So you could use nvim docker like this :

	dvim
	dvim .
	dvim myFile
	dvim myPath/myFile

# manual install
	./compile.sh
It will build without cache the docker container from the Dockerfile.\
After that it will remove the old docker container and save the new one.\
Then it runs the auto install part with the new saved container.
