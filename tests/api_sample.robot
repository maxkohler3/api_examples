*** Settings ***

Library                 RequestsLibrary
Resource                ../resources/keywords.robot

*** Test Cases ***

Open Library: Get a book based on ISBN 10 (GET)
    [Documentation]             Testing openlibrary public api - getting books via ISBN10
    ${var}=                     Create Session              openbookslib                http://openlibrary.org/api
    ${query}=                   Set Variable                bibkeys=ISBN:${ISBN_10}
    &{params}=                  Create Dictionary           format=json                 jscmd=data
    ${resp} =                   Get Request                 openbookslib                /books?${query}                      params=&{params}
    Should Be Equal As Strings                              ${resp.status_code}         200
    Log                         ${resp.text}

    # parse returned data to variables
    ${book_info}=               Get Field Value From Json                               ${resp.text}                ISBN:${ISBN_10}
    Log                         ${book_info}
    ${title}=                   Get From Dictionary         ${book_info}                title
    ${published}=               Get From Dictionary         ${book_info}                publish_date
    ${authors}=                 Get From Dictionary         ${book_info}                authors
    Log                         ${authors}
    ${main_author_name}=        Get From Dictionary         ${authors[0]}               name

    # Verify returned information against known values
    Should Be Equal As Strings                              ${title}                    ${EXPECTED_TITLE}
    Should Be Equal As Strings                              ${published}                ${EXPECTED_YEAR}
    Should Be Equal As Strings                              ${main_author_name}         ${EXPECTED_AUTHOR}


Test Case Expected Failure
    GoTo    https://fox.com
    ClickText    abcdefg
