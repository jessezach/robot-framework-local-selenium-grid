# robot-framework-local-selenium-grid

- Ensure that you have docker installed and selenium/hub and node-chrome, node-firefox images in your local machine
- Download bash file, place it in your default path or add the path to file to bash profile
- Provide required permissions to the file chmod +x grid.sh
- cd to your robot test directory
- Run your usual robot tests using grid. Eg grid.sh -p 4 -d results --include=smoke -v BROWSER:gc  -v REMOTE_URL:http://localhost:5700/wd/hub Tests
- -p here means the number of processes. Passing -p 1 will run test using pybot and -p 2 and above will trigger tests using pabot.
- Make sure you have a BROWSER variable in your suite and from pass it as an argument from command line. Pass the value as googlechrome gc, chrome, Chrome, ff, firefox etc
- Pass remote url http://localhost:5700/wd/hub from commandline.


grid.sh will run hub and node containers based on browser and number of processes passed. It will run the tests on 
on the docker grid and stop/remove the containers once the tests are finished.
You can check the grid at http://localhost:5700/grid/console on mac or ubuntu.
Tested on mac
