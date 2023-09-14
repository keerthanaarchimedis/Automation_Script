*** Settings ***
Library           SeleniumLibrary
#Resource     ../RESOURCES/exceljsoncommon.robot
Resource     ../DATA/Day5-data.robot
Resource     ../DATA/Locator.robot
Resource    ../RESOURCES/D5-common 2.robot
Library    ExcelLibrary
Library    DataDriver    C:/Users/Automation/DATA/excel.xlsx    sheet
Library    JSONLibrary



*** Test Cases ***    

#A Login functionality Testcase 
   #  [Documentation]     TO Create a Login functionality Testcase and Extract data from Excel, JSON 
   # Login and Extract Data 
Login Test

    Open Browser    ${URL}    ${Ubrowser}  
    Maximize Browser Window
    ${name1}  ${psword}     Get Login Credentials
    Input Text         ${uname}    ${name1}
    Input Text    ${upassword}    ${psword}   
    Click Button     ${submit}  
    ${title}  Get Title  
    Page Should Contain    Congratulations student. You successfully logged in!
    Run Keyword If  "${title}" == "${expected_title}"  Login Succeed
    ...  ELSE  Login Failed
    Close Browser

*** Keywords ***    

Get Login Credentials
    ${excel_data}  Read Excel Cell    1    1
#    ${json_data}  Load JSON From File  ${json_data}
    ${URL}  Set Variable  ${json_data['URL']}
    ${expected_title}  Set Variable  ${json_data['expected_title']}
    ${row_index}  Evaluate  int(random.uniform(1, ${excel_data.rowcount}))
    ${name1}  Set Variable  ${excel_data.cell_value(${row_index}, 1)}
    ${psword}  Set Variable  ${excel_data.cell_value(${row_index}, 2)}  

Login Succeed
    Log  ${success_message}
    # Add verification steps here for a successful login
    
Login Failed
    Log  ${failure_message}
    # Add verification steps here for a failed login      