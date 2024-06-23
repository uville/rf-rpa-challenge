*** Settings ***
Documentation       This is a solution to resolve RPA Challenge using Robot Framework.

Library             Browser
Library             RequestsLibrary
Library             OperatingSystem
Library             resources/data_utils.py
Library             Collections
Library             DateTime


*** Variables ***
${URL}=                     https://rpachallenge.com
${INPUT_DATA_RESOURCE}=     assets/downloadFiles/challenge.xlsx
${BROWSER}=                 firefox
${HEADLESS}=                No
${FILE_NAME}=               input_data.xlsx
${SHEET_NAME}=              Sheet1
${INPUT_DATA_PATH}=         ${OUTPUT_DIR}${/}${FILE_NAME}
${ARCHIVE_RESULTS}=         ${TRUE}


*** Test Cases ***
Get Input Data
    ${response}=    Download Input Data
    Create Binary File    ${INPUT_DATA_PATH}    ${response.content}

Input Data To RPA Challenge Site
    Input Data To RPA Challenge Site


*** Keywords ***
Download Input Data
    [Documentation]    Get input data from RPA Challenge site using HTTP request.
    ${response}=    GET    ${URL}${/}${INPUT_DATA_RESOURCE}
    RETURN    ${response}

Input Data To RPA Challenge Site
    [Documentation]    Read data from XLSX file and input to RPA challenge site via Browser.
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Page    ${URL}
    @{people}=    Read XLSX_To_Dictionary    ${INPUT_DATA_PATH}    ${SHEET_NAME}
    Click    text="Start"
    FOR    ${person}    IN    @{people}
        Type Text    xpath=//input[@ng-reflect-name="labelFirstName"]    ${person}[First Name]
        Type Text    xpath=//input[@ng-reflect-name="labelLastName"]    ${person}[Last Name]
        Type Text    xpath=//input[@ng-reflect-name="labelCompanyName"]    ${person}[Company Name]
        Type Text    xpath=//input[@ng-reflect-name="labelRole"]    ${person}[Role in Company]
        Type Text    xpath=//input[@ng-reflect-name="labelAddress"]    ${person}[Address]
        Type Text    xpath=//input[@ng-reflect-name="labelEmail"]    ${person}[Email]
        Type Text    xpath=//input[@ng-reflect-name="labelPhone"]    ${person}[Phone Number]
        Click    xpath=//input[@type="submit"]
    END
    ${current_date}=    Get Current Date
    ${file_name}=    Set Variable    result_${current_date}
    ${image_format}=    Set Variable    .png
    Take Screenshot    ${file_name}
    IF    ${ARCHIVE_RESULTS} == ${TRUE}
        Copy File
        ...    ${OUTPUT_DIR}${/}browser${/}screenshot${/}${file_name}${image_format}
        ...    ${file_name}${image_format}
    END
