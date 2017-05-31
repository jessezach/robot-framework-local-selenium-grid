# robot-framework-local-selenium-grid

- Ensure that you have docker installed and selenium/hub and node-chrome, node-firefox images in your local machine
- Download bash file, place it in your default path or add the path to file to bash profile
- Provide required permissions to the file chmod +x grid.sh
- cd to your robot test directory
- Run your usual robot tests using grid. Eg grid.sh -p 4 -d results --include=smoke -v BROWSER:gc Tests
- -p here means the number of processes. pass -p 1 will run test using pybot and -p 2 and above will trigger tests using pabot.
- Make sure you you have a BROWSER variable in your suite. Pass the value as gc or ff. Does not support chrome or firefox variables
- Make sure you have a REMOTE_URL variable passed to open browser keyword, to enable running tests on grid.
Eg open browser  about:blank  gc remote_url=${REMOTE_URL}

grid.sh will run hub and node containers based on browser and number of processes passed. It will run the tests on 
on the docker grid and stop/remove the containers once the tests are finished.
