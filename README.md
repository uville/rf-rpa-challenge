# rf-test-automation

A simple test automation project using robot framework to solve [RPA Challenge.](https://rpachallenge.com/)

## Description
* Download input data as xlsx
* Fill the input data to a form in the RPA Challenge site
* Take screenshot of browser to save results

## Getting Started

### Dependencies

* Python
* [Node.js](https://nodejs.org/en/download/package-manager)

### Installing

* Clone the repo
* Open terminal
* Change current working directory to the root of the cloned project
* Create virtaul environment ```python3 -m venv venv```
* Activate virtual environment ```source venv/bin/activate```
* Run ```pip install -r requirements.txt```
* Run ```rfbrowser init```

### Executing program

* Open terminal, activate venv and run
```
robot --pythonpath . --outputdir output tests
```
* To archive results to the root of the project, use ```${ARCHIVE_RESULTS}=    ${TRUE}```
* Otherwise, check the last result from ```output/browser/screenshot```

