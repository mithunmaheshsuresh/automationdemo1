# automationdemo1
Installation

1.brew install python
2.brew install chromedriver

##PYTHON PACKAGES
  pip install robotframework 
  pip install robotframework-seleniumlibrary 
  pip install selenium
  pip install --upgrade RESTinstance
  
  Note : Incase, face with the error to uninstallation of 'six', please add this section 
  after RESTinstance during installation [ --ignore-installed six ]
Usage

Step 1: Clone the git repository

Step 2: How to run the robot test

Step 3: Go to terminal --> project folder --> type in the following command

Note : The variables and API requests can be populated in a separate file and referenced in the test case file as this would help in better maintenance. For now, it has been directly provided in the test case file

 
### Robot Framework Tests
Simple Example of how to run a test case:
```robot -d results tests/main.robot```


