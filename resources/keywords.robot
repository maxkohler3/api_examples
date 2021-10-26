*** Settings ***

Library                  Collections

*** Variables ***

${ISBN_10}                      0201558025
${EXPECTED_TITLE}               Concrete mathematics
${EXPECTED_YEAR}                1994
${EXPECTED_AUTHOR}              Ronald L. Graham

*** Keywords ***

Get Field Value From Json
    [Documentation]        The value of json argument expected to be one dictionary
    [Arguments]            ${json}                ${field_name}
    ${object} =            Evaluate               json.loads("""${json}""")
    Log                    ${object}
    ${fieldValue} =        Get From Dictionary    ${object}                   ${field_name}
    [Return]               ${fieldValue}
